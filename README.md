
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `mstsap`

<!-- badges: start -->
<!-- badges: end -->

`mstsap` (Mastering shiny `testServer()` app-package) is a collection of
tests using [`testthat`](https://testthat.r-lib.org/) and
[`shiny::testServer()`](https://search.r-project.org/CRAN/refmans/shiny/html/testServer.html).

The modules and applications in `mstsap` come from the [Shiny modules
chapter](https://mastering-shiny.org/scaling-modules.html) of [Mastering
Shiny](https://mastering-shiny.org/index.html).

## Installation

You don’t *have* to install the `mstsap` package, but you might want to
download it as an example (or read through [this
post](https://mjfrigaard.github.io/posts/test-shiny-p3/) to learn about
it’s contents).

``` r
install.packages("remotes")
remotes::install_github("mjfrigaard/mstsap")
library(mstsap)
```

## Utility function tests

There is a single utility function in `mstsap`: `find_vars()`

    #> tests/testthat/
    #> └── test-find_vars.R

``` r
testthat::test_file("tests/testthat/test-find_vars.R")
```

``` default
#> [ FAIL 0 | WARN 0 | SKIP 0 | PASS 4 ]
```

## `testServer()` tests

    #> tests/testthat/
    #> ├── test-datasetApp.R
    #> ├── test-datasetServer.R
    #> ├── test-selectDataVarApp.R
    #> ├── test-selectDataVarServer.R
    #> ├── test-selectVarApp.R
    #> └── test-selectVarServer.R

``` default
🐝 Your tests are the bee's knees 🐝
```
