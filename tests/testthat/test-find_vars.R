testthat::test_that("find_vars", {
    testthat::expect_equal(
    object = find_vars(datasets::airquality,
                            filter = is.double),
    expected = names(airquality)[vapply(airquality, is.double, logical(1))])

  testthat::expect_equal(
    object = find_vars(datasets::mtcars,
                            filter = is.character),
    expected = datasets::mtcars |>
      dplyr::select(where(is.character)) |>
      names())

  testthat::expect_error(object =
      find_vars(datasets::state.abb, filter = is.character))

  testthat::expect_error(object =
      find_vars(datasets::mtcars, filter = is.miracle))

})
