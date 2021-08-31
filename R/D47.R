# Functions in this file: temp_D47(), D47()

#' @title Carbonate growth temperature from D47
#' @description
#' `temp_D47()` calculates carbonate growth temperature from clumped isotope composition (D47).
#' @param D47_CDES90 Carbonate D47 values expressed on the CDES90 scale: referenced to 90°C acid digestion.
#' @param eq Defines the equation used for the calculation. Options are *"Kele15"* and *"Petersen19"*.
#' Default is *"Petersen19"*, which refers to the synthetic-only IUPAC-reprocessed "Br "UNICAL" calibration of Petersen et al. (2019).
#' *"Kele14"* refers to the Kele et al. (2015) calibration reprocessed by Bernasconi et al. (2020) using the IUPAC parameters.
#' @return
#' Returns the carbonate growth temperature in degrees Celsius.
#' @examples
#' temp_D47(0.580) # Returns 33.7
#' @references
#' Kele, S., Breitenbach, S. F. M., Capezzuoli, E., Meckler, A. N., Ziegler, M., Millan, I. M., et al. (2015). Temperature dependence of oxygen- and clumped isotope fractionation in carbonates: a study of travertines and tufas in the 6–95 °C temperature range. Geochimica et Cosmochimica Acta, 168, 172-192. <https://www.doi.org/10.1016/j.gca.2015.06.032>
#'
#' Bernasconi, S. M., Müller, I. A., Bergmann, K. D., Breitenbach, S. F. M., Fernandez, A., Hodell, D. A., et al. (2018). Reducing uncertainties in carbonate clumped isotope analysis through consistent carbonate-based standardization. Geochemistry, Geophysics, Geosystems, 19(9), 2895-2914. <https://www.doi.org/10.1029/2017gc007385>
#'
#' Petersen, S. V., Defliese, W. F., Saenger, C., Daëron, M., Huntington, K. W., John, C. M., et al. (2019). Effects of improved 17O correction on interlaboratory agreement in clumped isotope calibrations, estimates of mineral-specific offsets, and temperature dependence of acid digestion fractionation. Geochemistry, Geophysics, Geosystems, 20(7), 3495-3519. <https://www.doi.org/10.1029/2018GC008127>
#' @seealso [temp_d18O()]
#' @export
temp_D47 = function(D47_CDES90, eq ="Petersen19") {
  if(eq == "Petersen19") { # Petersen et al. (2019)
  b = 0.257-0.088; m = 0.0387
  }
  if(eq == "Kele15") { # Kele et al. (2015) reprocessed by Bernasconi et al. (2018)
  b = 0.167; m = 0.0449
  }
  TinC = sqrt(10^6/((D47_CDES90-b)/m))-273.15
  return(TinC)
}

##————————————————————————————————————————————————————————————————————————————————##

#' @title Carbonate D47 for given temperatures
#' @description
#' `D47()` calculates carbonate D47 values for given temperatures.
#' @param temperature Carbonate growth temperature in degrees Celsius.
#' @param eq Defines the equation used for the calculation. Options are *"Petersen19"* and *"Fiebig21"*.
#' Default is *"Fiebig21"*, which refers to the CDES90 calibration in Fiebig et al. (2021).
#' *"Petersen19"* refers to the synthetic-only D47-RFACBr,WD "UNICAL" calibration of Petersen et al. (2019).
#' @return
#' Returns carbonate D47 values expressed on the CDES90 scale: referenced to 90°C acid digestion.
#' @examples
#' D47(33.7) # Returns 0.5713
#' @references
#' Petersen, S. V., Defliese, W. F., Saenger, C., Daëron, M., Huntington, K. W., John, C. M., et al. (2019). Effects of improved 17O correction on interlaboratory agreement in clumped isotope calibrations, estimates of mineral-specific offsets, and temperature dependence of acid digestion fractionation. Geochemistry, Geophysics, Geosystems, 20(7), 3495-3519. <https://www.doi.org/10.1029/2018GC008127>
#'
#' Fiebig, J., Daëron, M., Bernecker, M., Guo, W., Schneider, G., Boch, R., et al. (2021). Calibration of the dual clumped isotope thermometer for carbonates. Geochimica et Cosmochimica Acta. <https://www.doi.org/10.1016/j.gca.2021.07.012>
#' @seealso [temp_D47()]
#' @seealso [D48()]
#' @export

D47 = function(temperature, eq ="Fiebig21") {
  TinK = temperature+273.15
  if(eq == "Petersen19") { # Petersen et al. (2019)
  b = 0.257-0.088; m = 0.0387
  D47 = m* (10^6/TinK^2) + b
  }
  if(eq == "Fiebig21") { # Fiebig et al. (2021)
  D47 = 1.038*(-5.897/TinK - 3.521*10^3/TinK^2 + 2.391*10^7/TinK^3 - 3.541*10^9/TinK^4) + 0.1856
  }
  return(D47)
}
