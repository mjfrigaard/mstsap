shiny::testServer(datasetServer, expr = {

  testthat::expect_equal(input$dataset, NULL)
  test_cmt("datasetServer", "dataset$input is NULL")

  session$setInputs(dataset = "faithful")
  testthat::expect_equal(
    object = input$dataset,
    expected = "faithful")
  test_cmt("datasetServer", "dataset$input")

  session$setInputs(dataset = "airquality")
  testthat::expect_equal(
    object = class(session$returned()),
    expected = "data.frame")
  test_cmt("datasetServer", "class(session$returned())")

  session$setInputs(dataset = "WorldPhones")
  testthat::expect_true(
    object = is.matrix(session$returned()))
  test_cmt("datasetServer", "is.matrix(session$returned())")

  session$setInputs(dataset = "mtcars")
  expect_equal(
    object = typeof(session$returned()),
    expected = typeof(datasets::mtcars))
  test_cmt("datasetServer", "typeof(session$returned())")
})
