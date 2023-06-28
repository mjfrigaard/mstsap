testthat::test_that("find_vars", {
    testthat::expect_equal(
    object = find_vars(datasets::airquality,
                            filter = is.double),
    expected = names(airquality)[vapply(airquality, is.double, logical(1))])
    test_cmt("find_vars", "is.double()")

  testthat::expect_equal(
    object = find_vars(datasets::mtcars,
                            filter = is.character),
    expected = datasets::mtcars |>
      dplyr::select(where(is.character)) |>
      names())
  test_cmt("find_vars", "is.character()")

  testthat::expect_error(object =
      find_vars(datasets::state.abb, filter = is.character))
  test_cmt("find_vars", "error: data")

  testthat::expect_error(object =
      find_vars(datasets::mtcars, filter = is.miracle))
  test_cmt("find_vars", "error: filter")

})
