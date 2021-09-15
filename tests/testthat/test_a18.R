#### tests of the a18 functions ####

test_that("a18_c_H2O errors if eq is not or wrongly specified", {
  expect_error(a18_c_H2O(10, "calcite"))
  expect_error(a18_c_H2O(10, "calcite", "cheese"), "Invalid input for eq")
  expect_error(a18_c_H2O(10, "dolomite", "cheese"), "Invalid input for eq")
  expect_error(a18_c_H2O(10, "aragonite", "cheese"), "Invalid input for eq")
})
test_that("a18_c_H2O errors if min is not or wrongly specified", {
  expect_error(a18_c_H2O(10, eq = "Daeron19"))
  expect_error(a18_c_H2O(10, "cheese", eq = "Daeron19"), "Invalid input for min")
})

test_that("a18_CO2acid_c errors if temp is not or wrongly specified", {
  expect_error(a18_CO2acid_c("cheese", "calcite"))
  expect_error(a18_CO2acid_c("calcite"))
})
test_that("a18_CO2acid_c errors if min is not or wrongly specified", {
  expect_error(a18_CO2acid_c(10))
  expect_error(a18_CO2acid_c(10, min = "cheese"), "Invalid input for min")
})

test_that("a18_H2O_OH errors if temp is not or wrongly specified", {
  expect_error(a18_H2O_OH("cheese", "Z21-X3LYP"))
  expect_error(a18_H2O_OH("Z21-X3LYP"))
})
test_that("a18_H2O_OH errors if eq is not or wrongly specified", {
  expect_error(a18_H2O_OH(10))
  expect_error(a18_H2O_OH(10, eq = "cheese"), "Invalid input for eq")
})

test_target_int = c(0.9, 1.1)
test_that("a18_H2O_OH produces a value between 0.9 and 1.1", {
  expect_lt(a18_H2O_OH(1, "Z20-X3LYP"),test_target_int[2])
  expect_gt(a18_H2O_OH(150, "Z20-X3LYP"),test_target_int[1])
  expect_lt(a18_H2O_OH(1, "Z20-MP2"),test_target_int[2])
  expect_gt(a18_H2O_OH(150, "Z20-MP2"),test_target_int[1])
})
test_that("a18_H2O_OH produces a value between 0.9 and 1.1", {
  expect_lt(a18_c_H2O(1, min = "calcite", eq = "Daeron19"),test_target_int[2])
  expect_gt(a18_c_H2O(150, min = "calcite", eq = "Coplen07"),test_target_int[1])
  expect_lt(a18_c_H2O(1, min = "calcite", eq = "KO97"),test_target_int[2])
  expect_gt(a18_c_H2O(150, min = "calcite", eq = "KO97"),test_target_int[1])
  expect_lt(a18_c_H2O(1, min = "calcite", eq = "KO97-orig"),test_target_int[2])
  expect_gt(a18_c_H2O(150, min = "calcite", eq = "KO97-orig"),test_target_int[1])
  expect_lt(a18_c_H2O(1, min = "calcite", eq = "Watkins13"),test_target_int[2])
  expect_gt(a18_c_H2O(150, min = "calcite", eq = "Watkins13"),test_target_int[1])
  expect_lt(a18_c_H2O(1, min = "calcite", eq = "FO77"),test_target_int[2])
  expect_gt(a18_c_H2O(150, min = "calcite", eq = "FO77"),test_target_int[1])
  expect_lt(a18_c_H2O(1, min = "calcite", eq = "Tremaine11"),test_target_int[2])
  expect_gt(a18_c_H2O(150, min = "calcite", eq = "Tremaine11"),test_target_int[1])
  expect_lt(a18_c_H2O(1, min = "aragonite", eq = "GK86"),test_target_int[2])
  expect_gt(a18_c_H2O(150, min = "aragonite", eq = "GK86"),test_target_int[1])
  expect_lt(a18_c_H2O(1, min = "dolomite", eq = "Vasconcelos05"),test_target_int[2])
  expect_gt(a18_c_H2O(150, min = "dolomite", eq = "Vasconcelos05"),test_target_int[1])
})
test_that("a18_CO2acid_c produces a value between 0.9 and 1.1", {
  expect_lt(a18_CO2acid_c(1, "calcite"),test_target_int[2])
  expect_gt(a18_CO2acid_c(150, "calcite"),test_target_int[1])
  expect_lt(a18_CO2acid_c(1, "aragonite"),test_target_int[2])
  expect_gt(a18_CO2acid_c(150, "aragonite"),test_target_int[1])
})
