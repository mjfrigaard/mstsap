library(shiny)
library(gargoyle)
source("modules.R")
source("appUI.R")
source("appServer.R")

demoApp <- function() {
  shiny::shinyApp(
    ui = appUI,
    server = appServer
  )
}
demoApp()
