#### clumped ####

test_that("D47 and D48 error if eq is not or wrongly specified", {
  expect_error(D47(10))
  expect_error(D47(10, "cheese"), "Invalid input for eq")
  expect_error(D48(10))
  expect_error(D48(10, "cheese"), "Invalid input for eq")
})
test_that("D47 and D48 error if temp is not or wrongly specified", {
  expect_error(D47("cheese", "Fiebig21"))
  expect_error(D48("cheese", "Fiebig21"))
})

# Additional tests for all valid input parameters
test_that("D47 and D48 return values", {
  expect_type(D47(10, eq = "Petersen19"), "double")
  expect_type(D48(10, eq = "Swart21"), "double")
})


test_that("temp_D47 and temp_D48 error if clumped error and eq is not or wrongly specified", {
  expect_error(temp_D47(10))
  expect_error(temp_D47(10, "cheese"))
  expect_error(temp_D47(10, eq = "cheese"), "Invalid input for eq")
  expect_error(temp_D48(10))
})


test_that("temp_D48 returns a single value if error IS NOT specified", {
  expect_length(temp_D48(0.617, 0.139, ks = -0.6),1)
})
test_that("temp_D48 returns three values as data frame if error IS specified", {
  expect_length(temp_D48(0.617, 0.139, 0.002, 0.010, ks = -0.6), 3)
  expect_s3_class(temp_D48(0.617, 0.139, 0.002, 0.010, ks = -0.6), "data.frame")
})

test_that("temp_D47 returns a single value if error IS NOT specified", {
  expect_length(temp_D47(0.617, eq = "Petersen19"), 1)
  expect_length(temp_D47(0.617, eq = "Kele15"), 1)
})
test_that("temp_D48 returns three values as data frame if error IS specified", {
  expect_length(temp_D47(0.617, 0.005, eq = "Petersen19"), 2)
  expect_type(temp_D47(0.617, 0.005, eq = "Petersen19"), "double")
})
