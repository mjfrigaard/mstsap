#' Variable input server module
#'
#' @description
#' This module function comes from the [Server inputs](https://mastering-shiny.org/scaling-modules.html#server-inputs) section of Mastering Shiny.
#'
#' @section stopifnot():
#'
#' *check that each input to your module is either reactive or constant. If you don’t, and the user supplies the wrong type, they’ll get a cryptic error message. You can make the life of module user much easier with a quick and dirty call to `stopifnot()`*
#'
#' @param id module id
#' @param data reactive data object to retrieve variables from
#' @param filter passed to `find_vars()`, i.e., the type of variables to list (*this will be set by the caller of the module, so doesn’t need to be reactive*
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
