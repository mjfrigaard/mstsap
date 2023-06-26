
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `mstsap`

<!-- badges: start -->
<!-- badges: end -->

The goal of `mstsap` (`testServer()` app-package) is to demonstrate how to
test a shiny application package using
[`testthat`](https://testthat.r-lib.org/) and
[`shiny::testServer()`](https://search.r-project.org/CRAN/refmans/shiny/html/testServer.html)

## Installation

You don’t *have* to install the `mstsap` package, but you might want to
download it as an example (or read through [this
post](https://mjfrigaard.github.io/posts/test-shiny-p2/) to learn about
it’s contents).

## Utility function tests

``` r
source("tests/testthat/helpers.R")
testthat::test_file("tests/testthat/test-get_col_types.R")
```

    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 16 ]

``` r
testthat::test_file("tests/testthat/test-check_binary_vec.R")
```

    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 25 ]

``` r
testthat::test_file("tests/testthat/test-check_facet_vec.R")
```

    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 16 ]

``` r
testthat::test_file("tests/testthat/test-make_binary_vec.R")
```

    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 5 ]

``` r
testthat::test_file("tests/testthat/test-make_facet_vec.R")
```

    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 7 ]

``` r
testthat::test_file("tests/testthat/test-pull_numeric_cols.R")
```

    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]

``` r
testthat::test_file("tests/testthat/test-pull_binary_cols.R")
```

    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]

``` r
testthat::test_file("tests/testthat/test-pull_facet_cols.R")
```

    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]

``` r
testthat::test_file("tests/testthat/test-pull_cat_cols.R")
```

    [ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]

# Shiny server tests

Check the shiny `testServer()` tests for the modules in
`tests/testthat/`

    #> tests/testthat/
    #> ├── test-mod_cols_server.R
    #> ├── test-mod_ds_server.R
    #> ├── test-mod_pkg_server.R
    #> ├── test-mod_plot_server.R
    #> └── test-mod_plot_server_alt.R

``` r
# run module function tests -----------------------------------------------
testthat::test_file("tests/testthat/test-mod_pkg_server.R")
```

``` default
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
Test 1 initial pkg = NULL: >> TRUE 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
Test 2 change pkg = 'palmerpenguins': >>  palmerpenguins 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
Test 3 change pkg: 'NHANES' >> NHANES 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
Test 4 class(returned()): 'character' >> character 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 5 ]
Test 5 nchar(returned()): '6' >> 6
```

``` r
testthat::test_file("tests/testthat/test-mod_ds_server.R")
```

``` default
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 0 ]
Loading required package: palmerpenguins
Loading required package: NHANES
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
Test 1 pkg_input() = 'palmerpenguins': >> palmerpenguins 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
Test 2 input value changes: penguins_raw >>  penguins_raw 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
Test 3 class = tibble/data.frame: >> tbl_df tbl data.frame 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
Test 1 pkg_input() = 'NHANES': >> NHANES 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 5 ]
Test 2 input value changes: penguins_raw >>  NHANESraw 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 6 ]
Test 3 class = tibble/data.frame: >> tbl_df tbl data.frame 
```

``` r
testthat::test_file("tests/testthat/test-mod_cols_server.R")
```

``` default
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
Test 1 pkg_data() = clean_names(palmerpenguins::penguins) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
Test 2 pull_numeric_cols(clean_names(palmerpenguins::penguins)) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
Test 3 pull_binary_cols(clean_names(palmerpenguins::penguins)) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
Test 4 pull_facet_cols(clean_names(palmerpenguins::penguins)) 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 5 ]
Test 5: x_var = bill_length_mm >> bill_length_mm 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 6 ]
Test 6: y_var = bill_depth_mm >> bill_depth_mm 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 7 ]
Test 7: col_var = sex >> sex 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 8 ]
Test 8: facet_var = species >> species 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 9 ]
Test 9: size = 3 >> 3 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 10 ]
Test 10: size = 1/2 >> 0.5 
```

``` r
testthat::test_file("tests/testthat/test-mod_plot_server.R")
```

``` default
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 1 ]
Test 1 plot_inputs() is.list: >> list 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 2 ]
Test 2 data.frame(plot_inputs()$df) >> tbl_df tbl data.frame 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 3 ]
Test 3 plot_inputs()$x_var = bill_length_mm: >> bill_length_mm 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
Test 4 plot_inputs()$y_var = bill_depth_mm: >> bill_depth_mm 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 5 ]
Test 5 plot_inputs()$col_var = sex: >> sex 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 6 ]
Test 6 plot_inputs()$facet_var = species: >> species 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 7 ]
Test 7 plot_inputs()$size = 2: >> 2 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 8 ]
Test 8 plot_inputs()$alpha = 0.5: >> 0.5 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 9 ]
Test 2 plot_inputs() names: >> df x_var y_var col_var facet_var alpha size 
[ FAIL 0 | WARN 0 | SKIP 0 | PASS 10 ]
Test 10 ggplot2::is.ggplot: >> TRUE 
```
