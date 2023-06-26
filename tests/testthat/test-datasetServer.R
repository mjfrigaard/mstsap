shiny::testServer(datasetServer, expr = {
  session$setInputs(dataset = "faithful")
  testthat::expect_equal(
    object = input$dataset,
    expected = "faithful")
  cat("\n\tdatasetServer: dataset$input", "\n")

  session$setInputs(dataset = "mtcars")
  testthat::expect_true(
    object = is.data.frame(session$returned()))
  cat("\n\tdatasetServer is.data.frame()", "\n")

  session$setInputs(dataset = "mtcars")
  expect_equal(object = names(session$returned()),
    expected = names(mtcars))
  cat("\n\tdatasetServer names()", "\n")
})
