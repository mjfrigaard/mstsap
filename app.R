# run app for package
pkgload::load_all(
  export_all = FALSE,
  helpers = TRUE,
  attach_testthat = TRUE)
library(mstsap)
# options(shiny.fullstacktrace = TRUE)
mstsap::pkgDataApp()
# rsconnect::deployApp()
