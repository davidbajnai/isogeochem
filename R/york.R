# Functions in this file: york_fit(), york_plot()

# ——————————————————————————————————————————————————————————————————————————— #
#### york_fit ####
#' @title
#' Error-considering linear regression
#'
#' @description
#' `york_fit()` calculates the regression parameters of
#' an error-considering linear regression.
#'
#' @param x vector of x values.
#' @param y vector of y values. Has to be same the length as x.
#' @param x_err Error on the x values. Has to be same the length as x.
#' @param y_err Error on the y values. Has to be same the length as x.
#' @param r Correlation coefficient of x_err and y_err at each data point.
#'   Default: `0` (independent errors).
#'   Has to be same the length as x. Optional.
#'
#' @return A list with regression parameters:
#'   * slope and its standard error
#'   * intercept and its standard error
#'   * weights of the points (normalized to 1)
#'   * residual standard error (sigma)
#'   * R2
#'   * p-value (two-tailed t-test).
#'
#' @details
#' Regression fitting method according to York et al. (2004).
#' The algorithm is described in the appendix of Wacker et al. (2014).
#'
#' @references
#' York, D., Evensen, N. M., López Martínez, M., & De Basabe Delgado, J. (2004).
#' Unified equations for the slope, intercept, and
#' standard errors of the best straight line.
#' American Journal of Physics, 72(3), 367-375.
#' <https://doi.org/10.1119/1.1632486>
#'
#' Wacker, U., Fiebig, J., Tödter, J., Schöne, B. R.,
#' Bahr, A., Friedrich, O., et al. (2014).
#' Empirical calibration of the clumped isotope paleothermometer using calcites
#' of various origins. Geochimica et Cosmochimica Acta, 141, 127-144.
#' <https://doi.org/10.1016/j.gca.2014.06.004>
#'
#' @section Contributors:
#' Julian Tödter
#'
#' @examples
#' york_fit(
#'   x = c(1, 2, 3),
#'   y = c(1.1, 1.9, 3.2),
#'   x_err = c(0.1, 0.2, 0.1),
#'   y_err = c(0.2, 0.1, 0.2))
#'
#' @export

york_fit = function(y, x, x_err, y_err, r = 0) {
  # Get number of data points and perform quality checks
  n = length(x)
  if (length(y) != n |
      length(x_err) != n |
      length(y_err) != n |
      length(r) > 1 & length(r) != n
      ) {
    stop("Input parameters have different lengths")
  }

  # If r = 0, assume no correlation of errors
  if (length(r) == 1) {
    r = rep(0, n)
  }

  # Choose initial value of b using simple regression
  b_init = stats::lm(y ~ x)$coefficients[2]

  # Determine weights for each point as inverse of the error variances
  w_x = 1 / (x_err)^2
  w_y = 1 / (y_err)^2
  alpha = sqrt(w_x * w_y)

  # Iteration to get b
  k = 1
  go = TRUE
  b = numeric()
  b[1] = b_init

  while (go) {
    # Use weigts and b and correlation r to obtain total weight
    W = w_x * w_y / (w_x + (b[k]) ^ 2 * w_y - 2 * b[k] * r * alpha)

    # Use observed points and weights to get
    # mean_x, mean_y, and U, V, beta of each points
    mean_x = sum(W * x) / sum(W)
    mean_y = sum(W * y) / sum(W)
    U = x - mean_x
    V = y - mean_y
    beta = W * (U / w_y + b[k] * V / w_x - (b[k] * U + V) * r / alpha)

    # Use this to compute and improved estimate of b
    b[k + 1] = sum(W * beta * V) / sum(W * beta * U)

    # Check iteration tolerance by computing difference between b values
    dif = abs(b[k + 1] - b[k])
    if (dif < 1e-15) {
      go = FALSE
    } else {
      k = k + 1
    }
  }
  b_final = b[k + 1]

  # Use final b and final mean_x,mean_y to get a
  a_final = mean_y - b_final * mean_x

  # For each point, calculate adjusted values
  x_adj = mean_x + beta
  y_adj = mean_y + b_final * beta

  # Use adjusted x and W to get mean_x,mean_y and u,v
  mean_x = sum(W * x_adj) / sum(W)
  mean_y = sum(W * y_adj) / sum(W)

  # The adjusted values will be quite similar to x and y
  u = x_adj - mean_x
  v = y_adj - mean_y

  # (10) Compute standard errors of slope & intercept (variances first)
  sd_b2 = 1 / (sum(W * u^2))
  sd_a2 = 1 / sum(W) + mean_x^2 * sd_b2

  # Coefficient of Determination
  # compute with traditional equations
  yhat = a_final + b_final * x

  # compute with consideration of weights
  # R2new = sum( W * (yhat-mean_y)^2 ) / sum(  W * (y-mean_y)^2 )
  R2new = 1 - sum(W * (yhat - y)^2) / sum(W * (y - mean_y)^2)

  # Compute a p-value for R2 via an t-test (h0=reg. coeff is zero)
  t = b_final / sqrt(sd_b2) # This is for H0: b1=0
  pval_t = 2 * (1 - stats::pt(abs(t), n - 2))

  # sigma: std. error of residuals
  sigma = sqrt(sum(W * (y - yhat)^2) / sum(W))


  return(
    list(
      slope = b_final,
      slope_se = sqrt(sd_b2),
      intercept = a_final,
      intercept_se = sqrt(sd_a2),
      w = W / sum(W),
      sigma = sigma,
      R2 = R2new,
      pval = pval_t
    )
  )
}


