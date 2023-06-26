# appServer ---------------------------------------------------------------
appServer <- function(input, output, session) {
      gargoyle::init("tf_ds", "tf_cols", "tf_plot")
      env_vars <- new.env()

      # pkg module ----
      shiny::observe({
        env_vars$pkg <- mod_pkg_server("pkg")
        return(env_vars$pkg)
        gargoyle::trigger("tf_ds")
      }) |>
        shiny::bindEvent(env_vars)

      # dataset module ----
      shiny::observe({
        env_vars$dataset <- mod_ds_server("ds",
          pkg_input = env_vars$pkg
        )
        return(env_vars$dataset)
        gargoyle::trigger("tf_cols")
      }) |>
        shiny::bindEvent(
          gargoyle::watch("tf_ds")
        )

      # column select module ----
      shiny::observe({
        env_vars$plot_values <- mod_cols_server(
          id = "cols",
          ds_input = env_vars$dataset
        )
        return(env_vars$plot_values)
        gargoyle::trigger("tf_plot")
      }) |>
        shiny::bindEvent(
          gargoyle::watch("tf_cols")
        )

      # plot module ----
      shiny::observe({
        mod_graph_server("plot",
          ds_input = env_vars$dataset,
          col_inputs = env_vars$plot_values
        )
      }) |>
        shiny::bindEvent(
          gargoyle::watch("tf_plot")
        )
}
