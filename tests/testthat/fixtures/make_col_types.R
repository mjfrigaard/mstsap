col_types <- tibble::tibble(

  # double ----
  dbl_var_na = dbl_maker(10, missing = TRUE),
  dbl_var = dbl_maker(size = 10),
  # integer ----
  int_var_na = int_maker(10, missing = TRUE),
  int_var = int_maker(size = 10),
  # character
  chr_var_na = chr_maker(
    size = 10, missing = TRUE
  ),
  chr_var = chr_maker(size = 10),

  # logical binary ----
  log_bin_na = bin_maker(
    bin_type = "log",
    size = 10, missing = TRUE
  ),
  log_bin = bin_maker(
    bin_type = "log",
    size = 10, missing = FALSE
  ),

  # integer binary ----
  int_bin_na = bin_maker(
    bin_type = "int",
    size = 10, missing = TRUE
  ),
  int_bin = bin_maker(
    bin_type = "int",
    size = 10, missing = FALSE
  ),

  # character binary ----
  chr_bin_na = bin_maker(
    bin_type = "chr",
    size = 10, missing = TRUE
  ),
  chr_bin = bin_maker(
    bin_type = "chr",
    size = 10, missing = FALSE
  ),
  chr_bin2_na = chr_maker(
    size = 10,
    lvls = 1, missing = TRUE
  ),

  # 5-level ----
  # factor
  fct5_var_na = fct_maker(
    size = 10,
    lvls = 5, missing = TRUE
  ),
  fct5_var = fct_maker(size = 10, lvls = 5),
  # ordered
  ord5_var_na = ord_maker(
    size = 10, lvls = 5,
    missing = TRUE
  ),
  ord5_var = ord_maker(
    size = 10,
    lvls = 5
  ),

  # 4-level ----
  # character facets
  chr_facet4 = facet_maker(
    facet_type = "chr", size = 10,
    lvls = 4, missing = FALSE
  ),
  chr_facet4_na = facet_maker(
    facet_type = "chr", size = 10,
    lvls = 4, missing = TRUE
  ),
  # factor facets
  fct_facet4 = facet_maker(
    facet_type = "fct", size = 10,
    lvls = 4, missing = FALSE
  ),
  fct_facet4_na = facet_maker(
    facet_type = "fct", size = 10,
    lvls = 4, missing = TRUE
  ),
  # ordered facets
  ord_facet4 = facet_maker(
    facet_type = "ord", size = 10,
    lvls = 4, missing = FALSE
  ),
  ord_facet4_na = facet_maker(
    facet_type = "ord", size = 10,
    lvls = 4, missing = TRUE
  )
)

# export to tests/testthat/fixtures/
saveRDS(col_types,
  file = "tests/testthat/fixtures/col_types.rds"
)
