# Functions in this file: a18_c_H2O(), d18O_c(), d18O_H2O(), temp_d18O()

##———————————————————————————————————————————————————————————————————————————##
#### a18_c_H2O ####
#' @title Calculate the 18O/16O fractionation factor between carbonate and water
#'
#' @description
#' `a18_c_H2O()` calculates the equilibrium 18O/16O fractionation factor
#'   between carbonate and water for a given temperature.
#'
#' @param temp Crystallization temperature in degrees Celsius.
#' @param min Mineralogy. Options are `"calcite"`, `"aragonite"`,
#'   and `"dolomite"`.
#' @param eq Equation used for the calculations.
#'
#'   Options for **calcite**:
#'   * `"Daeron19"`: the equation of Daëron et al. (2019)
#'   * `"Watkins13"`: the equation of Watkins et al. (2013)
#'   * `"Coplen07"`: the equation of Coplen (2007)
#'   * `"KO97"`: Kim and O'Neil (1997)
#'   * `"FO77"`: the equation of O'Neil et al. (1969)
#'     reprocessed by Friedman and O'Neil (1977)
#'
#'  Options for **aragonite**:
#'  * `"Dettman99"`: the equation of Grossman and Ku (1986)
#'    reprocessed by Dettman et al. (1999)
#'
#'  Options for **dolomite**:
#'  * `"Vasconcelos05"`: the equation of Vasconcelos et al. (2005)
#'
#' @return Returns the equilibrium 18O/16O fractionation factor "alpha".
#'
#' @examples
#' a18_c_H2O(25, "calcite", "Coplen07")   # Returns 1.030207
#' a18_c_H2O(25, "aragonite", "Dettman99") # Returns 1.029942
#' a18_c_H2O(25, "dolomite", "Vasconcelos05")  # Returns 1.031456
#'
#' @family alpha
#'
#' @references
#' **Calcite:**
#'
#' O'Neil, J. R., Clayton, R. N., & Mayeda, T. K. (1969).
#' Oxygen isotope fractionation in divalent metal carbonates.
#' The Journal of Chemical Physics, 51(12), 5547-5558.
#' <https://doi.org/10.1063/1.1671982>
#'
#' Kim, S.-T., & O'Neil, J. R. (1997).
#' Equilibrium and nonequilibrium oxygen isotope effects
#' in synthetic carbonates.
#' Geochimica et Cosmochimica Acta, 61(16), 3461-3475.
#' <https://doi.org/10.1016/S0016-7037(97)00169-5>
#'
#' Coplen, T. B. (2007).
#' Calibration of the calcite–water oxygen-isotope geothermometer
#' at Devils Hole, Nevada, a natural laboratory.
#' Geochimica et Cosmochimica Acta, 71(16), 3948-3957.
#' <https://doi.org/10.1016/j.gca.2007.05.028>
#'
#' Watkins, J. M., Nielsen, L. C., Ryerson, F. J., & DePaolo, D. J. (2013).
#' The influence of kinetics on the oxygen isotope composition
#' of calcium carbonate.
#' Earth and Planetary Science Letters, 375, 349-360.
#' <https://doi.org/10.1016/j.epsl.2013.05.054>
#'
#' Daëron, M., Drysdale, R. N., Peral, M., Huyghe, D., Blamart, D.,
#' Coplen, T. B., et al. (2019).
#' Most Earth-surface calcites precipitate out of isotopic equilibrium.
#' Nature Communications, 10, 429.
#' <https://doi.org/10.1038/s41467-019-08336-5>
#'
#' **Aragonite:**
#'
#' Dettman, D. L., Reische, A. K., & Lohmann, K. C. (1999).
#' Controls on the stable isotope composition of seasonal growth bands
#' in aragonitic fresh-water bivalves (unionidae).
#' Geochimica et Cosmochimica Acta, 63(7-8), 1049-1057.
#' <https://doi.org/10.1016/s0016-7037(99)00020-4>
#'
#' **Dolomite:**
#'
#' Vasconcelos, C., McKenzie, J. A., Warthmann, R.,
#' & Bernasconi, S. M. (2005).
#' Calibration of the d18O paleothermometer for dolomite precipitated in
#' microbial cultures and natural environments.
#' Geology, 33(4), 317-320.
#' <https://doi.org/10.1130/g20992.1>
#'
#' @export

