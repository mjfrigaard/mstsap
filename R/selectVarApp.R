#' Select Variable App
#'
#' @param filter variables to list. *This will be set by the caller of the module, so doesn’t need to be reactive*
#'
#' @description
#' This module function comes from the [Case study: selecting a numeric variable](https://mastering-shiny.org/scaling-modules.html#case-study-selecting-a-numeric-variable) section of Mastering Shiny.
#'
#' @section Reactive values:
#' The only changes to this application include a call to `verbatimTextOutput()` in the UI, which renders the contents of `reactiveValuesToList()` in the server. The `renderPrint()` output contains the `inputId`s for the modules in the application.
#'
#'
#' @return shiny app
#' @export
#'
#' @importFrom shiny verbatimTextOutput renderPrint shinyApp
selectVarApp <- function(filter = is.numeric) {
  ui <- shiny::fluidPage(
    datasetInput("data", is.data.frame),
    selectVarInput("var"),
    shiny::verbatimTextOutput("out"),
    shiny::verbatimTextOutput("vals")
  )
  server <- function(input, output, session) {
    data <- datasetServer("data")
    var <- selectVarServer("var", data, filter = filter)
    output$out <- shiny::renderPrint(var())

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                              all.names = TRUE)
      print(x)
    })
  }

  shiny::shinyApp(ui, server)
}
