#' Data and variable shiny UI
#'
#' @description
#' This module function comes from the [Modules inside of modules](https://mastering-shiny.org/scaling-modules.html#modules-inside-of-modules) section of Mastering Shiny.
#'
#' @return shiny UI function
#' @export
#'
#' @importFrom shiny sidebarLayout sidebarPanel mainPanel verbatimTextOutput
DataVarUI <- function() {
  shiny::fluidPage(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        selectDataVarUI("var")),
      shiny::mainPanel(
        shiny::verbatimTextOutput("out"))
    )
  )
}

#' Data and variable shiny server
#'
#' @description
#' This module function comes from the [Modules inside of modules](https://mastering-shiny.org/scaling-modules.html#modules-inside-of-modules) section of Mastering Shiny.
#'
#' @param input shiny server argument
#' @param output shiny server argument
#' @param session shiny server argument
#' @param filter limit the options of built-in datasets (i.e., `is.data.frame` or `is.matrix`)
#'
#' @return shiny app
#' @export
#'
#' @importFrom shiny renderPrint shinyApp
DataVarServer <- function(input, output, session, filter = is.numeric) {
  var <- selectDataVarServer("var", filter = filter)
  output$out <- shiny::renderPrint(var(), width = 40)
}

#' Data and variable shiny app
#'
#' @description
#' This module function comes from the [Modules inside of modules](https://mastering-shiny.org/scaling-modules.html#modules-inside-of-modules) section of Mastering Shiny.
#'
#'
#' @return shiny app
#' @export
#'
selectDataVarApp <- function() {
  shiny::shinyApp(ui = DataVarUI, server = DataVarServer)
}
