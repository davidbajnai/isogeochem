# Functions in this file: temp_D47(), D47()

#' @title Carbonate D47 for a given temperature
#'
#' @description
#' `D47c()` calculates the equilibrium carbonate D47 value for a given temperature.
#'
#' @param temp Carbonate growth temperature (°C).
#' @param eq Equation used for the calculation. Options are `"Fiebig21"` (default) and `"Petersen19"`.
#' `"Fiebig21"` refers to the CDES90 calibration in Fiebig et al. (2021).
#' `"Petersen19"` refers to the synthetic-only D47-RFACBr,WD "UNICAL" calibration of Petersen et al. (2019).
#'
#' @return
#' Returns the carbonate D47 value expressed on the CDES90 scale.
#'
#' @examples
#' D47c(33.7) # Returns 0.5713
#'
#' @references
#' Petersen, S. V., Defliese, W. F., Saenger, C., Daëron, M., Huntington, K. W., John, C. M., et al. (2019).
#' Effects of improved 17O correction on interlaboratory agreement in clumped isotope calibrations, estimates of mineral-specific offsets, and temperature dependence of acid digestion fractionation.
#' Geochemistry, Geophysics, Geosystems, 20(7), 3495-3519.
#' <https://www.doi.org/10.1029/2018GC008127>
#'
#' Fiebig, J., Daëron, M., Bernecker, M., Guo, W., Schneider, G., Boch, R., et al. (2021).
#' Calibration of the dual clumped isotope thermometer for carbonates. Geochimica et Cosmochimica Acta.
#' <https://www.doi.org/10.1016/j.gca.2021.07.012>
#'
#' @seealso [temp_D47()]
#' @family equilibrium_carbonate
#' @export

D47c = function(temp, eq ="Fiebig21") {
  TinK = temp+273.15
  if(eq == "Petersen19") { # Petersen et al. (2019)
  b = 0.257-0.088; m = 0.0387
  D47 = m* (10^6/TinK^2) + b
  }
  if(eq == "Fiebig21") { # Fiebig et al. (2021)
  D47 = 1.038*(-5.897/TinK - 3.521*10^3/TinK^2 + 2.391*10^7/TinK^3 - 3.541*10^9/TinK^4) + 0.1856
  }
  return(D47)
}

##————————————————————————————————————————————————————————————————————————————————##


#' @title Clumped isotope thermometry
#' @description
#' `temp_D47()` calculates carbonate growth temperature from D47 value.
#'
#' @param D47_CDES90 Carbonate D47 values expressed on the CDES90 scale: referenced to 90°C acid digestion (‰).
#' @param D47_error Error on the D47 value. Optional.
#' @param eq Equation used for the calculation. Options are `"Petersen19"` (default) and `"Kele15"`.
#' `"Petersen19"` refers to the synthetic-only IUPAC-reprocessed "Br "UNICAL" calibration of Petersen et al. (2019).
#' `"Kele14"` refers to the Kele et al. (2015) calibration reprocessed by Bernasconi et al. (2020) using the IUPAC parameters.
#'
#' @return
#' Returns the carbonate growth temperature (°C),
#' and — if `D47_error` is specified — also the error.
#' @examples
#' temp_D47(0.580) # Returns 33.7
#' temp_D47(0.580, 0.004) # Returns 33.7 and 1.9
#'
#' @references
#' References are listed at [D47c()].
#'
#' @seealso [D47c()] calculates the equilibrium carbonate D47 value for a given temperature.
#'
#' @family thermometry
#'
#' @export

temp_D47 = function(D47_CDES90, D47_error, eq = "Petersen19") {

  temp_util = function (D47_CDES90, eq) {
    if (eq == "Petersen19") {
      # Petersen et al. (2019)
      b = 0.257-0.088; m = 0.0387
      temp_util = sqrt(10^6/((D47_CDES90-b)/m))-273.15
    } else if (eq == "Kele15") {
      # Kele et al. (2015) reprocessed by Bernasconi et al. (2018)
      b = 0.167; m = 0.0449
      temp_util = sqrt(10^6/((D47_CDES90-b)/m))-273.15
    } else {
    warning("ERROR! Invalid input for eq")
    }
    invisible(return(temp_util))
  }

  temp = temp_util(D47_CDES90, eq)

  if (missing(D47_error) == FALSE) {
    temp_err1 = temp_util(D47_CDES90 + D47_error, eq)
    temp_err2 = temp_util(D47_CDES90 - D47_error, eq)
    temp_err = (temp_err2 - temp_err1) / 2
    temp = data.frame(temp, temp_err)

  }

  return(temp)

}
