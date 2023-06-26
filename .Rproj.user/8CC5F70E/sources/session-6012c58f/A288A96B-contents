#' Variable input UI module
#'
#' @description
#' "*allows the user to select variables of specified type from a given reactive dataset.*"
#'
#' This module function comes from the [Case study: selecting a numeric variable](https://mastering-shiny.org/scaling-modules.html#case-study-selecting-a-numeric-variable) section of Mastering Shiny.
#'
#' @param id module id
#'
#'
#' @return module UI variable input
#' @export
#'
#' @importFrom shiny selectInput NS
selectVarInput <- function(id) {

  shiny::selectInput(
    shiny::NS(id, "var"), label = "Variable", choices = NULL)

}
