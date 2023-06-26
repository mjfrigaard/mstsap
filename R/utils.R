#' Inverted versions of `%in%`
#'
#' @export
#'
#' @examples
#' 1 %nin% 1:10
#' "A" %nin% 1:10
`%nin%` <- function(x, table) {
  match(x, table, nomatch = 0) == 0
}


#' Create plot_inputs() list (for debugging and testing)
#'
#' @return list of plot inputs
#'
#' @importFrom janitor clean_names
#' @importFrom purrr set_names
#'
#' @export get_plot_inputs_list
#'
#' @examples
#' get_plot_inputs_list(pkg = "palmerpenguins", ds = "penguins")
get_plot_inputs_list <- function(pkg, ds) {
    require(palmerpenguins)
    require(NHANES)
    # get packages with data.frames/tibbles
    all_pkgs <- get_pkgs_with_dfs()
    # select package
    pkg_select <- all_pkgs[pkg]
    # select dataset from package
    ds_pkgs <- get_pkg_df_names(pkg_select)
    names(ds_pkgs) <- ds_pkgs
    ds_select <- ds_pkgs[ds]
    # get dataset
    dataset <- janitor::clean_names(
      get(x = ds_select, pos = paste0("package:", pkg_select)))
    # rename to ds_input
    ds_input <- dataset
    # get numeric x var
    x_var <- pull_numeric_cols(ds_input)[1]
    # get numeric y var
    y_var <- pull_numeric_cols(ds_input)[2]
    # get color (binary) var
    col_var <- pull_binary_cols(ds_input)[1]
    # get facet var
    facet_var <- pull_facet_cols(ds_input)[1]
    # set size
    size <- 2L
    # set alpha
    alpha <- 0.75
    # create plot_inputs
    plot_values <- list(
      'df' = ds_input,
      'x_var' = x_var,
      'y_var' = y_var,
      'col_var' = col_var,
      'facet_var' = facet_var,
      'size' = size,
      'alpha' = alpha
      )
    plot_inputs <- plot_values
    return(plot_inputs)
}

#' Grouped variable summary
#'
#' @param data tibble (unquoted)
#' @param grp_var group variable (as quoted string)
#' @param var variable to summarize (as quoted string)
#'
#' @return tibble with summary statistics
#'
#' @export
#'
#' @importFrom dplyr group_by summarise n
#'
#' @examples
#' require(palmerpenguins)
#' grp_var_sum(
#' data = palmerpenguins::penguins,
#' grp_var = "island",
#' var = "bill_length_mm")
grp_var_sum <- function(data, grp_var, var) {
  data |>
    dplyr::group_by(.data[[ grp_var ]]) |>
      dplyr::summarise(
        "Mean: {{var}}" := mean(x = .data[[ var ]], na.rm = TRUE),
        "SD: {{var}}" := sd(x = .data[[ var ]], na.rm = TRUE),
        "N: {{var}}" := dplyr::n())
}

#' Deconstruct R objects
#'
#' @param x R object passed to `dput()`
#' @param quotes include quotes in the output
#' @param console logical, used in the console? If `FALSE`, then output is printed
#' with `base::noquote()`. If `TRUE`, output is returned with `cat()`
#'
#' @return Deparsed object
#' @export deconstruct
#'
#'
#' @examples
#' x <- deconstruct(names(mtcars), return = TRUE)
#' x
#' deconstruct(names(mtcars))
deconstruct <- function(x, return = FALSE, quote = TRUE) {
  raw_obj <- capture.output(dput(x, control = "all"))
  if (isFALSE(quote)) {
    obj_noquote <- gsub(pattern = '"', replacement = "", x = raw_obj)
    decon_noquote <- paste0(obj_noquote, collapse = "")
    decon_obj <- gsub("\\s+", " ", decon_noquote)
  } else {
    obj_quote <- gsub(pattern = '"', replacement = "'", x = raw_obj)
    decon_quote <- paste0(obj_quote, collapse = "")
    decon_obj <- gsub("\\s+", " ", decon_quote)
  }
  if (isFALSE(return)) {
    base::cat(decon_obj)
  } else {
    return(noquote(decon_obj))
  }
}

