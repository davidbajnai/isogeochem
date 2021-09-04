# Functions in this file: D48(), temp_D48()

#' @title Carbonate D48 for a given temperature
#'
#' @description
#' `D48c()` calculates the equilibrium carbonate D48 value for a given temperature.
#'
#' @param temperature Carbonate growth temperature (°C).
#' @param eq Equation used for the calculation. Options are `"Fiebig21"` (default) and `"Swart21"`.
#'   `"Fiebig21"` refers to the CDES90 calibration in Fiebig et al. (2021).
#'   `"Swart21"` refers to the CDES90 "PBLM1" calibration in Swart et al. (2021).
#'
#' @return
#' Returns the carbonate D48 value expressed on the CDES90 scale (‰).
#'
#' @examples
#' D48c(33.7) # Returns 0.237
#' D48c(33.7,"Swart21") # Returns 0.239
#'
#' @references
#' Fiebig, J., Daëron, M., Bernecker, M., Guo, W., Schneider, G., Boch, R., et al. (2021).
#' Calibration of the dual clumped isotope thermometer for carbonates. Geochimica et Cosmochimica Acta.
#' <https://www.doi.org/10.1016/j.gca.2021.07.012>
#'
#' Swart, P. K., Lu, C., Moore, E., Smith, M., Murray, S. T., & Staudigel, P. T. (2021).
#' A calibration equation between D48 values of carbonate and temperature.
#' Rapid Communications in Mass Spectrometry, 35(17), e9147.
#' <https://www.doi.org/10.1002/rcm.9147>
#'
#' @family equilibrium_carbonate
#' @export

D48c = function(temperature, eq ="Fiebig21") {
  TinK = temperature+273.15
  if (eq == "Fiebig21") {
  1.028 *(6.002 / TinK - 1.299 * 10^4 / TinK^2 + 8.996 * 10^6 / TinK^3 - 7.423 * 10^8 / TinK^4) + 0.1245
  } else if (eq == "Swart21") {
  b = 0.088; m = 0.0142
  m * (10^6 / TinK^2) + b
  } else {
    warning("ERROR! Invalid input for eq")
  }

}

##————————————————————————————————————————————————————————————————————————————————##


#' @title Dual clumped isotope thermometry
#'
#' @description `temp_D48()` calculates carbonate growth temperature from D47 and D48 values.
#'
#' @param D47_CDES90 Carbonate D47 values expressed on the CDES90 scale (‰).
#' @param D48_CDES90 Carbonate D48 values expressed on the CDES90 scale (‰).
#' @param D47_error Error on the D47 value. Optional.
#' @param D48_error Error on the D48 value. Optional.
#' @param ks Kinetic slope. Has to be negative!
#' @param add Add graphics to an already existing plot? Default `FALSE`.
#' @param col Graphical parameter. Optional.
#' @param pch Graphical parameter. Optional.
#'
#' @return
#' Returns the carbonate growth temperature (‰).
#'
#' @examples
#' temp_D48(0.617, 0.139, ks = -0.6) # Returns 44
#' temp_D48(0.546, 0.277, ks = -1)   # Returns 33
#'
#' @references
#' References are listed at [D48c()] and [D47c()].
#'
#' @seealso [D47c()] calculates the equilibrium carbonate D47 value for a given temperature.
#' @seealso [D48c()] calculates the equilibrium carbonate D48 value for a given temperature.
#'
#' @details
#' The function calculates a D47 value as an intersect of two curves:
#' * the equilibrium D47 vs D48 curve from Fiebig et al. (2021)
#' * the kinetic slope
#'
#' The resulting D47 value is then converted to temperature using the [D47c()] function, i.e., by default the
#' equation of Petersen et al. (2019). This is not consistent and I will fix it in a later version.
#' In any case, the resulting discrepancy is smaller than the temperature error.
#'
#'@family thermometry
#'
#' @export

temp_D48 = function(D47_CDES90, D48_CDES90, D47_error, D48_error, ks, add = FALSE, col, pch) {
  line_sample = data.frame(x=c(D48_CDES90+1, D48_CDES90-1),
                           y=c(D47_CDES90+1*ks, D47_CDES90-1*ks))
  line_eq = data.frame(x=D48c(seq(-10,1000,0.1)), y=D47c(seq(-10,1000,0.1)))
  int = reconPlots::curve_intersect(line_sample, line_eq)

  temp = round(temp_D47(int$y),0)

  if (missing(D47_error) == FALSE && missing("D48_error") == FALSE) {
    line_cool = data.frame(x=c(D48_CDES90+D48_error+1, D48_CDES90+D48_error-1),
                           y=c(D47_CDES90+D47_error+1*ks, D47_CDES90+D47_error-1*ks))
    line_warm = data.frame(x=c(D48_CDES90-D48_error+1, D48_CDES90-D48_error-1),
                           y=c(D47_CDES90-D47_error+1*ks, D47_CDES90-D47_error-1*ks))
    int_cool = reconPlots::curve_intersect(line_cool, line_eq)
    int_warm = reconPlots::curve_intersect(line_warm, line_eq)
    temp_mean = temp
    temp_warm = round(temp_D47(int_warm$y),0)
    temp_cool = round(temp_D47(int_cool$y),0)
    temp = data.frame(temp_mean, temp_warm, temp_cool)

    if (add == TRUE) {
      if (missing(col) == T) col = "black" else col = col
      if (missing(pch) == T) pch = 19 else pch = pch
      graphics::rect(xleft = D48_CDES90-D48_error, ybottom = D47_CDES90-D47_error,
                     xright = D48_CDES90+D48_error, ytop = D47_CDES90+D47_error,
                     col = grDevices::adjustcolor(col, alpha.f = 0.3), border = NA)
      graphics::segments(D48_CDES90, D47_CDES90+D47_error, D48_CDES90, D47_CDES90-D47_error,
                         col="gray10", lwd=1, lty=1)
      graphics::segments(D48_CDES90-D48_error, D47_CDES90, D48_CDES90+D48_error, D47_CDES90,
                         col="gray10", lwd=1, lty=1)
      graphics::arrows(x0=D48_CDES90-D48_error, y0=D47_CDES90-D47_error,
                       x1=int_warm$x,           y1=int_warm$y,
                       code=0, col="gray70", lwd=1.5, lty=2)
      graphics::arrows(x0=D48_CDES90+D48_error, y0=D47_CDES90+D47_error,
                       x1=int_cool$x,           y1=int_cool$y,
                       code=0, col="gray70", lwd=1.5, lty=2)
    }
  }

  if (add == TRUE) {
    graphics::arrows(x0=D48_CDES90, y0=D47_CDES90,
                     x1=int$x,      y1=int$y,
                     code=2,  length = 0.15, col="black", lwd=1.5, lty=1)
    graphics::points(D48_CDES90, D47_CDES90,
           col = col, pch = pch, cex = 1.2)
  }

  return(temp)

}
