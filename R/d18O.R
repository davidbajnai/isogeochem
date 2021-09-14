# Functions in this file: a18_c_H2O(), d18O_c(), d18O_H2O(), temp_d18O()

# ——————————————————————————————————————————————————————————————————————————— #
#### a18_c_H2O ####
#' @title
#' 18O/16O fractionation factor between carbonate and water
#'
#' @description
#' `a18_c_H2O()` calculates the 18O/16O fractionation factor
#' between carbonate and water.
#'
#' @param temp Carbonate growth temperature (°C).
#' @param min Mineralogy. Options are `"calcite"`, `"aragonite"`,
#'   and `"dolomite"`.
#' @param eq Equation used for the calculations. See details.
#'
#' @details
#' Options for eq if min = `"calcite"`:
#'
#' `"FO77"`: O'Neil et al. (1969), modified by Friedman and O'Neil (1977):
#'
#' \deqn{\alpha^{18}_{calcite/water} =
#' e^{(2.78 \times \frac{1000}{T^{2}} - 0.00289)}}
#'
#' `"KO97-orig"`: Kim and O'Neil (1997):
#'
#' \deqn{\alpha^{18}_{calcite/water} =
#' e^{(18.03 \times \frac{1}{T} - 0.03242)}}
#'
#' `"KO97"`: Kim and O'Neil (1997) - reprocessed to match the IUPAC-recommended
#'   acid fractionation factor (see Kim et al. 2007, 2015; and the Vignettes):
#'
#' \deqn{\alpha^{18}_{calcite/water} =
#' e^{(18.04 \times \frac{1}{T} - 0.03218)}}
#'
#' `"Coplen07"`: Coplen (2007):
#'
#' \deqn{\alpha^{18}_{calcite/water} =
#' e^{(17.4 \times \frac{1}{T} - 0.0286)}}
#'
#' `"Tremaine11"`: Tremaine et al. (2011):
#'
#' \deqn{\alpha^{18}_{calcite/water} =
#' e^{(16.1 \times \frac{1}{T} - 0.0246)}}
#'
#' `"Watkins13"`: Watkins et al. (2013):
#'
#' \deqn{\alpha^{18}_{calcite/water} =
#' e^{(17.747 \times \frac{1}{T} - 0.029777)}}
#'
#' `"Daeron19"`: Daëron et al. (2019):
#'
#' \deqn{\alpha^{18}_{calcite/water} =
#' e^{(17.57 \times \frac{1}{T} - 0.02913)}}
#'
#' Options for eq if min = `"aragonite"`:
#'
#' `"GK86"`: Grossman and Ku (1986) modified by Dettman et al. (1999):
#'
#' \deqn{\alpha^{18}_{aragonite/water} =
#' e^{(2.559 \times \frac{1000}{T^{2}} + 0.000715)}}
#'
#' Options for eq if min = `"dolomite"`:
#'
#' `"Vasconcelos05"`: Vasconcelos et al. (2005):
#'
#' \deqn{\alpha^{18}_{dolomite/water} =
#' e^{(2.73 \times \frac{1000}{T^{2}} + 0.00026)}}
#'
#' @return
#' Returns the 18O/16O fractionation factor.
#'
#' @references
#' O'Neil, J. R., Clayton, R. N., & Mayeda, T. K. (1969).
#' Oxygen isotope fractionation in divalent metal carbonates.
#' The Journal of Chemical Physics, 51(12), 5547-5558.
#' <https://doi.org/10.1063/1.1671982>
#'
#' Grossman, E. L., & Ku, T. L. (1986).
#' Oxygen and carbon isotope fractionation in biogenic
#' aragonite: Temperature effects.
#' Chemical Geology, 59(1), 59-74.
#' <https://doi.org/10.1016/0009-2541(86)90044-6>
#'
#' Kim, S.-T., & O'Neil, J. R. (1997).
#' Equilibrium and nonequilibrium oxygen isotope effects
#' in synthetic carbonates.
#' Geochimica et Cosmochimica Acta, 61(16), 3461-3475.
#' <https://doi.org/10.1016/S0016-7037(97)00169-5>
#'
#' Dettman, D. L., Reische, A. K., & Lohmann, K. C. (1999).
#' Controls on the stable isotope composition of seasonal growth bands
#' in aragonitic fresh-water bivalves (unionidae).
#' Geochimica et Cosmochimica Acta, 63(7-8), 1049-1057.
#' <https://doi.org/10.1016/s0016-7037(99)00020-4>
#'
#' Vasconcelos, C., McKenzie, J. A., Warthmann, R.,
#' & Bernasconi, S. M. (2005).
#' Calibration of the d18O paleothermometer for dolomite precipitated in
#' microbial cultures and natural environments.
#' Geology, 33(4), 317-320.
#' <https://doi.org/10.1130/g20992.1>
#'
#' Kim, S.-T., Mucci, A., & Taylor, B. E. (2007).
#' Phosphoric acid fractionation factors for calcite and aragonite between
#' 25 and 75 °C: Revisited. Chemical Geology, 246(3-4), 135-146.
#' <https://doi.org/10.1016/j.chemgeo.2007.08.005>
#'
#' Coplen, T. B. (2007).
#' Calibration of the calcite–water oxygen-isotope geothermometer
#' at Devils Hole, Nevada, a natural laboratory.
#' Geochimica et Cosmochimica Acta, 71(16), 3948-3957.
#' <https://doi.org/10.1016/j.gca.2007.05.028>
#'
#' Tremaine, D. M., Froelich, P. N., & Wang, Y. (2011).
#' Speleothem calcite farmed in situ: Modern calibration of d18O and d13C
#' paleoclimate proxies in a continuously-monitored natural cave system.
#' Geochimica et Cosmochimica Acta, 75(17), 4929-4950.
#' <https://doi.org/10.1016/j.gca.2011.06.005>
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
#' @family fractionation_factors
#'
#' @examples
#' a18_c_H2O(temp = 25, min = "calcite", eq = "Coplen07")
#' a18_c_H2O(temp = 25, min = "aragonite", "GK86")
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
    } else if (eq == "KO97-orig") {
      # Kim and O'Neil (1997) –– original
      exp((18.03 * 1000 / TinK - 32.42) / 1000)
    } else if (eq == "KO97") {
      # Kim and O'Neil (1997) –– reprocessed
      exp((18.04 * 1000 / TinK - 32.18) / 1000)
    } else if (eq == "Watkins13") {
      # Watkins et al. (2013)
      exp((17.747 * 1000 / TinK - 29.777) / 1000)
    } else if (eq == "FO77") {
      # O'Neil et al. (1969) modified by Friedman and O'Neil (1977)
      exp((2.78 * 10 ^ 6 / TinK ^ 2 - 2.89) / 1000)
    } else if (eq == "Tremaine11") {
      # Tremaine et al. (2011)
      exp((16.1 * 1000 / TinK - 24.6) / 1000)
    } else {
      stop("Invalid input for eq")
    }
  } else if (min == "aragonite") {
    if (eq == "GK86")  {
      # Grossman and Ku (1986) modified by Dettman et al. (1999)
      exp((2.559 * 10 ^ 6 / TinK ^ 2 + 0.715) / 1000)
    } else {
      stop("Invalid input for eq")
    }
  } else if (min == "dolomite") {
    if (eq == "Vasconcelos05")  {
      # Vasconcelos et al. (2005)
      exp((2.73 * 10 ^ 6 / TinK ^ 2 + 0.26) / 1000)
    } else {
      stop("Invalid input for eq")
    }
  } else {
    stop("Invalid input for min")
  }
}