a18_c_H2O = function(temp, min, eq) {
  TinK = temp + 273.15

  if (min == "calcite") {
    if (eq == "Daeron19")  {
      # Daeron et al. (2019)
      exp((17.57 * 1000 / TinK - 29.13) / 1000)
    } else if (eq == "Coplen07") {
      # Coplen (2007)
      exp((17.4 * 1000 / TinK - 28.6) / 1000)
    } else if (eq == "KO97") {
      # Kim and O'Neil (1997)
      exp((18.03 * 1000 / TinK - 32.42) / 1000)
    } else if (eq == "Watkins13") {
      # Watkins et al. (2013)
      exp((17.747 * 1000 / TinK - 29.777) / 1000)
    } else if (eq == "FO77") {
      # O'Neil et al. (1969) reprocessed by Friedman and O'Neil (1977)
      exp((2.559 * 10^6 / TinK^2 - 2.89) / 1000 )
    } else {
      stop("Invalid input for eq")
    }
  } else if (min == "aragonite") {
      # Grossman and Ku (1986) reprocessed by Dettman et al. (1999)
      exp((2.559 * 10^6 / TinK^2 + 0.715) / 1000)
  } else if (min == "dolomite") {
      # Vasconcelos et al. (2005)
      exp((2.73 * 10^6 / TinK^2 + 0.26) / 1000)
  } else {
      stop("Invalid input for min")
  }
}


##———————————————————————————————————————————————————————————————————————————##
#### d18O_c ####
#' @title Equilibrium carbonate d18O value
#'
#' @description
#' `d18O_c()` calculates the equilibrium d18O value of a carbonate grown
#'   at a given temperature.
#'
#' @param temp Crystallization temperature (°C).
#' @param d18O_H2O_VSMOW Water d18O value expressed on the VSMOW scale (‰).
#' @param min Mineralogy. Options are `"calcite"` (default),
#'   `"aragonite"`, and `"dolomite"`.
#' @param eq Equation used to calculate the equilibrium 18O/16O oxygen isotope
#'   fractionation factor between carbonate and water.
#'   Options depend on mineralogy and listed in [a18_c_H2O()].
#'
#' @return
#' Returns the equilibrium carbonate d18O value
#' expressed on the VSMOW scale (‰).
#'
#' @note
#' Use [to_VSMOW()] and [to_VPDB()] to convert
#' between the VSMOW and VPDB scales.
#'
#' @examples
#' d18O_c(33.7, -13.54, min = "calcite", eq = "Coplen07") # Returns 14.58
#' to_VPDB(d18O_c(12, -6.94, min = "aragonite", eq = "Dettman99"))
#' # Returns -5.21
#' d18O_c(25, -10.96, min = "dolomite", eq = "Vasconcelos05")
#' # Returns 20.15
#'
#' @references
#' References are listed in the description of [a18_c_H2O()].
#'
#' @seealso [d18O_H2O()] calculates the d18O value of the ambient water
#' from the d18O value of a carbonate and its growth temperature.
#'
#' @family equilibrium_carbonate
#'
#' @export

d18O_c = function(temp, d18O_H2O_VSMOW, min, eq) {
  a18_c_H2O = a18_c_H2O(temp=temp, min=min, eq=eq)

  a18_c_H2O*(d18O_H2O_VSMOW+1000)-1000

}


