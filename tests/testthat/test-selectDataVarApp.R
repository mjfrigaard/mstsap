shiny::testServer(DataVarServer, expr = {

  testthat::expect_true(object = is.reactive(var))
  cat("\n\tselectDataVarApp: is.reactive(var)", "\n")

})
