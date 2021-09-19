#### test the a18 functions ####

# ----- Test accuracy -----
elena = function(alpha) round(1000*log(alpha),1)


test_that("a18_DIC*_H2O 'Beck equations' produce accurate values", {
  expect_equal(elena(a13_CO2g_CO2aq(temp = 25)), 1.1)
})