##———————————————————————————————————————————————————————————————————————————##
#### d18O_H2O ####
#' @title Calculate water d18O value
#'
#' @description
#' `d18O_H2O()` calculates the d18O value of the ambient water.
#' from the d18O value of a carbonate and its growth temperature.
#'
#' @param temp Crystallization temperature (°C).
#' @param d18O_c_VSMOW Carbonate d18O value expressed on the VSMOW scale (‰).
#' @param min Mineralogy. Options are `"calcite"` (default),
#' `"aragonite"`, and `"dolomite"`.
#' @param eq Equation used to calculate the equilibrium 18O/16O oxygen isotope
#'   fractionation factor between carbonate and water.
#'   Options depend on mineralogy and listed in [a18_c_H2O()].
#'
#' @return Returns the water d18O value expressed on the VSMOW scale (‰).
#'
#' @note
#' Use [to_VSMOW()] and [to_VPDB()] to convert between
#' the VSMOW and VPDB scales.
#'
#' @examples
#' d18O_H2O(33.7, 14.58, "calcite", "Coplen07") # Returns -13.54
#' d18O_H2O(25, to_VSMOW(-7.47), "aragonite", "Dettman99") # Returns -6.53
#' d18O_H2O(25, 20.43, "dolomite", "Vasconcelos05") # Returns -10.69
#'
#' @references
#' References are listed in the description of [a18_c_H2O()].
#'
#' @seealso
#' [d18O_c()] calculates the equilibrium d18O value of a carbonate
#' grown at a given temperature.
#'
#' @seealso
#' [temp_d18O()] calculates growth temperatures from oxygen isotope data.
#'
#' @export

d18O_H2O = function(temp, d18O_c_VSMOW, min = "calcite", eq) {
  TinK = temp + 273.15
  a18_c_H2O = a18_c_H2O(temp=temp, min=min, eq=eq)

  (d18O_c_VSMOW+1000)/a18_c_H2O - 1000

}

##———————————————————————————————————————————————————————————————————————————##
#### temp_d18O ####
#' @title Oxygen isotope thermometry
#'
#' @description
#' `temp_d18O()` calculates carbonate growth temperature
#' from oxygen isotope data.
#'
#' @param d18O_c_VSMOW Carbonate d18O value expressed on the VSMOW scale (‰).
#' @param d18O_H2O_VSMOW Water d18O value expressed on the VSMOW scale (‰).
#' @param eq Equation used to calculate the equilibrium 18O/16O oxygen isotope
#'   fractionation factor between carbonate and water.
#'   Options depend on mineralogy and listed in [a18_c_H2O()].
#'
#' @return
#' Returns the carbonate growth temperature (°C).
#'
#' @note
#' Use [to_VSMOW()] and [to_VPDB()] to convert between the
#' VSMOW and VPDB scales.
#'
#' @examples
#' temp_d18O(14.58, -13.54, "Coplen07") # Returns 33.7
#'
#' @references
#' References are listed in the description of [a18_c_H2O()].
#'
#' @seealso [d18O_c()] calculates the equilibrium d18O value of a carbonate
#'   grown at a given temperature.
#' @seealso [d18O_H2O()] calculates the d18O value of the ambient water
#'   from the d18O value of a carbonate and its growth temperature.
#'
#' @family thermometry
#'
#' @export

temp_d18O = function(d18O_c_VSMOW, d18O_H2O_VSMOW, eq ="Daeron19") {
  a18_c_H2O = (d18O_c_VSMOW + 1000) / (d18O_H2O_VSMOW + 1000)

  if(eq == "Daeron19") {
    # Daeron et al. (2019)
    TinK = (17.57*1000)/(log(a18_c_H2O)*1000 + 29.13)
  } else if (eq == "Coplen07") {
    # Coplen (2007)
    TinK = (17.4*1000)/(log(a18_c_H2O)*1000 + 28.6)
  } else if (eq == "KO97") {
    # Kim and O'Neil (1997)
    TinK = (18.03*1000)/(log(a18_c_H2O)*1000 + 32.42)
  } else if (eq == "Watkins13") {
    # Watkins et al. (2013)
    TinK = (17.747*1000)/(log(a18_c_H2O)*1000 + 29.777)
  } else if (eq == "FO77") {
    # O'Neil et al. (1969) reprocessed by Friedman and O'Neil (1977)
    TinK = sqrt((2.78*10^6)/(log(a18_c_H2O)*1000 + 2.89))
  } else {
    stop("Invalid input for eq")
  }

  TinK - 273.15

}
