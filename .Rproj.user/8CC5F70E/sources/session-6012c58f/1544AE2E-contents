#' Variable input server module
#'
#' @description
#' This module function comes from the [Server inputs](https://mastering-shiny.org/scaling-modules.html#server-inputs) section of Mastering Shiny.
#'
#' @param id module id
#' @param data reactive data object to retrieve variables from
#' @param filter passed to `find_vars()`, i.e., the variables to list. *This will be set by the caller of the module, so doesn’t need to be reactive*
#'
#' @return shiny server function
#' @export
#'
#' @importFrom shiny moduleServer observe updateSelectInput
#' @importFrom shiny bindEvent reactive is.reactive
selectVarServer <- function(id, data, filter = is.numeric) {

  stopifnot(shiny::is.reactive(data))
  stopifnot(!shiny::is.reactive(filter))

  shiny::moduleServer(id, function(input, output, session) {

    shiny::observe({
      shiny::updateSelectInput(
        session = session,
        inputId = "var",
        choices = find_vars(data(), filter))
    }) |>
      shiny::bindEvent(data())

    shiny::reactive(data()[[input$var]])

  })

}
