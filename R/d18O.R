# Functions in this file: d18O_c(), d18O_H2O(), temp_d18O()

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
#' @param min Mineralogy. Options are as in [a18_c_H2O()].
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
#' @param min Mineralogy. Options are as in [a18_c_H2O()].
#' @param eq Equation used for the calculations.
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
  temp_util = c()
  for (n in 1:length(d18O_c_VSMOW)) {
    fun_to_optimize = function(x)
      abs(a18_c_H2O(x, min, eq) - a18_c_H2O[n])
    tval = stats::optimize(fun_to_optimize, lower = -1000, upper = 1000)
    tval = as.numeric(tval$minimum)
    temp_util[n] = tval
  }
  round(temp_util, 1)
}
