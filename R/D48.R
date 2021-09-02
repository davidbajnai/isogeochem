# Functions in this file: D48(), temp_D48()

#' @title Carbonate D48 at given temperature
#' @description
#' `D48()` calculates carbonate D48 values for given temperatures.
#' @param temperature Carbonate growth temperature in degrees Celsius.
#' @param eq Equation used for the calculation. Options are `"Fiebig21"` and `"Swart21"`.
#' Default is `"Fiebig21"`, which refers to the CDES90 calibration in Fiebig et al. (2021). `"Swart21"` refers to the CDES90 "PBLM1" calibration in Swart et al. (2021).
#' @return
#' Returns carbonate D48 values expressed on the CDES90 scale: referenced to 90°C acid digestion.
#' @examples
#' D48(33.7) # Returns 0.237
#' D48(33.7,"Swart21") # Returns 0.239
#' @references
#' Fiebig, J., Daëron, M., Bernecker, M., Guo, W., Schneider, G., Boch, R., et al. (2021). Calibration of the dual clumped isotope thermometer for carbonates. Geochimica et Cosmochimica Acta. <https://www.doi.org/10.1016/j.gca.2021.07.012>
#'
#' Swart, P. K., Lu, C., Moore, E., Smith, M., Murray, S. T., & Staudigel, P. T. (2021). A calibration equation between D48 values of carbonate and temperature. Rapid Communications in Mass Spectrometry, 35(17), e9147. <https://www.doi.org/10.1002/rcm.9147>
#' @seealso [D47()]
#' @export

D48 = function(temperature, eq ="Fiebig21") {
  TinK = temperature+273.15
  if(eq == "Fiebig21") {
  D48 = 1.028*(6.002/TinK - 1.299*10^4/TinK^2 + 8.996*10^6/TinK^3 - 7.423*10^8/TinK^4) + 0.1245
  }
  if(eq == "Swart21") {
  b = 0.088; m = 0.0142
  D48 = m* (10^6/TinK^2) + b
  }
  return(D48)
}



#' @title Dual clumped isotope thermometry
#' @description
#' `temp_D48()` calculates growth temperatures from D47 and D48 values.
#' @param D47_CDES90 Carbonate D47 values expressed on the CDES90 scale.
#' @param D48_CDES90 Carbonate D48 values expressed on the CDES90 scale.
#' @param ks Kinetic slope. Either -0.6 or -1. Has to be negative!
#' @param add Add kinetic slope to an already existing plot?
#' @return
#' Returns the carbonate growth temperature in degrees Celsius.
#' @examples
#' temp_D48(0.617, 0.139, -0.6) # Returns 44
#' temp_D48(0.546, 0.277, -1)   # Returns 33
#' @references
#' Fiebig, J., Daëron, M., Bernecker, M., Guo, W., Schneider, G., Boch, R., et al. (2021). Calibration of the dual clumped isotope thermometer for carbonates. Geochimica et Cosmochimica Acta. <https://www.doi.org/10.1016/j.gca.2021.07.012>
#' @seealso [D48()]
#' @seealso [temp_D47()]
#' @details
#' The function calculates a D47 value as an intersect of two curves:
#' * the equilibrium D47 vs D48 curve from Fiebig et al. (2021)
#' * the kinetic slope
#'
#' The resulting D47 value is then converted to temperature using the [D47()] function, i.e., by default the
#' equation of Petersen et al. (2019). This is not consistent and I will fix it in a later version.
#' In any case, the resulting discrepancy is smaller than the temperature error.
#' @export

temp_D48 = function(D47_CDES90, D48_CDES90, ks, add = F) {
  line1 = data.frame(x=c(D48_CDES90+1, D48_CDES90-1), y=c(D47_CDES90+1*ks, D47_CDES90-1*ks))
  line2 = data.frame(x=D48(seq(-10,1000,0.1)),          y=D47(seq(-10,1000,0.1)))
  int   = reconPlots::curve_intersect(line1, line2)
  temp  = round(temp_D47(int$y),0)

  if (add) {
    # Add the sample point and the kinetic slope to an already existing plot
    graphics::arrows(x0=D48_CDES90, y0=D47_CDES90, x1=int$x, y1=int$y, code=2,  length = 0.15, col="black", lwd=1.5, lty=1)
  }

return(temp)
}
