#' Data and variable shiny app
#'
#' @description
#' This module function comes from the [Modules inside of modules](https://mastering-shiny.org/scaling-modules.html#modules-inside-of-modules) section of Mastering Shiny.
#'
#' @param filter limit the options of built-in datasets (i.e., `is.data.frame` or `is.matrix`)
#'
#' @return shiny app
#' @export
#'
#' @importFrom shiny sidebarLayout sidebarPanel mainPanel verbatimTextOutput
#' @importFrom shiny renderPrint shinyApp
selectDataVarApp <- function(filter = is.numeric) {
  ui <- fluidPage(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        selectDataVarUI("var")),
      shiny::mainPanel(
        shiny::verbatimTextOutput("out"))
    )
  )
  server <- function(input, output, session) {
    var <- selectDataVarServer("var", filter)
    output$out <- shiny::renderPrint(var(), width = 40)
  }
  shiny::shinyApp(ui, server)
}
