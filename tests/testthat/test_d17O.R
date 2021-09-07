
test_that("d17O_c returns a data.frame", {
  expect_s3_class(d17O_c(temp = 10, 0, eq18 = "Daeron19"), "data.frame")
  expect_length(d17O_c(temp = 10, 0, eq18 = "Daeron19"), 3)
})

test_that("d17O_c error if eq18 is not or wrongly specified", {
  expect_error(d17O_c(temp = 10, 0, eq18 = "cheese"), "Invalid input for eq")
})

test_that("mix_d17O returns a data.frame", {
  expect_s3_class(mix_d17O(10, 11, 14, 12), "data.frame")
  expect_length(mix_d17O(10, 11, 14, 12), 3)
})
