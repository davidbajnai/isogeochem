# Functions in this file: D48(), temp_D48(), temp_D47(), D47()

# ——————————————————————————————————————————————————————————————————————————— #
#### D47 ####
#' @title Equilibrium carbonate D47 value
#'
#' @description
#' `D47()` calculates the equilibrium carbonate D47 value
#'   for a given temperature.
#'
#' @param temp Carbonate growth temperature (°C).
#' @param eq Equation used for the calculation.
#'   * `"Petersen19"`: the synthetic-only composite IUPAC-parameter calibration
#'     of Petersen et al. (2019).
#'   * `"Fiebig21"`: the CDES90 calibration of Fiebig et al. (2021).
#'
#' @details
#' **"Petersen19"**:
#'
#' \deqn{\Delta_{47, CDES90} =
#' 0.0383 \times \frac{10^{6}}{T^{2}} + 0.170}
#'
#' **"Fiebig21"**:
#'
#' \deqn{\Delta_{47, CDES90} =
#' 1.038 \times (-5.897 \times \frac{1}{T}
#'                   - 3.521 \times \frac{10^{3}}{T^{2}}
#'                   + 2.391 \times \frac{10^{7}}{T^{3}}
#'                   - 3.541 \times \frac{10^{9}}{T^{4}}) + 0.1856}
#'
#' @return
#' Returns the carbonate D47 value expressed on the CDES90 scale (‰).
#'
#' @references
#' Petersen, S. V., Defliese, W. F., Saenger, C., Daëron, M., Huntington,
#' K. W., John, C. M., et al. (2019).
#' Effects of improved 17O correction on interlaboratory agreement in
#' clumped isotope calibrations, estimates of mineral-specific offsets,
#' and temperature dependence of acid digestion fractionation.
#' Geochemistry, Geophysics, Geosystems, 20(7), 3495-3519.
#' <https://www.doi.org/10.1029/2018GC008127>
#'
#' Fiebig, J., Daëron, M., Bernecker, M., Guo, W.,
#' Schneider, G., Boch, R., et al. (2021).
#' Calibration of the dual clumped isotope thermometer for carbonates.
#' Geochimica et Cosmochimica Acta.
#' <https://www.doi.org/10.1016/j.gca.2021.07.012>
#'
#' @seealso [temp_D47()] calculates growth temperature from a D47 value.
#'
#' @family equilibrium_carbonate
#'
#' @examples
#' D47(temp = 33.7, eq = "Petersen19") # Returns 0.577
#' D47(temp = 33.7, eq = "Fiebig21") # Returns 0.571
#'
#' @export

D47 = function(temp, eq) {
  TinK = temp + 273.15

  if (eq == "Petersen19") {
    # Petersen et al. (2019)
    b = 0.258 - 0.088
    m = 0.0383
    m * (10 ^ 6 / TinK ^ 2) + b
  } else if (eq == "Fiebig21") {
    # Fiebig et al. (2021)
    1.038 * (-5.897 / TinK
             - 3.521 * 10 ^ 3 / TinK ^ 2
             + 2.391 * 10 ^ 7 / TinK ^ 3
             - 3.541 * 10 ^ 9 / TinK ^ 4) + 0.1856
  } else {
    stop("Invalid input for eq")
  }
}


# ——————————————————————————————————————————————————————————————————————————— #
#### temp_D47 ####
#' @title Clumped isotope thermometry
#'
#' @description
#' `temp_D47()` calculates carbonate growth temperature from D47 value.
#'
#' @param D47_CDES90 Carbonate D47 values expressed on the CDES90 scale (‰).
#' @param D47_error Error on the D47 value. Optional.
#' @param eq Equation used for the calculation. Options are as in [D47()].
#'
#' @details
#' The D47 vs temperature equations are listed at [D47()].
#'
#' @return
#' Returns the carbonate growth temperature (°C),
#' and — if `D47_error` is specified — also the error.
#'
#' @references
#' References are listed at [D47()].
#'
#' @seealso
#' [D47()] calculates the equilibrium carbonate D47 value.
#'
#' @family thermometry
#'
#' @examples
#' temp_D47(D47_CDES90 = 0.577, eq = "Petersen19")
#'
#' @export

temp_D47 = function(D47_CDES90, D47_error, eq) {
  temp_util = function (D47_CDES90, eq) {
    temp_util = c()
    for (n in 1:length(D47_CDES90)) {
      fun_to_optimize = function(x)
        abs(D47(x, eq) - D47_CDES90[n])
      tval = stats::optimize(fun_to_optimize,
                             lower = -1000,
                             upper = 1000)
      tval = as.numeric(tval$minimum)
      temp_util[n] = tval
    }
    invisible(return(round(temp_util, 1)))
  }
  temp = temp_util(D47_CDES90, eq = eq)

  if (missing(D47_error) == FALSE) {
    temp_err1 = temp_util(D47_CDES90 + D47_error, eq)
    temp_err2 = temp_util(D47_CDES90 - D47_error, eq)
    temp_err = (temp_err2 - temp_err1) / 2
    temp = c(temp, temp_err)
  }

  return(temp)

}

