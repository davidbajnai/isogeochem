### tests of the regression fitting and plotting functions ###


N3 = c(1,2,3)
N2 = c(1,2)

# Test warnings –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

test_that("york_fit requires equal x... lenghts", {
  expect_error(york_fit(x = N3, y = N2, x_err = N3, y_err = N3), "Input parameters have different lengths")
  expect_error(york_fit(x = N3, y = N3, x_err = N2, y_err = N3), "Input parameters have different lengths")
  expect_error(york_fit(x = N3, y = N3, x_err = N3, y_err = N2), "Input parameters have different lengths")
  expect_error(york_fit(x = N3, y = N3, x_err = N3, y_err = N3, r = N2), "Input parameters have different lengths")
})

test_that("york_plot requires equal x and w lenghts", {
  expect_error(york_plot(x = N3, slope = 1, slope_se = 0.1,
                         intercept = 0, intercept_se = 0.1, cl = 0.95, w = N2), "x and weights have different lengths")
})

test_that("york_plot errors if input paramters are wrong", {
  expect_error(york_plot(x = N3, slope = 1, slope_se = 0.1,
                        intercept = 0, intercept_se = 0.1, cl = 10),
                 "Confidence level has to be 0 < cl < 1")
})

# Test outputs –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––—

test_that("york_fit returns a list of 8", {
  expect_type(york_fit(x = N3, y = N3, x_err = N3, y_err = N3), "list")
  expect_length(york_fit(x = N3, y = N3, x_err = N3, y_err = N3), 8)
  expect_length(york_fit(x = N3, y = N3, x_err = N3, y_err = N3, r = c(0.1,0.3,0.3)), 8)
})

test_that("york_plot returns a data.frame", {
  expect_s3_class(york_plot(x = N3, slope = 1, slope_se = 0.1,
                            intercept = 0, intercept_se = 0.1, cl = 0.95), "data.frame")
  expect_length(york_plot(x = N3, slope = 1, slope_se = 0.1,
                            intercept = 0, intercept_se = 0.1, cl = 0.95), 3)
  expect_s3_class(york_plot(x = N3, slope = 1, slope_se = 0.1,
                            intercept = 0, intercept_se = 0.1, cl = 0.95, w = N3), "data.frame")
})

# Test graphics –––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

plot(1:10)
test_that("york_plot adds graphics to exisiting plot", {
  expect_message(
    york_plot(
      x = N3,
      slope = 1,
      slope_se = 0.1,
      intercept = 0,
      intercept_se = 0.1,
      cl = 0.95,
      add = TRUE
    ),
    ""
  )
})
graphics.off()

test_that("york_plot warns if there is no exisiting plot", {
  expect_warning(
    york_plot(
      x = N3,
      slope = 1,
      slope_se = 0.1,
      intercept = 0,
      intercept_se = 0.1,
      cl = 0.95,
      add = TRUE
    ),
    "There is no existing plot! Proceeding without plotting."
  )
})
