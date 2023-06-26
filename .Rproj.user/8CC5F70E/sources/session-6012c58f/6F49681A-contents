#' Select Variable App
#'
#' @param filter variables to list. *This will be set by the caller of the module, so doesn’t need to be reactive*
#'
#' @description
#' This module function comes from the [Case study: selecting a numeric variable](https://mastering-shiny.org/scaling-modules.html#case-study-selecting-a-numeric-variable) section of Mastering Shiny.
#'
#' @return shiny app
#' @export
#'
#' @importFrom shiny verbatimTextOutput renderPrint shinyApp
selectVarApp <- function(filter = is.numeric) {
  ui <- fluidPage(
    datasetInput("data", is.data.frame),
    selectVarInput("var"),
    shiny::verbatimTextOutput("out")
  )
  server <- function(input, output, session) {
    data <- datasetServer("data")
    var <- selectVarServer("var", data, filter = filter)
    output$out <- shiny::renderPrint(var())
  }

  shiny::shinyApp(ui, server)
}
