#' Dataset app
#'
#' @param filter limit the options of built-in datasets (i.e., `is.data.frame`
#' or `is.matrix`)
#'
#' @description
#' This module function comes from the [Getting started: UI input + server output](https://mastering-shiny.org/scaling-modules.html#getting-started-ui-input-server-output) section of Mastering Shiny.
#'
#' @return shiny application
#' @export
#'
#' @importFrom shiny tableOutput renderTable shinyApp
datasetApp <- function(filter = NULL) {
  ui <- fluidPage(

    datasetInput("dataset", filter = filter),

    shiny::tableOutput("data")

  )

  server <- function(input, output, session) {

    data <- datasetServer("dataset")

    output$data <- shiny::renderTable(head(data()))

  }

  shiny::shinyApp(ui, server)

}
