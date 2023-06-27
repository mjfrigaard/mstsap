#' Dataset app
#'
#' @param filter limit the options of built-in datasets (i.e., `is.data.frame`
#' or `is.matrix`)
#'
#' @description
#' This module function comes from the [Getting started: UI input + server output](https://mastering-shiny.org/scaling-modules.html#getting-started-ui-input-server-output) section of Mastering Shiny.
#'
#' @section Reactive values:
#' The only changes to this application include a call to `verbatimTextOutput()` in the UI, which renders the contents of `reactiveValuesToList()` in the server. The `renderPrint()` output contains the `inputId`s for the modules in the application.
#'
#' @return shiny application
#' @export
#'
#' @importFrom shiny tableOutput renderTable shinyApp
#' @importFrom shiny reactiveValuesToList renderPrint verbatimTextOutput
datasetApp <- function(filter = NULL) {
  ui <- shiny::fluidPage(

    datasetInput("dataset", filter = filter),

    shiny::tableOutput("data"),
    shiny::verbatimTextOutput("vals")

  )

  server <- function(input, output, session) {

    data <- datasetServer("dataset")

    output$data <- shiny::renderTable(head(data()))

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                              all.names = TRUE)
      print(x, width = 30, max.levels = NULL)
    }, width = 30)

  }

  shiny::shinyApp(ui, server)

}
