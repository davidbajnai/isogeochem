#### test the clumped functions ####


# ----- Test warnings -----

test_that("D47 and D48 error if eq is not or wrongly specified", {
  expect_error(D47(10, "cheese"), "Invalid input for eq")
  expect_error(D48(10, "cheese"), "Invalid input for eq")
})

test_that("temp_D47 if eq is not or wrongly specified", {
  expect_error(temp_D47(0.600, eq = "cheese"), "Invalid input for eq")
})


# ----- Test outputs -----

test_that("D47 and D48 return values", {
  expect_type(D47(10, eq = "Petersen19"), "double")
  expect_type(D48(10, eq = "Swart21"), "double")
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
})
test_that("temp_D48 returns three values as data frame if error IS specified", {
  expect_length(temp_D47(0.617, 0.005, eq = "Petersen19"), 2)
  expect_type(temp_D47(0.617, 0.005, eq = "Petersen19"), "double")
})

# ----- Test graphics -----

plot(1:10)
expect_message(temp_D48(0.617, 0.139, 0.002, 0.010, ks = -0.6, add = T), "Graphics added to the plot")
graphics.off()