# ——————————————————————————————————————————————————————————————————————————— #
#### d18O_c ####
#' @title
#' Equilibrium carbonate d18O value
#'
#' @description
#' `d18O_c()` calculates the equilibrium d18O value of a carbonate grown
#'   at a given temperature.
#'
#' @param temp Carbonate growth temperature (°C).
#' @param d18O_H2O_VSMOW Water d18O value expressed on the VSMOW scale (‰).
#' @param min Mineralogy. Options are `"calcite"`, `"aragonite"`,
#'   and `"dolomite"`.
#' @param eq Equation used for the calculations.
#'   Options depend on mineralogy and are listed in [a18_c_H2O()].
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
#' d18O_c(33.7, -13.54, min = "calcite", eq = "Coplen07")
#' to_VPDB(d18O_c(temp = 12, d18O_H2O_VSMOW = -6.94,
#'                min = "aragonite", eq = "GK86"))
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
  a18_c_H2O = a18_c_H2O(temp = temp, min = min, eq = eq)
  a18_c_H2O * (d18O_H2O_VSMOW + 1000) - 1000
}


# ——————————————————————————————————————————————————————————————————————————— #
#### d18O_H2O ####
#' @title
#' Water d18O value
#'
#' @description
#' `d18O_H2O()` calculates the d18O value of the ambient water
#' from the d18O value of a carbonate and its growth temperature.
#'
#' @param temp Carbonate growth temperature (°C).
#' @param d18O_c_VSMOW Carbonate d18O value expressed on the VSMOW scale (‰).
#' @param min Mineralogy. Options are `"calcite"`, `"aragonite"`,
#'   and `"dolomite"`.
#' @param eq Equation used to calculate the equilibrium 18O/16O oxygen isotope
#'   fractionation factor between carbonate and water.
#'   Options depend on mineralogy and listed in [a18_c_H2O()].
#'
#' @return
#' Returns the water d18O value expressed on the VSMOW scale (‰).
#'
#' @note
#' Use [to_VSMOW()] and [to_VPDB()] to convert between
#' the VSMOW and VPDB scales.
#'
#' @references
#' References are listed in the description of [a18_c_H2O()].
#'
#' @seealso
#' [d18O_c()] calculates the equilibrium d18O value of a carbonate
#' grown at a given temperature.
#' [temp_d18O()] calculates growth temperatures from oxygen isotope data.
#'
#' @examples
#' d18O_H2O(temp = 33.7, d18O_c_VSMOW = 14.58,
#'          min = "calcite", eq = "Coplen07")
#' d18O_H2O(temp = 25, d18O_c_VSMOW = to_VSMOW(-7.47),
#'          min = "aragonite", eq = "GK86")
#'
#' @export

