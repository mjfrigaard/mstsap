# appUI -------------------------------------------------------------------
appUI <- function() {
  require(janitor)
  require(palmerpenguins)
  require(NHANES)
      shiny::tagList(
        shiny::fluidPage(
          title = "gargoyle App",
          shiny::sidebarLayout(
            shiny::sidebarPanel(
              # pkg input ----
              mod_pkg_ui("pkg"),
              # dataset input  ----
              mod_ds_ui("ds")
            ),
            shiny::mainPanel(
              shiny::h3(shiny::code("gargoyle"),"App"),
              shiny::tags$br(),
              # column inputs ----
              mod_cols_ui(id = "cols"),
              # graph outputs  ----
              mod_graph_ui("plot")
            )
          )
        )
      )
    }
