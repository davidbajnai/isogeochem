# utils

test_that("utility functions return a number", {
  expect_type(to_VSMOW(0), "double")
  expect_type(to_VPDB(0), "double")
  expect_type(prime(0), "double")
  expect_type(unprime(0), "double")
  expect_type(a_A_B(10, 12), "double")
  expect_type(A_from_a(10, 1.01), "double")
  expect_type(A_from_a(10, 1.01), "double")
})
