#' Data and variable input UI module
#'
#' @description
#' This module function comes from the [Modules inside of modules](https://mastering-shiny.org/scaling-modules.html#modules-inside-of-modules) section of Mastering Shiny.
#'
#' @param id module id
#'
#'
#' @return shiny UI function
#' @export
#'
#' @importFrom shiny tagList
selectDataVarUI <- function(id) {

  shiny::tagList(

    datasetInput(NS(id, "data"), filter = is.data.frame),

    selectVarInput(NS(id, "var"))

  )
}
