# tests of the DIC functions #

test_that("X_DIC returns a data frame", {
  expect_s3_class(X_DIC(temp = 10, pH = 7, S = 0), "data.frame")
  expect_length(X_DIC(temp = 10, pH = 7, S = 0), 3)
})

test_that("X_absorption returns a data frame", {
  expect_s3_class(X_absorption(temp = 10, pH = 7, S = 0), "data.frame")
  expect_length(X_absorption(temp = 10, pH = 7, S = 0), 2)
})
