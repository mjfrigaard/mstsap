test_col_data <- tibble::tibble(
 log_var = c(TRUE, FALSE, TRUE),
 int_var = c(1L, 2L, 3L),
 dbl_var = c(1.1, 2.2, 3.3),
 chr_var = c("item:1", "item:2", "item:3"),
 fct_var = factor(
   c("group 1", "group 2", "group 3"),
   levels = c(
     "group 1", "group 2", "group 3")),
 ord_var = factor(
   c("level 1", "level 2", "level 3"),
   levels = c("level 1", "level 2", "level 3"),
   ordered = TRUE),
 list_var = list(
   log_vec = c(TRUE, FALSE),
   dbl_vec = c(1.1, 2.2),
   chr_var = c("item:1", "item:2")))
saveRDS(object = test_col_data, "tests/testthat/fixtures/test_col_data.rds")