# ——————————————————————————————————————————————————————————————————————————— #
#### D48 ####
#' @title Equilibrium carbonate D47 value
#'
#' @description
#' `D48()` calculates the equilibrium carbonate D48 value
#' for a given temperature.
#'
#' @param temp Carbonate growth temperature (°C).
#' @param eq Equation used for the calculation.
#'   * `"Fiebig21"`: the CDES90 calibration of Fiebig et al. (2021).
#'   * `"Swart21"`: the CDES90 "PBLM1" calibration in Swart et al. (2021).
#'
#' @details
#' **"Fiebig21"**:
#'
#' \deqn{\Delta_{48, CDES90} = 1.028 \times (6.002 \times \frac{1}{T}
#'                   - 1.299 \times \frac{10^{4}}{T^{2}}
#'                   + 8.996 \times \frac{10^{6}}{T^{3}}
#'                   - 7.423 \times \frac{10^{8}}{T^{4}}) + 0.1245}
#'
#' **"Swart21"**:
#'
#' \deqn{\Delta_{48, CDES90} =
#' 0.0142 \times \frac{10^{6}}{T^{2}} + 0.088}
#'
#' @return
#' Returns the carbonate equilibrium D48 value
#' expressed on the CDES90 scale (‰).
#'
#' @references
#' Bajnai, D., Guo, W., Spötl, C., Coplen, T. B.,
#' Methner, K., Löffler, N., et al. (2020).
#' Dual clumped isotope thermometry resolves kinetic biases in
#' carbonate formation temperatures.
#' Nature Communications, 11, 4005.
#' <https://doi.org/10.1038/s41467-020-17501-0>
#'
#' Fiebig, J., Daëron, M., Bernecker, M., Guo, W.,
#' Schneider, G., Boch, R., et al. (2021).
#' Calibration of the dual clumped isotope thermometer for carbonates.
#' Geochimica et Cosmochimica Acta.
#' <https://www.doi.org/10.1016/j.gca.2021.07.012>
#'
#' Swart, P. K., Lu, C., Moore, E., Smith, M.,
#' Murray, S. T., & Staudigel, P. T. (2021).
#' A calibration equation between D48 values of carbonate and temperature.
#' Rapid Communications in Mass Spectrometry, 35(17), e9147.
#' <https://www.doi.org/10.1002/rcm.9147>
#'
#' @family equilibrium_carbonate
#'
#' @examples
#' D48(temp = 33.7, eq = "Fiebig21") # Returns 0.237
#' D48(temp = 33.7, eq = "Swart21") # Returns 0.239
#'
#' @export

D48 = function(temp, eq) {
  TinK = temp + 273.15
  if (eq == "Fiebig21") {
    1.028 * (6.002 / TinK - 1.299 * 10^4 / TinK^2 + 8.996 * 10^6 / TinK^3
             - 7.423 * 10^8 / TinK^4) + 0.1245
  } else if (eq == "Swart21") {
    b = 0.088
    m = 0.0142
    m * (10 ^ 6 / TinK ^ 2) + b
  } else {
    stop("Invalid input for eq")
  }
}


# ——————————————————————————————————————————————————————————————————————————— #
#### temp_D48 ####
#' @title Dual clumped isotope thermometry
#'
#' @description
#' `temp_D48()` calculates carbonate growth temperature from D47 and D48 values.
#'
#' @param D47_CDES90 Carbonate D47 values expressed on the CDES90 scale (‰).
#' @param D48_CDES90 Carbonate D48 values expressed on the CDES90 scale (‰).
#' @param D47_error Error on the D47 value. Optional.
#' @param D48_error Error on the D48 value. Optional.
#' @param ks Kinetic slope. Has to be negative!
#' @param add Add graphics to an already existing plot? Default: `FALSE`.
#' @param col Graphical parameter. Optional.
#' @param pch Graphical parameter. Optional.
#'
#' @details
#' The function calculates a D47 value as an intersect of two curves:
#' the equilibrium D47 vs D48 curve from Fiebig et al. (2021) and
#' the kinetic slope. The resulting D47 value is then converted to temperature
#' using the [temp_D47()] function and the equilibrium
#' D47_CDES90 vs temperature equation of Fiebig et al. (2021).
#'
#' @return
#' Returns the carbonate growth temperature (°C).
#'
#' @references
#' References are listed at [D48()] and [D47()].
#'
#' @section Contributors:
#' The source code of this function contains elements
#' from the reconPlots package, available at
#' <https://github.com/andrewheiss/reconPlots>
#'
#' @seealso
#' [D47()] calculates the equilibrium carbonate D47 value.
#' [D48()] calculates the equilibrium carbonate D48 value.
#'
#' @family thermometry
#'
#' @examples
#' temp_D48(0.617, 0.139, ks = -0.6)
#' temp_D48(0.546, 0.277, ks = -1)
#'
#' @export

