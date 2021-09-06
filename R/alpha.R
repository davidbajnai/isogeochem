# Functions in this file: a18_CO2acid_c(), a18_H2O_OH()


##———————————————————————————————————————————————————————————————————————————##
#### a18_CO2acid_c ####
#' @title Acid fractionation factor: 18O/16O
#'
#' @description `a18_CO2acid_c()` calculates the 18O/16O oxygen isotope
#'   fractionation factor between CO2 from acid digestion and carbonate.
#'
#' @param temp Acid digestion temperature (°C).
#' @param min Mineralogy. Options are `"calcite"` and `"aragonite"`.
#'
#' @return
#' Returns the 18O/16O oxygen isotope fractionation factor "alpha".
#'
#' @references
#' Sharma, T., & Clayton, R. N. (1965).
#' Measurement of ratios of total oxygen of carbonates.
#' Geochimica et Cosmochimica Acta, 29(12), 1347-1353.
#' <https://doi.org/10.1016/0016-7037(65)90011-6>
#'
#' Kim, S.-T., Mucci, A., & Taylor, B. E. (2007).
#' Phosphoric acid fractionation factors for calcite and aragonite
#' between 25 and 75 °C: Revisited.
#' Chemical Geology, 246(3-4), 135-146.
#' <https://doi.org/10.1016/j.chemgeo.2007.08.005>
#'
#' Kim, S.-T., Coplen, T. B., & Horita, J. (2015).
#' Normalization of stable isotope data for carbonate minerals:
#' Implementation of IUPAC guidelines.
#' Geochimica et Cosmochimica Acta, 158, 276-289.
#' <https://doi.org/10.1016/j.gca.2015.02.011>
#'
#' @examples
#' a18_CO2acid_c(90, "calcite") # Returns 1.008146
#'
#' @family alpha
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


##———————————————————————————————————————————————————————————————————————————##
#### a18_H2O_OH ####
#' @title Calculate the 18O/16O fractionation factor between water and
#'   hydroxide ion
#'
#' @description `a18_H2O_OH()` calculates the 18O/16O oxygen isotope
#'   fractionation factor between H2O and aqueous hydroxide ion.
#'
#' @param temp Temperature (°C).
#' @param eq Equation used to calculate the fractionation factor.
#'  * `Z20-X3LYP`: the X3LYP/6-311+G(d,p) theoretical equation of Zeebe (2020).
#'  * `Z20-MP2`: the MP2/aug-cc-pVDZ theoretical equation of Zeebe (2020).
#'
#' @return
#' Returns the 18O/16O oxygen isotope fractionation factor "alpha".
#'
#' @references
#' Zeebe, R. E. (2020).
#' Oxygen isotope fractionation between water and the aqueous hydroxide ion.
#' Geochimica et Cosmochimica Acta, 289, 182-195.
#' <https://doi.org/10.1016/j.gca.2020.08.025>
#'
#' @examples
#' a18_H2O_OH(90, "Z21-X3LYP") # Returns 1.008146
#'
#' @family alpha
#'
#' @export

a18_H2O_OH = function(temp, eq = "Z21-X3LYP") {
  TinK = temp + 273.15
  if (eq == "Z21-X3LYP") {
  e18_H2O_OH = (-4.4573 + (10.3255 * 10^3) / TinK + (-0.5976 * 10^6) / TinK^2)
  } else if (eq == "Z20-MP2") {
  e18_H2O_OH = (-4.0771 + (9.8350 * 10^3) / TinK + (-0.8729 * 10^6) / TinK^2)
  } else {
    stop("Invalid input for min")
  }

  e18_H2O_OH/1000+1

}
