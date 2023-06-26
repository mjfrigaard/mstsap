#' Find variables
#'
#' This function comes from the [Case study: selecting a numeric variable](https://mastering-shiny.org/scaling-modules.html#case-study-selecting-a-numeric-variable) section of Mastering Shiny.
#'
#' @param data reactive data object to retrieve variables from
#' @param filter which variables to list. *This will be set by the caller of the module, so doesn’t need to be reactive*
#'
#' @return variable names
#' @export
#'
find_vars <- function(data, filter) {
  stopifnot(is.data.frame(data))
  stopifnot(is.function(filter))
  names(data)[vapply(data, filter, logical(1))]
}
