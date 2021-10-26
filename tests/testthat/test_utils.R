# tests of the utils #


test_that("utility functions error if eq is not or wrongly specified", {
  expect_error(to_VSMOW(10, "cheese"), "Invalid input for eq")
  expect_error(to_VPDB(10, "cheese"), "Invalid input for eq")
})

test_that("utility functions return a number", {
  expect_type(to_VSMOW(0), "double")
  expect_type(to_VPDB(0), "double")
  expect_type(to_VSMOW(0, eq = "Coplen83"), "double")
  expect_type(to_VPDB(0, eq = "Coplen83"), "double")
  expect_type(prime(0), "double")
  expect_type(unprime(0), "double")
  expect_type(a_A_B(10, 12), "double")
  expect_type(A_from_a(10, 1.01), "double")
  expect_type(B_from_a(10, 1.01), "double")
  expect_type(epsilon(1.01), "double")
  expect_type(D17O(10, 5), "double")
})