temp_D48 = function(D47_CDES90, D48_CDES90, D47_error, D48_error,
                    ks, add = FALSE, col = "black", pch = 19) {

  ## curve_intersect() is based on the work of Andrew Heiss
  ## It is distributed under an MIT licence (2017).
  ## https://github.com/andrewheiss/reconPlots
  ## The source code is reproduced here with modifications.
  curve_intersect = function(curve1, curve2) {
    curve1_f = stats::approxfun(curve1$x, curve1$y, rule = 2)
    curve2_f = stats::approxfun(curve2$x, curve2$y, rule = 2)
    point_x = stats::uniroot(function(x)
      curve1_f(x) - curve2_f(x),
      c(min(curve1$x), max(curve1$x)))$root
    point_y = curve2_f(point_x)
    return(list(x = point_x, y = point_y))
  }
  ## This is the end of curve_intersect()

  line_sample = data.frame(x = c(D48_CDES90 + 1, D48_CDES90-1),
                           y = c(D47_CDES90 + 1 * ks, D47_CDES90 - 1 * ks))
  line_eq = data.frame(x = D48(seq(-10, 1000, 0.1), eq = "Fiebig21"),
                       y = D47(seq(-10, 1000, 0.1), eq = "Fiebig21"))
  int = curve_intersect(line_sample, line_eq)
  temp = round(temp_D47(int$y, eq = "Fiebig21"), 0)

  if (missing("D47_error") == FALSE && missing("D48_error") == FALSE) {
    line_cool = data.frame(x=c(D48_CDES90 + D48_error + 1,
                               D48_CDES90 + D48_error - 1),
                           y=c(D47_CDES90 + D47_error + 1 * ks,
                               D47_CDES90 + D47_error - 1 * ks))
    line_warm = data.frame(x=c(D48_CDES90 - D48_error + 1,
                               D48_CDES90 - D48_error - 1),
                           y=c(D47_CDES90 - D47_error + 1 * ks,
                               D47_CDES90 - D47_error - 1 * ks))
    int_cool = curve_intersect(line_cool, line_eq)
    int_warm = curve_intersect(line_warm, line_eq)
    temp_mean = temp
    temp_warm = round(temp_D47(int_warm$y, eq = "Fiebig21"),0)
    temp_cool = round(temp_D47(int_cool$y, eq = "Fiebig21"),0)
    temp = data.frame(temp_mean, temp_warm, temp_cool)

    if (add == TRUE) {
      graphics::rect(xleft = D48_CDES90 - D48_error,
                     ybottom = D47_CDES90 - D47_error,
                     xright = D48_CDES90 + D48_error,
                     ytop = D47_CDES90+D47_error,
                     col = grDevices::adjustcolor(col, alpha.f = 0.3),
                     border = NA)
      graphics::segments(D48_CDES90, D47_CDES90 + D47_error,
                         D48_CDES90, D47_CDES90 - D47_error,
                         col = "gray10", lwd = 1, lty = 1)
      graphics::segments(D48_CDES90 - D48_error, D47_CDES90,
                         D48_CDES90 + D48_error, D47_CDES90,
                         col = "gray10", lwd = 1, lty = 1)
      graphics::arrows(x0 = D48_CDES90 - D48_error,
                       y0 = D47_CDES90 - D47_error,
                       x1 = int_warm$x,
                       y1 = int_warm$y,
                       code=0, col = "gray70", lwd = 1.5, lty = 2)
      graphics::arrows(x0 = D48_CDES90 + D48_error,
                       y0 = D47_CDES90 + D47_error,
                       x1 = int_cool$x,
                       y1 = int_cool$y,
                       code = 0, col = "gray70", lwd = 1.5, lty = 2)
      message("Graphics added to the plot")
    }
  }

  # Add graphical output to an existing plot
  if (add == TRUE) {
    graphics::arrows(x0 = D48_CDES90,
                     y0 = D47_CDES90,
                     x1 = int$x,
                     y1 = int$y,
                     code = 2, length = 0.15, col="black", lwd = 1.5, lty = 1)
    graphics::points(D48_CDES90, D47_CDES90, col = col, pch = pch, cex = 1.2)
    message("Graphics added to the plot")
  }

  return(temp)

}