# ——————————————————————————————————————————————————————————————————————————— #
#### york_plot ####
#' @title
#' Regression confidence intervals
#'
#' @description
#' `york_plot()` calculates and optionally plots the confidence intervals of
#' an (error-considering) linear regression.
#'
#' @param x x values of the data points.
#' @param slope regression slope.
#' @param intercept regression intercept.
#' @param slope_se Standard error of the slope.
#' @param intercept_se Standard error of the intercept.
#' @param cl Confidence level. Default: `0.95`.
#' @param add Add graphics to an already existing plot? Default: `FALSE`.
#' @param col Graphical parameter. Optional.
#' @param weights Weights of the data points.
#'   If given, mean & SD of x are computed with the weights.
#'   Has to be same the length as x. Optional.
#'
#' @return A list with regression parameters:
#'   * slope and its standard error
#'   * intercept and its standard error
#'   * weights of the points (normalized to 1)
#'   * residual standard error (sigma)
#'   * R2
#'   * p-value (two-tailed t-test).
#'
#' @details
#' The algorithm is described in the appendix of Wacker et al. (2014).
#'
#' @references
#' Wacker, U., Fiebig, J., Tödter, J., Schöne, B. R.,
#' Bahr, A., Friedrich, O., et al. (2014).
#' Empirical calibration of the clumped isotope paleothermometer using calcites
#' of various origins. Geochimica et Cosmochimica Acta, 141, 127-144.
#' <https://doi.org/10.1016/j.gca.2014.06.004>
#'
#' @section Contributors:
#' Julian Tödter
#'
#' @examples
#' york_plot(
#'   x = c(1, 2, 3),
#'   slope = 1.06,
#'   slope_se = 1.60,
#'   intercept = -0.05,
#'   intercept_se = 0.34,
#'   cl = 0.98)
#'
#' @export

york_plot = function(x,
                     slope,
                     slope_se,
                     intercept,
                     intercept_se,
                     cl = 0.95,
                     weights = -1,
                     add = FALSE,
                     col = "black") {
  # Setup
  a = intercept
  b = slope
  n = length(x)

  # Input quality check
  if (length(weights) > 1 &
      length(weights) != n)
    stop("x and weights have different lengths")
  if (cl < 0 | cl > 1)
    stop("Confidence level has to be 0 < cl < 1")

  # Calculate statistics of x values
  if (length(weights) > 1) {
    xbar    = sum(weights * x) / sum(weights)
    sigma_x = sum(weights * (x - xbar) ^ 2) / sum(weights)
  } else {
    xbar    = mean(x)
    sigma_x = stats::sd(x)
  }

  ## Calculate error variance
  sigma1 = sqrt(slope_se ^ 2 * (n - 1) * sigma_x ^ 2)
  sigma2 = sqrt(intercept_se^2 / ( 1 / n + xbar ^ 2 / ((n - 1) * sigma_x ^ 2)))
  sigma = (sigma1 + sigma2) / 2
  alpha = 1 - cl
  t = stats::qt(1 - alpha / 2, df = n - 2)

  # Calculate confidence lines
  x = seq(min(x), max(x), 1000)
  ylow = a + b * x - t *
    sqrt(sigma ^ 2 * (1 / n + 1 / (n - 1) * (x - xbar) ^ 2 / sigma_x ^ 2))
  yup = a + b * x + t *
    sqrt(sigma ^ 2 * (1 / n + 1 / (n - 1) * (x - xbar) ^ 2 / sigma_x ^ 2))

  # Add graphical output to an existing plot
  if (add == TRUE) {
    if (is.null(grDevices::dev.list()) == FALSE) {
      graphics::lines(x, a + b * x, col = col, lwd = 1.2)
      graphics::polygon(
        c(x, rev(x)),
        c(ylow, rev(yup)),
        col = grDevices::adjustcolor(col, alpha.f = 0.3),
        border = NA
      )
    } else {
      warning("There is no existing plot! Proceeding without plotting.")
    }
  }

  res = data.frame(x, ylow, yup)
  colnames(res) = c("x", "y_low", "y_up")
  return(res)
}
