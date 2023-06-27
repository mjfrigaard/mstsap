#' Data and variable input server module
#'
#' @description
#' This module function comes from the [Modules inside of modules](https://mastering-shiny.org/scaling-modules.html#modules-inside-of-modules) section of Mastering Shiny.
#'
#' @param id module id
#' @param filter limit the options of built-in datasets (i.e., `is.data.frame` or `is.matrix`)
#'
#' @return shiny server function
#' @export
#'
#' @importFrom shiny moduleServer
selectDataVarServer <- function(id, filter = is.numeric) {

  shiny::moduleServer(id, function(input, output, session) {

    data <- datasetServer("data")

    var <- selectVarServer("var", data, filter = filter)

    var

  })
}
