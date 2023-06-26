#' Data server module
#'
#' @param id module id
#'
#'
#' @description
#' *we just use `get()` to retrieve the dataset with its name...Here we take advantage of the usual rule that last expression processed in the function becomes the return value. This value should always be a reactive*
#'
#' This module function comes from the [Getting started: UI input + server output](https://mastering-shiny.org/scaling-modules.html#getting-started-ui-input-server-output) section of Mastering Shiny.
#'
#'
#' @return reactive data object from datasets package
#' @export
#'
#' @importFrom shiny moduleServer reactive
datasetServer <- function(id) {

  shiny::moduleServer(id, function(input, output, session) {

    shiny::reactive({
          get(input$dataset, "package:datasets")
        })

  })
}
