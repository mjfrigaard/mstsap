col_classes <- tibble::tibble(
  log_na = log_maker(size = 10, missing = TRUE),
  log_var = log_maker(size = 10),
  int_na = int_maker(size = 10, missing = TRUE),
  int_var = int_maker(size = 10),
  dbl_na = dbl_maker(10, missing = TRUE),
  dbl_var = dbl_maker(size = 10),
  chr_na = chr_maker(size = 10, lvls = 4, missing = TRUE),
  chr_var = chr_maker(size = 10, lvls = 4),
  fct_na = fct_maker(size = 10, lvls = 5, missing = TRUE),
  fct_var = fct_maker(size = 10, lvls = 5),
  ord_na = ord_maker(size = 10, lvls = 5, missing = TRUE),
  ord_fct = ord_maker(size = 10, lvls = 5)
)
# export to tests/testthat/fixtures/
saveRDS(col_classes,
  file = "tests/testthat/fixtures/col_classes.rds"
)
