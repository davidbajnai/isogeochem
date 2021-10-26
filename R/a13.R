# ——————————————————————————————————————————————————————————————————————————— #
#### a13_CO2g_CO2aq ####
#' @title
#' 13C/12C fractionation factor between CO2(g) and CO2(aq)
#'
#' @description
#' `a13_CO2g_CO2aq()` calculates the 13C/12C fractionation factor
#' between gaseous and dissolved CO2.
#'
#' @param temp Temperature (°C).
#'
#' @details
#' \deqn{\alpha^{13}_{CO2(g)/CO2(aq)} =
#' (\frac{-1.18 + 0.0041 \times (T - 273.15)}{1000} + 1)^{-1}}
#'
#' @return
#' Returns the 13C/12C fractionation factor.
#'
#' @references
#' Vogel, J. C., Grootes, P. M., & Mook, W. G. (1970).
#' Isotopic fractionation between gaseous and dissolved carbon dioxide.
#' Zeitschrift für Physik A: Hadrons and Nuclei, 230(3), 225-238.
#' \doi{10.1007/Bf01394688}
#'
#' @family fractionation_factors
#'
#' @export

a13_CO2g_CO2aq = function(temp) {
  1 / ((-1.18 + 0.0041 * temp) / 1000 + 1)
}
