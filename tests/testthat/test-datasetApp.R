ds_app <- datasetApp()
shiny::testServer(app = ds_app, expr = {
  session$setInputs(`dataset-dataset` = "chickwts")
  cat("\n\toutput$data:\n", output$data, "\n")

  testthat::expect_equal(
    object = input$`dataset-dataset`,
    expected = "chickwts")
  test_cmt("datasetApp", "input$`dataset-dataset`")

  testthat::expect_true(
    object = is.data.frame(data()))
  test_cmt("datasetApp", "is.data.frame(data())")

  testthat::expect_equal(
    object = names(data()),
    expected = names(datasets::chickwts))
  test_cmt("datasetApp", "names(data())")


  testthat::expect_equal(
    object = class(output$data),
    expected = "character")
  test_cmt("datasetApp", "class(output$data)")

})

