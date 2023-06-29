sv_app <- selectVarApp()
shiny::testServer(app = sv_app, expr = {
  session$setInputs(`var-var` = "Ozone",
                    `data-dataset` = "airquality")
  cat("\n\toutput$out:\n", output$out, "\n")

  testthat::expect_true(object = is.reactive(var))
  test_cmt("selectVarApp", "is.reactive(var)")

  testthat::expect_equal(
    object = input$`var-var`,
    expected = "Ozone")
  test_cmt("selectVarApp", "input$`var-var`")

  testthat::expect_true(object = is.reactive(data))
  test_cmt("selectVarApp", "is.reactive(data)")

  testthat::expect_true(
    object = is.data.frame(data()))
  test_cmt("selectVarApp", "is.data.frame(data())")

  testthat::expect_equal(
    object = data()[[input$`var-var`]],
    expected = airquality[["Ozone"]])
  test_cmt("selectVarApp", "data()[[input$`var-var`]]")



})
