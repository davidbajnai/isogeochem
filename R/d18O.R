# Functions in this file: d18O(), d18Ow(), temp_d18O()

#' @title Equilibrium carbonate d18O value
#' @description
#' `d18O()` calculates the d18O value of a carbonate grown at a given temperature in equilibrium with ambient water.
#' @param temperature Crystallization temperature in degrees Celsius.
#' @param d18O_water_VSMOW Water d18O value expressed on the VSMOW scale (parts per mille).
#' @param eq Defines the equation used for the calculation. Options are *"FO77", "KO97", "Coplen07", "Watkins13"*, and *"Daeron19"*.
#' Default is *"Daeron19"*.
#' @return
#' Returns the equilibrium carbonate d18O value expressed on the VSMOW scale (parts per mille).
#' @note
#' Use [VPDB()] and [VSMOW()] to convert between the VSMOW and VPDB scales.
#' @examples
#' d18O(33.7,-13.54,"Coplen07") # Returns 14.58
#' @references
#' O'Neil, J. R., Clayton, R. N., & Mayeda, T. K. (1969). Oxygen isotope fractionation in divalent metal carbonates. The Journal of Chemical Physics, 51(12), 5547-5558. <https://www.doi.org/10.1063/1.1671982>
#'
#' Friedman, I., & O'Neil, J. R. (1977). Compilation of stable isotope fractionation factors of geochemical interest. U.S. Geological Survey Professional Paper, 440-KK, 1-12. <https://www.doi.org/10.3133/pp440KK>
#'
#' Kim, S.-T., & O'Neil, J. R. (1997). Equilibrium and nonequilibrium oxygen isotope effects in synthetic carbonates. Geochimica et Cosmochimica Acta, 61(16), 3461-3475. <https://www.doi.org/10.1016/S0016-7037(97)00169-5>
#'
#' Coplen, T. B. (2007). Calibration of the calcite–water oxygen-isotope geothermometer at Devils Hole, Nevada, a natural laboratory. Geochimica et Cosmochimica Acta, 71(16), 3948-3957. <https://www.doi.org/10.1016/j.gca.2007.05.028>
#'
#' Watkins, J. M., Nielsen, L. C., Ryerson, F. J., & DePaolo, D. J. (2013). The influence of kinetics on the oxygen isotope composition of calcium carbonate. Earth and Planetary Science Letters, 375, 349-360. <https://www.doi.org/10.1016/j.epsl.2013.05.054>
#'
#' Daëron, M., Drysdale, R. N., Peral, M., Huyghe, D., Blamart, D., Coplen, T. B., et al. (2019). Most Earth-surface calcites precipitate out of isotopic equilibrium. Nature Communications, 10, 429. <https://www.doi.org/10.1038/s41467-019-08336-5>
#' @seealso [d18Ow()]
#' @seealso [temp_d18O()]
#' @export

d18O = function(temperature, d18O_water_VSMOW, eq ="Daeron19") {
  TinK = temperature + 273.15
  if(eq == "Daeron19") { # Daeron et al. (2019)
  alpha18_cc_water = exp( (17.57*1000/TinK-29.13) / 1000 )
  }
  if(eq == "Coplen07") { # Coplen (2007)
  alpha18_cc_water = exp( (17.4 *1000/TinK-28.6 ) / 1000 )
  }
  if(eq == "KO97") { # Kim and O'Neil (1997)
  alpha18_cc_water = exp( (18.03*1000/TinK-32.42) / 1000 )
  }
  if(eq == "Watkins13") { # Watkins et al. (2013)
  alpha18_cc_water = exp( (17.747*1000/TinK-29.777) / 1000 )
  }
  if(eq == "FO77") { # O'Neil et al. (1969) reprocessed by Friedman and O'Neil (1977)
  alpha18_cc_water = exp( (2.78*10^6/TinK^2-2.89) / 1000 )
  }
  d18O_carbonate_VSMOW = alpha18_cc_water*(d18O_water_VSMOW+1000)-1000
  return(d18O_carbonate_VSMOW)
}

##————————————————————————————————————————————————————————————————————————————————##

