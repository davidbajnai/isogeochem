
test_that("xDIC returns a data.frame", {
  expect_s3_class(xDIC(temp = 10, pH = 7, S = 0), "data.frame")
  expect_length(xDIC(temp = 10, pH = 7, S = 0), 3)
})
