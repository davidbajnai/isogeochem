# Functions in this file: a18_CO2acid_c(), a18_H2O_OH()


# ——————————————————————————————————————————————————————————————————————————— #
#### a18_CO2acid_c ####
#' @title 18O/16O acid fractionation factor
#'
#' @description
#' `a18_CO2acid_c()` calculates the 18O/16O fractionation factor between
#' CO2 produced from acid digestion and carbonate.
#'
#' @param temp Acid digestion temperature (°C).
#' @param min Mineralogy. Options are `"calcite"` and `"aragonite"`.
#'
#' @details
#'
#' **calcite** (Kim et al. 2015):
#'
#' \deqn{\alpha^{18}_{CO2acid/calcite} =
#' e^{(3.48 \times \frac{1}{T} - 0.00147)}}
#'
#' **aragonite** (Kim et al. 2007):
#'
#' \deqn{\alpha^{18}_{CO2acid/aragonite} =
#' e^{(3.39 \times \frac{1}{T} - 0.00083)}}
#'
#' @return
#' Returns the 18O/16O fractionation factor.
#'
#' @references
#' Sharma, T., and Clayton, R. N. (1965).
#' Measurement of ratios of total oxygen of carbonates.
#' Geochimica et Cosmochimica Acta, 29(12), 1347-1353.
#' <https://doi.org/10.1016/0016-7037(65)90011-6>
#'
#' Kim, S.-T., Mucci, A., and Taylor, B. E. (2007).
#' Phosphoric acid fractionation factors for calcite and aragonite
#' between 25 and 75 °C: Revisited.
#' Chemical Geology, 246(3-4), 135-146.
#' <https://doi.org/10.1016/j.chemgeo.2007.08.005>
#'
#' Kim, S.-T., Coplen, T. B., and Horita, J. (2015).
#' Normalization of stable isotope data for carbonate minerals:
#' Implementation of IUPAC guidelines.
#' Geochimica et Cosmochimica Acta, 158, 276-289.
#' <https://doi.org/10.1016/j.gca.2015.02.011>
#'
#' @family fractionation_factors
#'
#' @examples
#' a18_CO2acid_c(temp = 90, min = "calcite")
#' a18_CO2acid_c(temp = 72, min = "aragonite")
#'
#' @export

a18_CO2acid_c = function(temp, min) {
  TinK = temp + 273.15
  if (min == "calcite") {
    exp((3.48 * 1000 / TinK - 1.47) / 1000)
  } else if (min == "aragonite") {
    exp((3.39 * 1000 / TinK - 0.83) / 1000)
  } else {
    stop("Invalid input for min")
  }
}


# ——————————————————————————————————————————————————————————————————————————— #
#### a18_H2O_OH ####
#' @title 18O/16O fractionation factor between water and hydroxide ion
#'
#' @description
#' `a18_H2O_OH()` calculates the 18O/16O fractionation factor between
#' water and aqueous hydroxide ion.
#'
#' @param temp Temperature (°C).
#' @param eq Equation used for the calculations.
#'  * `Z20-X3LYP`: the theoretical X3LYP/6-311+G(d,p) equation of Zeebe (2020).
#'  * `Z20-MP2`: the theoretical MP2/aug-cc-pVDZ equation of Zeebe (2020).
#'
#' @return
#' Returns the 18O/16O fractionation factor.
#'
#' @references
#' Zeebe, R. E. (2020).
#' Oxygen isotope fractionation between water and the aqueous hydroxide ion.
#' Geochimica et Cosmochimica Acta, 289, 182-195.
#' <https://doi.org/10.1016/j.gca.2020.08.025>
#'
#' @family fractionation_factors
#'
#' @examples
#' a18_H2O_OH(temp = 90, eq = "Z20-X3LYP")
#'
#' @export

a18_H2O_OH = function(temp, eq) {
  TinK = temp + 273.15
  if (eq == "Z20-X3LYP") {
    e18_H2O_OH = (-4.4573 + (10.3255 * 10^3) / TinK + (-0.5976 * 10^6) / TinK^2)
  } else if (eq == "Z20-MP2") {
    e18_H2O_OH = (-4.0771 + (9.8350 * 10^3) / TinK + (-0.8729 * 10^6) / TinK^2)
  } else {
    stop("Invalid input for eq")
  }

  e18_H2O_OH / 1000 + 1
}
