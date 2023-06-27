#' Data and variable shiny UI (version 2)
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
        shiny::verbatimTextOutput("out"),
        shiny::verbatimTextOutput("vals")
        )
    )
  )
}

#' Data and variable shiny server (version 2)
#'
#' @description
#' This module function comes from the [Modules inside of modules](https://mastering-shiny.org/scaling-modules.html#modules-inside-of-modules) section of Mastering Shiny.
#'
#' @param input shiny server argument
#' @param output shiny server argument
#' @param session shiny server argument
#' @param filter variable filter (i.e., `is.numeric` or `is.character`)
#'
#' @return shiny app
#' @export
#'
#' @importFrom shiny renderPrint shinyApp
DataVarServer <- function(input, output, session, filter = is.numeric) {
  var <- selectDataVarServer("var", filter = filter)
  output$out <- shiny::renderPrint(var(), width = 40)
    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                              all.names = TRUE)
      print(x)
    })
}

#' Data and variable shiny app (version 2)
#'
#' @description
#' This module function comes from the [Modules inside of modules](https://mastering-shiny.org/scaling-modules.html#modules-inside-of-modules) section of Mastering Shiny.
#'
#'
#' @return shiny app
#' @export
#'
selectDataVarApp2 <- function() {
  shiny::shinyApp(ui = DataVarUI, server = DataVarServer)
}

#' Data and variable shiny app
#'
#' @description
#' This module function comes from the [Modules inside of modules](https://mastering-shiny.org/scaling-modules.html#modules-inside-of-modules) section of Mastering Shiny.
#'
#'
#' @section Reactive values:
#' The only changes to this application include a call to `verbatimTextOutput()` in the UI, which renders the contents of `reactiveValuesToList()` in the server. The `renderPrint()` output contains the `inputId`s for the modules in the application.
#'
#' @param filter variable filter (i.e., `is.numeric` or `is.character`)
#'
#' @return shiny app
#' @export
#'
#' @importFrom shiny fluidPage sidebarLayout sidebarPanel
#' @importFrom shiny mainPanel tags verbatimTextOutput
#' @importFrom shiny renderPrint reactiveValuesToList
#' @importFrom shiny shinyApp
selectDataVarApp <- function(filter = is.numeric) {
  options(width = 65)
  ui <- shiny::fluidPage(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        selectDataVarUI("var")
        ),
      shiny::mainPanel(
        shiny::tags$br(),
        shiny::verbatimTextOutput("out"),
        shiny::verbatimTextOutput("vals")
        )
    )
  )
  server <- function(input, output, session) {
    var <- selectDataVarServer("var", filter)
    output$out <- shiny::renderPrint(var())

    output$vals <- shiny::renderPrint({
      x <- shiny::reactiveValuesToList(input,
                              all.names = TRUE)
      print(x)
    })
  }
  shiny::shinyApp(ui, server)
}