d18O_H2O = function(temp, d18O_c_VSMOW, min, eq) {
  TinK = temp + 273.15
  a18_c_H2O = a18_c_H2O(temp = temp, min = min, eq = eq)

  (d18O_c_VSMOW + 1000) / a18_c_H2O - 1000
}

# ——————————————————————————————————————————————————————————————————————————— #
#### temp_d18O ####
#' @title
#' Oxygen isotope thermometry
#'
#' @description
#' `temp_d18O()` calculates carbonate growth temperature
#' from oxygen isotope data.
#'
#' @param d18O_c_VSMOW Carbonate d18O value expressed on the VSMOW scale (‰).
#' @param d18O_H2O_VSMOW Water d18O value expressed on the VSMOW scale (‰).
#' @param min Mineralogy. Options are `"calcite"`, `"aragonite"`,
#'   and `"dolomite"`.
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
#' temp_d18O(d18O_c_VSMOW = 14.58, d18O_H2O_VSMOW = -13.54,
#'           min = "calcite", eq = "Coplen07")
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

temp_d18O = function(d18O_c_VSMOW, d18O_H2O_VSMOW, min, eq) {
  a18_c_H2O = (d18O_c_VSMOW + 1000) / (d18O_H2O_VSMOW + 1000)
  if (min == "calcite") {
    if (eq == "Daeron19") {
      # Daeron et al. (2019)
      TinK = (17.57 * 1000) / (log(a18_c_H2O) * 1000 + 29.13)
    } else if (eq == "Coplen07") {
      # Coplen (2007)
      TinK = (17.4 * 1000) / (log(a18_c_H2O) * 1000 + 28.6)
    } else if (eq == "KO97-orig") {
      # Kim and O'Neil (1997)
      TinK = (18.03 * 1000) / (log(a18_c_H2O) * 1000 + 32.42)
    } else if (eq == "KO97") {
      # Kim and O'Neil (1997) –– reprocessed
      TinK = (18.04 * 1000) / (log(a18_c_H2O) * 1000 + 32.18)
    } else if (eq == "Watkins13") {
      # Watkins et al. (2013)
      TinK = (17.747 * 1000) / (log(a18_c_H2O) * 1000 + 29.777)
    } else if (eq == "FO77") {
      # O'Neil et al. (1969) modified by Friedman and O'Neil (1977)
      TinK = sqrt((2.78 * 10 ^ 6) / (log(a18_c_H2O) * 1000 + 2.89))
    } else if (eq == "Tremaine11") {
      # Tremaine et al. (2011)
      TinK = (16.1 * 1000) / (log(a18_c_H2O) * 1000 + 24.6)
    } else {
      stop("Invalid input for eq")
    }
  } else if (min == "aragonite") {
    if (eq == "GK86")  {
      # Grossman and Ku (1986) reprocessed by Dettman et al. (1999)
      TinK = sqrt((2.559 * 10 ^ 6) / (1000 * log(a18_c_H2O) - 0.715))
    } else {
      stop("Invalid input for eq")
    }
  } else if (min == "dolomite") {
    if (eq == "Vasconcelos05")  {
      # Vasconcelos et al. (2005)
      TinK = sqrt((2.73 * 10 ^ 6) / (1000 * log(a18_c_H2O) - 0.26))
    } else {
      stop("Invalid input for eq")
    }
  } else {
    stop("Invalid input for min")
  }


  TinK - 273.15
}
