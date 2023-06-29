dv_app <- selectDataVarApp()
shiny::testServer(app = dv_app, expr = {
  session$setInputs(`var-var-var` = "Ozone",
                    `var-data-dataset` = "airquality")
  cat("\n\toutput$out:\n", output$out, "\n")

  testthat::expect_equal(
    object = input$`var-var-var`,
    expected = "Ozone")
  test_cmt("selectDataVarApp", "input$`var-var-var`")

  testthat::expect_equal(
    object = input$`var-data-dataset`,
    expected = "airquality")
  test_cmt("selectDataVarApp", "input$`var-data-dataset`")

  testthat::expect_true(object = is.reactive(var))
  test_cmt("selectDataVarApp", "is.reactive(var)")
  cat("\n\tvar:\n", var(), "\n")

})
