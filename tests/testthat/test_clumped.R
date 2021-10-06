#### test the clumped functions ####


# Test warnings –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

test_that("D47 and D48 error if eq is not or wrongly specified", {
  expect_error(D47(10, "cheese"), "Invalid input for eq")
  expect_error(D48(10, "cheese"), "Invalid input for eq")
})

test_that("temp_D47 if eq is not or wrongly specified", {
  expect_error(temp_D47(0.600, eq = "cheese"), "Invalid input for eq")
})


# Test outputs –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––—

test_that("D47 and D48 return values", {
  expect_type(D47(10, eq = "Petersen19"), "double")
  expect_type(D47(10, eq = "Fiebig21"), "double")
  expect_type(D47(10, eq = "Anderson21"), "double")
})

test_that("D48 return values", {
  expect_type(D48(10, eq = "Fiebig21"), "double")
  expect_type(D48(10, eq = "Swart21"), "double")
})

test_that("temp_D48 returns a single value if error IS NOT specified", {
  expect_length(temp_D48(0.617, 0.139, ks = -0.6),1)
})
test_that("temp_D48 returns two values if error IS specified", {
  expect_length(temp_D48(0.617, 0.139, 0.002, 0.010, ks = -0.6), 2)
})

test_that("temp_D47 returns a single value if error IS NOT specified", {
  expect_length(temp_D47(0.617, eq = "Petersen19"), 1)
})

test_that("temp_D47 returns two values if error IS specified", {
  expect_length(temp_D47(0.617, 0.005, eq = "Petersen19"), 2)
})

# Test graphics –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

plot(1:10)
test_that("temp_D48 adds graphics to exisiting plot", {
  expect_message(temp_D48(0.617, 0.139, 0.002, 0.010, ks = -0.6, add = TRUE),
                 "")
  expect_message(temp_D48(0.617, 0.139, ks = -0.6, add = TRUE),
                 "")
})
graphics.off()

test_that("temp_D48 warns if there is no exisiting plot", {
  expect_warning(
    temp_D48(0.617, 0.139, 0.002, 0.010, ks = -0.6, add = TRUE),
    "There is no existing plot! Proceeding without plotting."
  )
})

