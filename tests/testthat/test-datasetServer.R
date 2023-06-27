shiny::testServer(datasetServer, expr = {

  testthat::expect_equal(input$dataset, NULL)
  cat("\ndatasetServer: dataset$input is NULL", "\n")

  session$setInputs(dataset = "faithful")
  testthat::expect_equal(
    object = input$dataset,
    expected = "faithful")
  test_cmt("datasetServer", "dataset$input")

  session$setInputs(dataset = "mtcars")
  testthat::expect_true(
    object = is.data.frame(session$returned()))
  # cat("\n\tdatasetServer: is.data.frame()")
  test_cmt("datasetServer", "is.data.frame()")

  # session$setInputs(dataset = "mtcars")
  # expect_equal(object = names(session$returned()),
  #   expected = names(mtcars))
  # cat("\n\tdatasetServer: names()", "\n")
})
