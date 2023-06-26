library(shiny)
require(mstsap)
library(gargoyle)


# mod_pkg -----------------------------------------------------------------
mod_pkg_ui <- function(id) {
  df_pkgs <- get_pkgs_with_dfs()
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::selectInput(ns("pkg"),
      label = "Pick a package",
      choices = df_pkgs
    )
  )
}

mod_pkg_server <- function(id) {
  shiny::moduleServer(id, function(input, output, session) {
    shiny::reactive({
      shiny::req(c(input$pkg))
      input$pkg
    })
  })
}


# mod_ds ------------------------------------------------------------------
mod_ds_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::selectInput(ns("dataset"),
      label = "Pick a dataset",
      choices = NULL
    )
  )
}

mod_ds_server <- function(id, pkg_input) {
  shiny::moduleServer(id, function(input, output, session) {
    shiny::observe({
      df_names <- get_pkg_df_names(pkg = pkg_input())
      shiny::updateSelectInput(
        session = session,
        inputId = "dataset",
        choices = df_names,
        selected = df_names[1]
      )
    }) |>
      shiny::bindEvent(pkg_input(), ignoreNULL = TRUE)

    shiny::reactive({
      shiny::req(input$dataset, pkg_input())
      get(
        x = input$dataset,
        pos = paste0("package:", pkg_input())
      )
    }) |>
      shiny::bindCache(c(pkg_input(), input$dataset)) |>
      shiny::bindEvent(input$dataset)
  })
}


# mod_cols ----------------------------------------------------------------

mod_cols_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      column(
        width = 6,
        shiny::selectInput(
          inputId = ns("x"),
          label = "X variable:",
          choices = NULL
        ),
        shiny::selectInput(
          inputId = ns("y"),
          label = "Y variable:",
          choices = NULL
        ),
        shiny::selectInput(
          inputId = ns("col"),
          label = "Color variable:",
          choices = NULL
        ),
        shiny::selectInput(
          inputId = ns("facet"),
          label = "Facet variable:",
          choices = NULL
        )
      ),
      shiny::column(
        width = 6,
        shiny::sliderInput(
          inputId = ns("alpha"),
          label = "Point opacity:",
          min = 0, max = 1, step = 0.1,
          value = 0.7
        ),
        shiny::sliderInput(
          inputId = ns("size"),
          label = "Point size:",
          min = 0, max = 5,
          step = 0.2,
          value = 3
        )
      )
    )
  )
}

mod_cols_server <- function(id, ds_input) {
  shiny::moduleServer(id, function(input, output, session) {
    pkg_data <- shiny::reactive({
      janitor::clean_names(ds_input())
    }) |>
      shiny::bindEvent(ds_input(),
        ignoreNULL = TRUE
      )

    shiny::observe({
      num_vars <- pull_numeric_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "x",
        choices = num_vars,
        selected = num_vars[1]
      )
    }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    shiny::observe({
      num_vars <- pull_numeric_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "y",
        choices = num_vars,
        selected = num_vars[2]
      )
    }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    shiny::observe({
      col_vars <- pull_binary_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "col",
        choices = col_vars,
        selected = col_vars[1]
      )
    }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    shiny::observe({
      facet_vars <- pull_facet_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "facet",
        choices = facet_vars,
        selected = facet_vars[1]
      )
    }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    return(
      shiny::reactive({
        shiny::req(c(
          ds_input(),
          input$x, input$y,
          input$col, input$facet,
          input$alpha, input$size
        ))

        list(
          df = janitor::clean_names(ds_input()),
          x_var = input$x,
          y_var = input$y,
          col_var = input$col,
          facet_var = input$facet,
          alpha = input$alpha,
          size = input$size
        )
      }) |>
        # bind to cache
        shiny::bindCache(c(
          ds_input(),
          input$x, input$y,
          input$col, input$facet,
          input$alpha, input$size
        )) |>
        # bind to event
        shiny::bindEvent(c(
          ds_input(),
          input$x, input$y,
          input$col, input$facet,
          input$alpha, input$size
        ))
    )
  })
}


# mod_graph ----------------------------------------------------------------
mod_graph_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::plotOutput(outputId = ns("graph"))
      )
    ),
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::verbatimTextOutput(ns("vals"))
      )
    )
  )
}

mod_graph_server <- function(id, ds_input, col_inputs) {
  shiny::moduleServer(id, function(input, output, session) {
    plot_data <- shiny::reactive({
      if (sum(col_inputs() %in% names(janitor::clean_names(ds_input()))) == 4) {
        list(
          df = janitor::clean_names(ds_input()),
          x_var = col_inputs()$x_var,
          y_var = col_inputs()$y_var,
          col_var = col_inputs()$col_var,
          facet_var = col_inputs()$facet_var,
          alpha = col_inputs()$alpha,
          size = col_inputs()$size
        )
      } else {
        NULL
      }
    }) |>
      shiny::bindEvent(c(ds_input(), col_inputs()),
        ignoreNULL = TRUE
      )

    shiny::observe({
      output$graph <- shiny::renderPlot({
        shiny::req(plot_data())
        gg_color_scatter_facet(
          df = janitor::clean_names(ds_input()),
          x_var = col_inputs()$x_var,
          y_var = col_inputs()$y_var,
          col_var = col_inputs()$col_var,
          facet_var = col_inputs()$facet_var,
          alpha = col_inputs()$alpha,
          size = col_inputs()$size
        )
      })
    }) |>
      shiny::bindEvent(plot_data(),
        ignoreNULL = TRUE
      )
  })
}