#' @title Calculate 18O/16O fractionation factor
#' @description
#' `alpha18_cc_water()` calculates the d18O value of the ambient water
#' from the d18O value of a carbonate and its crystallization temperature.
#' @param temperature Crystallization temperature, in degrees Celsius.
#' @param eq Defines the equation used for the calculation. Options are *"KO97", "Coplen07", "Watkins13"*, and *"Daeron19"*.
#' Default is *"Daeron19"*.
#' @return
#' Returns the 18O/16O oxygen isotope fractionation factor.
#' @examples
#' alpha18_cc_water(33.7,"Coplen07") # Returns -13.54
#' @references
#' O'Neil, J. R., Clayton, R. N., & Mayeda, T. K. (1969). Oxygen isotope fractionation in divalent metal carbonates. The Journal of Chemical Physics, 51(12), 5547-5558. <https://www.doi.org/10.1063/1.1671982>
#'
#' Kim, S.-T., & O'Neil, J. R. (1997). Equilibrium and nonequilibrium oxygen isotope effects in synthetic carbonates. Geochimica et Cosmochimica Acta, 61(16), 3461-3475. <https://www.doi.org/10.1016/S0016-7037(97)00169-5>
#'
#' Coplen, T. B. (2007). Calibration of the calcite–water oxygen-isotope geothermometer at Devils Hole, Nevada, a natural laboratory. Geochimica et Cosmochimica Acta, 71(16), 3948-3957. <https://www.doi.org/10.1016/j.gca.2007.05.028>
#'
#' Watkins, J. M., Nielsen, L. C., Ryerson, F. J., & DePaolo, D. J. (2013). The influence of kinetics on the oxygen isotope composition of calcium carbonate. Earth and Planetary Science Letters, 375, 349-360. <https://www.doi.org/10.1016/j.epsl.2013.05.054>
#'
#' Daëron, M., Drysdale, R. N., Peral, M., Huyghe, D., Blamart, D., Coplen, T. B., et al. (2019). Most Earth-surface calcites precipitate out of isotopic equilibrium. Nature Communications, 10, 429. <https://www.doi.org/10.1038/s41467-019-08336-5>
#' @seealso [d18O()]
#' @export

alpha18_cc_water = function(temperature, eq ="Daeron19") {
  TinK = temperature + 273.15
  if(eq == "Daeron19") { # Daeron et al. (2019)
  alpha18_cc_water = exp( (17.57*1000/TinK-29.13) / 1000 )
  }
  if(eq == "Coplen07") { # Coplen (2007)
  alpha18_cc_water = exp( (17.4 *1000/TinK-28.6 ) / 1000 )
  }
  if(eq == "KO97") { # Kim and O'Neil (1997)
  alpha18_cc_water = exp( (18.03*1000/TinK-32.42) / 1000 )
  }
  if(eq == "Watkins13") { # Watkins et al. (2013)
  alpha18_cc_water = exp( (17.747*1000/TinK-29.777) / 1000 )
  }
  if(eq == "FO77") { # O'Neil et al. (1969) reprocessed by Friedman and O'Neil (1977)
  alpha18_cc_water = exp( (2.78*10^6/TinK^2-2.89) / 1000 )
  }
  return(alpha18_cc_water)
}

##————————————————————————————————————————————————————————————————————————————————##

#' @title Calculate water d18O value
#' @description
#' `d18Ow()` calculates the d18O value of the ambient water
#' from the d18O value of a carbonate and its crystallization temperature.
#' @param temperature Crystallization temperature, in degrees Celsius.
#' @param d18O_carbonate_VSMOW Carbonate d18O value expressed on the VSMOW scale (parts per mille).
#' @param eq Defines the equation used for the calculation. Options are *"FO77", "KO97", "Coplen07", "Watkins13"*, and *"Daeron19"*.
#' Default is *"Daeron19"*.
#' @return
#' Returns the water d18O value expressed on the VSMOW scale (parts per mille).
#' @note
#' Use [VPDB()] and [VSMOW()] to convert between the VSMOW and VPDB scales.
#' @examples
#' d18Ow(33.7,14.58,"Coplen07") # Returns -13.54
#' @references
#' O'Neil, J. R., Clayton, R. N., & Mayeda, T. K. (1969). Oxygen isotope fractionation in divalent metal carbonates. The Journal of Chemical Physics, 51(12), 5547-5558. <https://www.doi.org/10.1063/1.1671982>
#'
#' Friedman, I., & O'Neil, J. R. (1977). Compilation of stable isotope fractionation factors of geochemical interest. U.S. Geological Survey Professional Paper, 440-KK, 1-12. <https://www.doi.org/10.3133/pp440KK>
#'
#' Kim, S.-T., & O'Neil, J. R. (1997). Equilibrium and nonequilibrium oxygen isotope effects in synthetic carbonates. Geochimica et Cosmochimica Acta, 61(16), 3461-3475. <https://www.doi.org/10.1016/S0016-7037(97)00169-5>
#'
#' Coplen, T. B. (2007). Calibration of the calcite–water oxygen-isotope geothermometer at Devils Hole, Nevada, a natural laboratory. Geochimica et Cosmochimica Acta, 71(16), 3948-3957. <https://www.doi.org/10.1016/j.gca.2007.05.028>
#'
#' Watkins, J. M., Nielsen, L. C., Ryerson, F. J., & DePaolo, D. J. (2013). The influence of kinetics on the oxygen isotope composition of calcium carbonate. Earth and Planetary Science Letters, 375, 349-360. <https://www.doi.org/10.1016/j.epsl.2013.05.054>
#'
#' Daëron, M., Drysdale, R. N., Peral, M., Huyghe, D., Blamart, D., Coplen, T. B., et al. (2019). Most Earth-surface calcites precipitate out of isotopic equilibrium. Nature Communications, 10, 429. <https://www.doi.org/10.1038/s41467-019-08336-5>
#' @seealso [d18O()] [temp_d18O()]
#' @export

