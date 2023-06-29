shiny::testServer(selectVarServer,

  args = list(data = reactive(datasets::mtcars),
              filter = is.numeric), expr = {

  # args = list(data = datasets::mtcars,
  #             filter = is.numeric), expr = {

  testthat::expect_true(
    object = is.reactive(data))
  test_cmt("selectVarServer", "is.reactive(data())")
})

shiny::testServer(selectVarServer,
  args = list(data = reactive(datasets::chickwts),
              filter = is.numeric), expr = {
  testthat::expect_equal(
    object = find_vars(data(), is.factor),
    expected = "feed")
  test_cmt("selectVarServer", "find_vars()")
})

shiny::testServer(selectVarServer,
  args = list(data = reactive(datasets::chickwts),
              filter = is.numeric), expr = {

  session$setInputs(var = "weight")
  testthat::expect_equal(object = input$var,
      expected = "weight")
  test_cmt("selectVarServer", "input$var")

  session$setInputs(var = "feed")
  testthat::expect_equal(object = session$returned(),
      expected = datasets::chickwts[["feed"]])
  test_cmt("selectVarServer", "session$returned()")

})
