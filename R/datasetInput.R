#' Data input module
#'
#' @param id module id
#' @param filter limit the options of built-in datasets (i.e., `is.data.frame` or `is.matrix`)
#'
#' @description
#' *I use (the `filter`) argument to optionally filter the objects found in the datasets package, then create a `selectInput()`.*
#'
#'
#' This module function comes from the [Getting started: UI input + server output](https://mastering-shiny.org/scaling-modules.html#getting-started-ui-input-server-output) section of Mastering Shiny.
#'
#' @return list of data object names
#' @export
#'
#' @importFrom shiny selectInput NS
datasetInput <- function(id, filter = NULL) {

  names <- ls("package:datasets")
  if (!is.null(filter)) {
    data <- lapply(names, get, "package:datasets")
    names <- names[vapply(data, filter, logical(1))]
  }

  shiny::selectInput(
    shiny::NS(id, "dataset"),
    label = "Pick a dataset",
    choices = names)
}
