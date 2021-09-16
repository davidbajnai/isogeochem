#### tests of the d18O functions ####

d18O_c_VSMOW = 31
d18O_H2O_VSMOW = 0

test_that("d18O functions return a number", {
  expect_type(d18O_H2O(10, d18O_H2O_VSMOW, "calcite", "KO97"), "double")
  expect_type(d18O_c(10, d18O_H2O_VSMOW, "calcite", "KO97"), "double")
  expect_type(temp_d18O(d18O_c_VSMOW, d18O_H2O_VSMOW, "calcite", "Daeron19"), "double")
})

test_that("temp_d18O error if eq is not or wrongly specified", {
  expect_error(temp_d18O(d18O_c_VSMOW, d18O_H2O_VSMOW, "calcite"))
  expect_error(temp_d18O(d18O_c_VSMOW, d18O_H2O_VSMOW, "calcite", "cheese"))
  expect_error(temp_d18O(d18O_c_VSMOW, d18O_H2O_VSMOW, "cheese", "cheese"))
})
