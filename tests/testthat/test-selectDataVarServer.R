shiny::testServer(selectDataVarServer, args = list(filter = is.numeric), expr = {
  testthat::expect_true(
    object = is.reactive(data))
  test_cmt("selectDataVarServer", "is.reactive(data)")

  testthat::expect_true(
    object = is.reactive(var))
  test_cmt("selectDataVarServer", "is.reactive(var)")

})
