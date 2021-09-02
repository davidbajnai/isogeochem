# Functions in this file: d18O(), d18Ow(), temp_d18O()

#' @title Calculate 18O/16O fractionation factor between CaCO3 and H2O
#' @description
#' `a18_c_w()` calculates the 18O/16O oxygen isotope fractionation factor between calcium carbonate and water
#' @param temp Crystallization temperature, in degrees Celsius.
#' @param min Mineralogy. Options are `"calcite"` (default), `"aragonite"`, and `"dolomite"`.
#' @param eq Equation used to calculate the equilibrium 18O/16O oxygen isotope
#' fractionation factor between calcium carbonate and water. Options depend on mineralogy.
#' For calcite choose from `"Daeron19"` (default), `"Watkins13"`, `"Coplen07"`, `"KO97"` , and `"FO77"`.
#' For aragonite and dolomite the eq need not be specified.
#' @return
#' Returns the 18O/16O oxygen isotope fractionation factor "alpha"
#' and the corresponding isotope fractionation value "epsilon" (parts per mille).
#' @examples
#' a18_c_w(25, "calcite")   # Returns 1.030249 and 30.25
#' a18_c_w(25, "aragonite") # Returns 1.000913 and 0.91
#' a18_c_w(25, "dolomite")  # Returns 1.031456 and 31.46
#' @references
#' **Calcite:**
#'
#' O'Neil, J. R., Clayton, R. N., & Mayeda, T. K. (1969). Oxygen isotope fractionation in divalent metal carbonates. The Journal of Chemical Physics, 51(12), 5547-5558. <https://www.doi.org/10.1063/1.1671982>
#'
#' Kim, S.-T., & O'Neil, J. R. (1997). Equilibrium and nonequilibrium oxygen isotope effects in synthetic carbonates. Geochimica et Cosmochimica Acta, 61(16), 3461-3475. <https://www.doi.org/10.1016/S0016-7037(97)00169-5>
#'
#' Coplen, T. B. (2007). Calibration of the calcite–water oxygen-isotope geothermometer at Devils Hole, Nevada, a natural laboratory. Geochimica et Cosmochimica Acta, 71(16), 3948-3957. <https://www.doi.org/10.1016/j.gca.2007.05.028>
#'
#' Watkins, J. M., Nielsen, L. C., Ryerson, F. J., & DePaolo, D. J. (2013). The influence of kinetics on the oxygen isotope composition of calcium carbonate. Earth and Planetary Science Letters, 375, 349-360. <https://www.doi.org/10.1016/j.epsl.2013.05.054>
#'
#' Daëron, M., Drysdale, R. N., Peral, M., Huyghe, D., Blamart, D., Coplen, T. B., et al. (2019). Most Earth-surface calcites precipitate out of isotopic equilibrium. Nature Communications, 10, 429. <https://www.doi.org/10.1038/s41467-019-08336-5>
#'
#' **Aragonite:**
#'
#' Dettman, D. L., Reische, A. K., & Lohmann, K. C. (1999). Controls on the stable isotope composition of seasonal growth bands in aragonitic fresh-water bivalves (unionidae). Geochimica et Cosmochimica Acta, 63(7-8), 1049-1057. <https://www.doi.org/10.1016/s0016-7037(99)00020-4>
#'
#' **Dolomite:**
#'
#' Vasconcelos, C., McKenzie, J. A., Warthmann, R., & Bernasconi, S. M. (2005). Calibration of the d18O paleothermometer for dolomite precipitated in microbial cultures and natural environments. Geology, 33(4), 317-320. <https://www.doi.org/10.1130/g20992.1>
#' @seealso [d18O()]
#' @export

a18_c_w = function(temp, min = "calcite", eq = "Daeron19") {
  TinK = temp + 273.15

  if        (min == "calcite" | min == "Cal" ) {

    if        (eq == "Daeron19")  {
      # Daeron et al. (2019)
      a = exp((17.57*1000/TinK-29.13) / 1000)
    } else if (eq == "Coplen07")  {
      # Coplen (2007)
      a = exp((17.4*1000/TinK-28.6) / 1000)
    } else if (eq == "KO97")      {
      # Kim and O'Neil (1997)
      a = exp((18.03*1000/TinK-32.42) / 1000)
    } else if (eq == "Watkins13") {
      # Watkins et al. (2013)
      a = exp((17.747*1000/TinK-29.777) / 1000)
    } else if (eq == "FO77")      {
      # O'Neil et al. (1969) reprocessed by Friedman and O'Neil (1977)
      a = exp((2.559*10^6/TinK^2-2.89) / 1000 )
    } else {
      stop("ERROR! Invalid input for eq")
    }

  } else if (min == "aragonite" | min == "Arg" ) {
      # Grossman and Ku (1986) reprocessed by Dettman et al. (1999)
      a = exp((2.559*10^6/TinK^2+0.715) / 1000)

  } else if (min == "dolomite" | min == "Dol" ) {
      # Vasconcelos et al. (2005)
      a = exp((2.73*10^6/TinK^2+0.26) / 1000)

  } else {
      stop("ERROR! Invalid input for min")
  }

  e = (a - 1) * 1000

  return(c(a,e))
}

##————————————————————————————————————————————————————————————————————————————————##