#' Make UI inputs
#'
#' @description
#' This is meant to be used in the console--it generates the code for assigning
#' the elements from a list into a collection of vectors.
#'
#' @param app_data dataset for app (`data.frame` or `tibble`)
#'
#' @return zeallot assignment (`%<-%`) with input character vector on LHS and
#'    list of names by type on the RHS
#'
#' @export make_ui_inputs
#'
#' @examples
#' require(palmerpenguins)
#' make_ui_inputs(palmerpenguins::penguins)
#' require(zeallot)
#' c(double_vars, integer_vars, factor_vars) %<-%
#'   list(
#'     double_vars = c("bill_length_mm", "bill_depth_mm"),
#'     integer_vars = c("flipper_length_mm", "body_mass_g", "year"),
#'     factor_vars = c("species", "island", "sex")
#'   )
#' double_vars
#' integer_vars
#' factor_vars
make_ui_inputs <- function(app_data) {
  ui_inputs <- names(col_type_list(df = app_data))
  lhs_out <- deconstruct(x = ui_inputs, return = TRUE, quote = FALSE)
  zeallot_operator <- deconstruct(x = "%<-%", return = TRUE, quote = FALSE)
  rhs_out <- deconstruct(x = col_type_list(df = app_data), return = TRUE)
  cat(lhs_out, zeallot_operator, rhs_out)
}
# https://stackoverflow.com/questions/28221755/how-to-split-a-r-data-frame-into-vectors-unbind

#' Get package datasets metadata
#'
#' @param package name of package (a character vector)
#' @param allClass logical (include all classes of data?)
#' @param incPackage logical (include package name in result?)
#' @param maxTitle maximum length of dataset title
#'
#' @description
#' This is a variation on the `vcdExtra::datasets()` function.
#' Read more here:
#' https://github.com/friendly/vcdExtra/blob/master/R/datasets.R
#'
#'
#' @return `data.frame` with 6 variables (`dataset`, `title`, `dimensions`,
#' `obs`, `vars`, `display_title`)
#'
#' @export get_pkg_datameta
#'
#' @importFrom tibble as_tibble
#' @importFrom dplyr select mutate
#' @importFrom tidyr separate
#'
#' @examples
#' require(tidyr)
#' get_pkg_datameta("tidyr")
get_pkg_datameta <- function(package, allClass = FALSE,
                     incPackage = length(package) > 1,
                     maxTitle = NULL) {
  # make sure requested packages are available and loaded
  for (i in seq_along(package)) {
    if (!isNamespaceLoaded(package[i])) {
      if (requireNamespace(package[i], quietly = TRUE)) {
        cat(paste("Loading package:", package[i], "\n"))
      } else {
        stop(paste("Package", package[i], "is not available"))
      }
    }
  }
  dsitems <- data(package = package)$results
  wanted <- c("Package", "Item", "Title")

  ds <- as.data.frame(dsitems[, wanted], stringsAsFactors = FALSE)

  getData <- function(x, pkg) {
    objname <- gsub(" .*", "", x)
    e <- loadNamespace(pkg)
    if (!exists(x, envir = e)) {
      dataname <- sub("^.*\\(", "", x)
      dataname <- sub("\\)$", "", dataname)
      e <- new.env()
      data(list = dataname, package = pkg, envir = e)
    }
    get(objname, envir = e)
  }

  getDim <- function(i) {
    data <- getData(ds$Item[i], ds$Package[i])
    if (is.null(dim(data))) length(data) else paste(dim(data), collapse = "x")
  }
  getClass <- function(i) {
    data <- getData(ds$Item[i], ds$Package[i])
    cl <- class(data)
    if (length(cl) > 1 && !allClass) cl[length(cl)] else cl
  }

  ds$dim <- unlist(lapply(seq_len(nrow(ds)), getDim))

  ds$class <- unlist(lapply(seq_len(nrow(ds)), getClass))
  if (!is.null(maxTitle)) ds$Title <- substr(ds$Title, 1, maxTitle)
  if (incPackage) {
    ds[c("Package", "Item", "class", "dim", "Title")]
  } else {
    ds[c("Item", "class", "dim", "Title")]
  }
  # named cols
  ds_cols <- dplyr::select(
    .data = ds,
    package = Package,
    dataset = Item,
    title = Title,
    dimensions = dim
  )
  # observations and variables
  ds_obs_vars <- tidyr::separate(
    data = ds_cols,
    col = dimensions,
    into = c("obs", "vars"),
    sep = "x",
    remove = TRUE
  )
  # tibble
  tbl_out <- tibble::as_tibble(ds_obs_vars)
  return(tbl_out)
}
