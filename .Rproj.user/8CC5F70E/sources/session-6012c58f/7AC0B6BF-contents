# for testing these need to be on the search list!
require(palmerpenguins)
require(NHANES)
shiny::testServer(mod_ds_server,
  args = list(pkg_input = reactive("palmerpenguins")), expr = {

  testthat::expect_true(
    object = is.reactive(pkg_input))
  tscmt("mod_ds_server", "is.reactive(pkg_input)")

  # testthat::expect_equal(
  #   object = pkg_input(),
  #   expected = "palmerpenguins")
  # tscmt("mod_ds_server", "pkg_input()")

  # testthat::expect_equal(
  #   object = get_pkg_df_names(pkg_input()),
  #   expected = c("penguins", "penguins_raw"))
  # tscmt("mod_ds_server", "get_pkg_df_names()")

  #   session$setInputs(dataset = "penguins")
  #   expect_equal(object = input$dataset,
  #     expected = "penguins")
  #   tscmt("mod_ds_server", "input$dataset")

  #   session$setInputs(dataset = "penguins")
  #     expect_true(object = is.data.frame(session$returned()))
  #   tscmt("mod_ds_server", "is.data.frame")

  #   penguins <- palmerpenguins::penguins
  #   session$setInputs(dataset = "penguins")
  #   expect_equal(object = names(session$returned()),
  #     expected = names(penguins))
  #   tscmt("mod_ds_server", "names(returned)")

})

