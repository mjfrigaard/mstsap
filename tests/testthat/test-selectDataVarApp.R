shiny::testServer(DataVarServer, expr = {

  testthat::expect_true(object = is.reactive(var))
  test_cmt("selectDataVarApp", "is.reactive(var)")

})
