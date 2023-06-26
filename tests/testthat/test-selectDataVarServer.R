shiny::testServer(selectDataVarServer, args = list(filter = is.numeric), expr = {
  testthat::expect_true(
    object = is.reactive(data))
  cat("\n\tselectDataVarServer: is.reactive(data)")

  testthat::expect_true(
    object = is.reactive(var))
  cat("\n\tselectDataVarServer: is.reactive(var)", "\n")

})
