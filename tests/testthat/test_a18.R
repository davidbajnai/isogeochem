#### test the a18 functions ####


# ----- Test warnings -----

test_that("a18_c_H2O errors if eq is not or wrongly specified", {
  expect_error(a18_c_H2O(10, "calcite", "cheese"), "Invalid input for eq")
  expect_error(a18_c_H2O(10, "dolomite", "cheese"), "Invalid input for eq")
  expect_error(a18_c_H2O(10, "aragonite", "cheese"), "Invalid input for eq")
  expect_error(a18_c_H2O(10, "siderite", "cheese"), "Invalid input for eq")
  expect_error(a18_c_H2O(10, "apatite", "cheese"), "Invalid input for eq")
})

test_that("a18_c_H2O errors if parameters are not or wrongly specified", {
  expect_error(a18_c_H2O(10, "cheese", eq = "Daeron19"), "Invalid input for min")
})


test_that("a18_CO2acid_c errors if parameters are not or wrongly specified", {
  expect_error(a18_CO2acid_c(10, min = "cheese"), "Invalid input for min")
})

test_that("a18_H2O_OH errors if parameters are not or wrongly specified", {
  expect_error(a18_H2O_OH(10, eq = "cheese"), "Invalid input for eq")
})


# ----- Test accuracy -----

elena = function(alpha) round(1000*log(alpha),1)

test_that("a18_H2O_OH produces accurate values", {
  expect_equal(elena(a18_H2O_OH(temp = 15, eq = "Z20-X3LYP")), 23.9)
  expect_equal(elena(a18_H2O_OH(temp = 15, eq = "Z20-MP2")), 19.4)
})

test_that("a18_c_H2O produces accurate values", {
  expect_equal(elena(a18_c_H2O(25, min = "calcite", eq = "KO97-orig")), 28.1)
  expect_equal(elena(a18_c_H2O(25, min = "calcite", eq = "KO97")), 28.3)
  expect_equal(elena(a18_c_H2O(25, min = "calcite", eq = "Coplen07")), 29.8)
  expect_equal(elena(a18_c_H2O(25, min = "calcite", eq = "Daeron19")), 29.8)
  expect_equal(elena(a18_c_H2O(25, min = "calcite", eq = "Watkins13")), 29.7)
  expect_equal(elena(a18_c_H2O(25, min = "calcite", eq = "ONeil69")), 28.4)
  expect_equal(elena(a18_c_H2O(25, min = "calcite", eq = "Tremaine11")), 29.4)
  expect_equal(elena(a18_c_H2O(25, min = "aragonite", eq = "GK86")), 29.5)
  expect_equal(elena(a18_c_H2O(25, min = "aragonite", eq = "Kim07")), 28.8)
  expect_equal(elena(a18_c_H2O(25, min = "apatite", eq = "Lecuyer10")), 28.0)
  expect_equal(elena(a18_c_H2O(25, min = "dolomite", eq = "Vasconcelos05")), 31.0)
  expect_equal(elena(a18_c_H2O(25, min = "dolomite", eq = "Muller19")), 31.3)
  expect_equal(elena(a18_c_H2O(25, min = "siderite", eq = "vanDijk18")), 29.7)
})

test_that("a18_CO2acid_c produces accurate values", {
  expect_equal(elena(a18_CO2acid_c(temp = 90, min = "calcite")), 8.1)
  expect_equal(elena(a18_CO2acid_c(temp = 90, min = "aragonite")), 8.5)
  expect_equal(elena(a18_CO2acid_c(temp = 90, min = "dolomite")), 9.3)
})

test_that("a18_CO2g_H2O produce accurate values", {
  expect_equal(elena(a18_CO2g_H2O(temp = 25)), 40.3)
})

test_that("a18_DIC*_H2O 'Beck equations' produce accurate values", {
  expect_equal(elena(a18_CO2aq_H2O(temp = 25)), 40.5)
  expect_equal(elena(a18_CO3_H2O(temp = 25)), 24.2)
  expect_equal(elena(a18_HCO3_H2O(temp = 25)), 31.0)
})
