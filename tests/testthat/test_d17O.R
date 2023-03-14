# tests of the d17O functions #

test_that("d17O_c returns a data.frame", {
  expect_s3_class(d17O_c(temp = 10, 0, min = "aragonite", eq17 = "Wostbrock20", eq18 = "GK86"), "data.frame")
  expect_length(d17O_c(temp = 10, 0, min = "aragonite", eq17 = "Wostbrock20", eq18 = "GK86"), 3)
  expect_s3_class(d17O_c(temp = 10, 0, min = "calcite", eq17 = "Wostbrock20", eq18 = "Daeron19"), "data.frame")
  expect_length(d17O_c(temp = 10, 0, min = "calcite", eq17 = "Wostbrock20", eq18 = "Daeron19"), 3)
  expect_s3_class(d17O_c(temp = 10, 0, min = "aragonite", eq17 = "GZ19", eq18 = "GK86"), "data.frame")
  expect_length(d17O_c(temp = 10, 0, min = "aragonite", eq17 = "GZ19", eq18 = "GK86"), 3)
  expect_s3_class(d17O_c(temp = 10, 0, min = "calcite", eq17 = "GZ19", eq18 = "Daeron19"), "data.frame")
  expect_length(d17O_c(temp = 10, 0, min = "calcite", eq17 = "GZ19", eq18 = "Daeron19"), 3)
})

test_that("d17O_qz returns a data.frame", {
  expect_s3_class(d17O_qz(temp = 10, 0), "data.frame")
  expect_length(d17O_qz(temp = 10, 0), 3)
})

test_that("d17O_c error if ", {
  expect_error(d17O_c(temp = 10, 0, min = "aragonite", eq17 = "hello"), "Invalid input for eq17. Options for aragonite are GZ19 and Wostbrock20.")
  expect_error(d17O_c(temp = 10, 0, min = "calcite", eq17 = "hello"), "Invalid input for eq17. Options for calcite are GZ19 and Wostbrock20.")
  expect_error(d17O_c(temp = 10, 0, min = "dolomite"), "Invalid input for min. Options are calcite and aragonite.")
})

test_that("d17O_qz error if D17O_H2O is wrongly specified", {
  expect_error(d17O_qz(temp = 10, 0, D17O_H2O = "cheese"), "Invalid input for D17O_H2O")
})

test_that("mix_d17O returns a data.frame", {
  expect_s3_class(mix_d17O(d18O_A = 10, d17O_A = 11, d18O_B = 14, d17O_B = 12), "data.frame")
  expect_length(mix_d17O(d18O_A = 10, d17O_A = 11, d18O_B = 14, d17O_B = 12), 4)
  expect_s3_class(mix_d17O(d18O_A = 10, d17O_A = 11, d18O_B = 14, d17O_B = 12), "data.frame")
  expect_length(mix_d17O(d18O_A = 10, D17O_A = 11, d18O_B = 14, D17O_B = 12), 4)
})