d18Ow = function(temperature, d18O_carbonate_VSMOW, eq ="Daeron19") {
  TinK = temperature + 273.15
  if(eq == "Daeron19") { # Daeron et al. (2019)
  alpha18_cc_water = exp( (17.57*1000/TinK-29.13) / 1000 )
  }
  if(eq == "Coplen07") { # Coplen (2007)
  alpha18_cc_water = exp( (17.4 *1000/TinK-28.6 ) / 1000 )
  }
  if(eq == "KO97") { # Kim and O'Neil (1997)
  alpha18_cc_water = exp( (18.03*1000/TinK-32.42) / 1000 )
  }
  if(eq == "Watkins13") { # Watkins et al. (2013)
  alpha18_cc_water = exp( (17.747*1000/TinK-29.777) / 1000 )
  }
  if(eq == "FO77") { # O'Neil et al. (1969) reprocessed by Friedman and O'Neil (1977)
  alpha18_cc_water = exp( (2.78*10^6/TinK^2-2.89) / 1000 )
  }
  d18O_water_VSMOW = (d18O_carbonate_VSMOW+1000)/alpha18_cc_water - 1000
  return(d18O_water_VSMOW)
}

##————————————————————————————————————————————————————————————————————————————————##

#' @title Carbonate growth temperature from d18O
#' @description
#' `temp_d18O()` calculates carbonate growth temperatures from oxygen isotope data.
#' @param d18O_carbonate_VSMOW Carbonate d18O value expressed on the VSMOW scale (parts per mille).
#' @param d18O_water_VSMOW Water d18O value expressed on the VSMOW scale (parts per mille).
#' @param eq Defines the equation used for the calculation. Options are *"FO77", "KO97", "Coplen07", "Watkins13"*, and *"Daeron19"*.
#' Default is *"Daeron19"*.
#' @return
#' Returns a single numeric value. The result is the carbonate growth temperature, in degrees Celsius.
#' @note
#' Use [VPDB()] and [VSMOW()] to convert between the VSMOW and VPDB scales.
#' @examples
#' temp_d18O(14.58, -13.54, "Coplen07") # Returns 33.7
#' @references
#' O'Neil, J. R., Clayton, R. N., & Mayeda, T. K. (1969). Oxygen isotope fractionation in divalent metal carbonates. The Journal of Chemical Physics, 51(12), 5547-5558. <https://www.doi.org/10.1063/1.1671982>
#'
#' Friedman, I., & O'Neil, J. R. (1977). Compilation of stable isotope fractionation factors of geochemical interest. U.S. Geological Survey Professional Paper, 440-KK, 1-12. <https://www.doi.org/10.3133/pp440KK>
#'
#' Kim, S.-T., & O'Neil, J. R. (1997). Equilibrium and nonequilibrium oxygen isotope effects in synthetic carbonates. Geochimica et Cosmochimica Acta, 61(16), 3461-3475. <https://www.doi.org/10.1016/S0016-7037(97)00169-5>
#'
#' Coplen, T. B. (2007). Calibration of the calcite–water oxygen-isotope geothermometer at Devils Hole, Nevada, a natural laboratory. Geochimica et Cosmochimica Acta, 71(16), 3948-3957. <https://www.doi.org/10.1016/j.gca.2007.05.028>
#'
#' Watkins, J. M., Nielsen, L. C., Ryerson, F. J., & DePaolo, D. J. (2013). The influence of kinetics on the oxygen isotope composition of calcium carbonate. Earth and Planetary Science Letters, 375, 349-360. <https://www.doi.org/10.1016/j.epsl.2013.05.054>
#'
#' Daëron, M., Drysdale, R. N., Peral, M., Huyghe, D., Blamart, D., Coplen, T. B., et al. (2019). Most Earth-surface calcites precipitate out of isotopic equilibrium. Nature Communications, 10, 429. <https://www.doi.org/10.1038/s41467-019-08336-5>
#' @seealso [d18O()]
#' @seealso [d18Ow()]
#' @export

temp_d18O = function(d18O_carbonate_VSMOW, d18O_water_VSMOW, eq ="Daeron19") {
  alpha18_cc_water = (d18O_carbonate_VSMOW+1000)/(d18O_water_VSMOW+1000)
  if(eq == "Daeron19") { # Daeron et al. (2019)
  TinK = (17.57*1000)/(log(alpha18_cc_water)*1000 + 29.13)
  }
  if(eq == "Coplen07") { # Coplen (2007)
  TinK = (17.4*1000)/(log(alpha18_cc_water)*1000 + 28.6)
  }
  if(eq == "KO97") { # Kim and O'Neil (1997)
  TinK = (18.03*1000)/(log(alpha18_cc_water)*1000 + 32.42)
  }
  if(eq == "Watkins13") { # Watkins et al. (2013)
  TinK = (17.747*1000)/(log(alpha18_cc_water)*1000 + 29.777)
  }
  if(eq == "FO77") { # O'Neil et al. (1969) reprocessed by Friedman and O'Neil (1977)
  TinK = sqrt((2.78*10^6)/(log(alpha18_cc_water)*1000 + 2.89))
  }
  TinC = TinK-273.15
  return(TinC)
}
