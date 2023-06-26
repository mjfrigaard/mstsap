shiny::testServer(selectVarServer,
  args = list(data = reactive(datasets::mtcars), filter = is.numeric), expr = {
  testthat::expect_true(
    object = is.data.frame(data()))
  cat("\n\tselectVarServer: data()")

  expect_equal(object = names(data()),
    expected = names(datasets::mtcars))
  cat("\n\tselectVarServer: names()", "\n")

})
