shiny::testServer(selectDataVarServer, expr = {
  expect_equal(2 * 2, 4)
})