#' @title Equilibrium carbonate d18O value
#' @description
#' `d18O()` calculates the d18O value of a carbonate grown at a given temperature in equilibrium with ambient water.
#' @param temp Crystallization temperature in degrees Celsius.
#' @param d18Ow_VSMOW Water d18O value expressed on the VSMOW scale (parts per mille).
#' @param min Mineralogy. Options are `"calcite"` (default), `"aragonite"`, and `"dolomite"`.
#' @param eq Equation used to calculate the equilibrium 18O/16O oxygen isotope
#' fractionation factor between calcium carbonate and water. Options depend on mineralogy.
#' For calcite choose from `"Daeron19"` (default), `"Watkins13"`, `"Coplen07"`, `"KO97"` , and `"FO77"`.
#' For aragonite and dolomite the eq need not be specified.
#' @return
#' Returns the equilibrium carbonate d18O value expressed on the VSMOW scale (parts per mille).
#' @note
#' Use [VPDB()] and [VSMOW()] to convert between the VSMOW and VPDB scales.
#' @examples
#' d18O(33.7, -13.54, eq="Coplen07") # Returns 14.58
#' VPDB(d18O(12, -6.94, min="aragonite")) # Returns -5.21
#' d18O(25, -10.96, min="dolomite") # Returns 20.15
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

d18O = function(temp, d18Ow_VSMOW, min="calcite", eq ="Daeron19") {

  a = a18_c_w(temp=temp, min=min, eq=eq)[1]

  d18Oc_VSMOW = a*(d18Ow_VSMOW+1000)-1000

  return(d18Oc_VSMOW)

}

##————————————————————————————————————————————————————————————————————————————————##

#' @title Calculate water d18O value
#' @description
#' `d18Ow()` calculates the d18O value of the ambient water
#' from the d18O value of a carbonate and its crystallization temperature.
#' @param temp Crystallization temperature, in degrees Celsius.
#' @param d18Oc_VSMOW Carbonate d18O value expressed on the VSMOW scale (parts per mille).
#' @param min Mineralogy. Options are `"calcite"` (default), `"aragonite"`, and `"dolomite"`.
#' @param eq Equation used to calculate the equilibrium 18O/16O oxygen isotope
#' fractionation factor between calcium carbonate and water. Options depend on mineralogy.
#' For calcite choose from `"Daeron19"` (default), `"Watkins13"`, `"Coplen07"`, `"KO97"` , and `"FO77"`.
#' For aragonite and dolomite the eq need not be specified.
#' @return
#' Returns the water d18O value expressed on the VSMOW scale (parts per mille).
#' @note
#' Use [VPDB()] and [VSMOW()] to convert between the VSMOW and VPDB scales.
#' @examples
#' d18Ow(33.7, 14.58, "calcite", "Coplen07") # Returns -13.54
#' d18Ow(25, VSMOW(-7.47), "aragonite") # Returns -6.53
#' d18Ow(25, 20.43, "dolomite") # Returns -10.69
#' @references
#' References are listed at [a18_c_w()].
#' @seealso [a18_c_w()]
#' @seealso [d18O()]
#' @seealso [temp_d18O()]
#' @export

d18Ow = function(temp, d18Oc_VSMOW, min = "calcite", eq ="Daeron19") {
  TinK = temp + 273.15

  a = a18_c_w(temp=temp, min=min, eq=eq)[1]

  d18Ow_VSMOW = (d18Oc_VSMOW+1000)/a - 1000

  return(d18Ow_VSMOW)

}

##————————————————————————————————————————————————————————————————————————————————##

#' @title Carbonate growth temperature from d18O
#' @description
#' `temp_d18O()` calculates the carbonate growth temperature from oxygen isotope data.
#' @param d18Oc_VSMOW Carbonate d18O value expressed on the VSMOW scale (parts per mille).
#' @param d18Ow_VSMOW Water d18O value expressed on the VSMOW scale (parts per mille).
#' @param eq Equation used to calculate the equilibrium 18O/16O oxygen isotope
#' fractionation factor between calcite and water.
#' For calcite choose from `"Daeron19"` (default), `"Watkins13"`, `"Coplen07"`, `"KO97"` , and `"FO77"`.
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

temp_d18O = function(d18Oc_VSMOW, d18Ow_VSMOW, eq ="Daeron19") {
  a18_c_w = (d18Oc_VSMOW+1000)/(d18Ow_VSMOW+1000)

  if(eq == "Daeron19") { # Daeron et al. (2019)
  TinK = (17.57*1000)/(log(a18_c_w)*1000 + 29.13)
  } else if(eq == "Coplen07") { # Coplen (2007)
  TinK = (17.4*1000)/(log(a18_c_w)*1000 + 28.6)
  } else if(eq == "KO97") { # Kim and O'Neil (1997)
  TinK = (18.03*1000)/(log(a18_c_w)*1000 + 32.42)
  } else if(eq == "Watkins13") { # Watkins et al. (2013)
  TinK = (17.747*1000)/(log(a18_c_w)*1000 + 29.777)
  } else if(eq == "FO77") { # O'Neil et al. (1969) reprocessed by Friedman and O'Neil (1977)
  TinK = sqrt((2.78*10^6)/(log(a18_c_w)*1000 + 2.89))
  } else {
    stop("ERROR! Invalid input for eq")
  }

  TinC = TinK-273.15

  return(TinC)
}
