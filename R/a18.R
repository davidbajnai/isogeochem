# ——————————————————————————————————————————————————————————————————————————— #
#### a18_CO2acid_c ####
#' @title 18O/16O acid fractionation factor
#'
#' @description
#' `a18_CO2acid_c()` calculates the 18O/16O fractionation factor between
#' CO2 produced from acid digestion and carbonate.
#'
#' @param temp Acid digestion temperature (°C).
#' @param min Mineralogy. Options are `"calcite"`, `"aragonite"`,
#' and `"dolomite"`.
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
#' **dolomite** (Rosenbaum & Sheppard 1986):
#'
#' \deqn{\alpha^{18}_{CO2acid/dolomite} =
#' e^{(665 \times \frac{1}{T^{2}} + 0.00423)}}
#'
#' @return
#' Returns the 18O/16O fractionation factor.
#'
#' @references
#' Sharma, T., and Clayton, R. N. (1965).
#' Measurement of ratios of total oxygen of carbonates.
#' Geochimica et Cosmochimica Acta, 29(12), 1347-1353.
#' \doi{10.1016/0016-7037(65)90011-6}
#'
#' Rosenbaum, J. and Sheppard, S.M.F. (1986).
#' An isotopic study of siderites, dolomites and ankerites
#' at high temperatures.
#' Geochimica et Cosmochimica Acta, 50, 1147-1150.
#' \doi{10.1016/0016-7037(86)90396-0}
#'
#' Kim, S.-T., Mucci, A., and Taylor, B. E. (2007).
#' Phosphoric acid fractionation factors for calcite and aragonite
#' between 25 and 75 °C: Revisited.
#' Chemical Geology, 246(3-4), 135-146.
#' \doi{10.1016/j.chemgeo.2007.08.005}
#'
#' Kim, S.-T., Coplen, T. B., and Horita, J. (2015).
#' Normalization of stable isotope data for carbonate minerals:
#' Implementation of IUPAC guidelines.
#' Geochimica et Cosmochimica Acta, 158, 276-289.
#' \doi{10.1016/j.gca.2015.02.011}
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
  } else if (min == "dolomite") {
    exp( (6.65 * 10 ^ 5 / TinK ^ 2 + 4.23) / 1000)
  } else {
    stop("Invalid input for min. Options are calcite, aragonite,
         and dolomite.")
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
#' \doi{10.1016/j.gca.2020.08.025}
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
    stop("Invalid input for eq. Options are Z20-X3LYP and Z20-MP2.")
  }
  e18_H2O_OH / 1000 + 1
}


# ——————————————————————————————————————————————————————————————————————————— #
#### a18_CO2g_H2O ####
#' @title
#' 18O/16O fractionation factor between CO2(g) and H2O(l)
#'
#' @description
#' `a18_CO2_H2O()` calculates the 18O/16O fractionation factor
#' between gaseous CO2 and liquid water.
#'
#' @param temp Temperature (°C).
#'
#' @details
#' \deqn{\alpha^{18}_{CO2(g)/H2O(l)} =
#' (17.604 \times \frac{1}{T} - 0.01793) + 1}
#'
#' @return
#' Returns the 18O/16O fractionation factor.
#'
#' @references
#' Brenninkmeijer, C. A. M., Kraft, P., & Mook, W. G. (1983).
#' Oxygen isotope fractionation between CO2 and H2O.
#' Chemical Geology, 41, 181-190.
#' \doi{10.1016/S0009-2541(83)80015-1}
#'
#' @family fractionation_factors
#'
#' @export

a18_CO2g_H2O = function(temp) {
  TinK = temp + 273.15
  (17604 / TinK - 17.93) / 1000 + 1
}


# ——————————————————————————————————————————————————————————————————————————— #
#### a18_CO2aq_H2O ####
#' @title
#' 18O/16O fractionation factor between CO2(aq) and H2O(l)
#'
#' @description
#' `a18_CO2_H2O()` calculates the 18O/16O fractionation factor
#' between dissolved CO2 and liquid water.
#'
#' @param temp Temperature (°C).
#'
#' @details
#' \deqn{\alpha^{18}_{CO2(aq)/H2O(l)} =
#' e^{2.52 \times \frac{1000}{T^{2}} + 0.01212}}
#'
#' @return
#' Returns the 18O/16O fractionation factor.
#'
#' @references
#' Beck, W. C., Grossman, E. L., & Morse, J. W. (2005).
#' Experimental studies of oxygen isotope fractionation
#' in the carbonic acid system at 15°, 25°, and 40°C.
#' Geochimica et Cosmochimica Acta, 69(14), 3493-3503.
#' \doi{10.1016/j.gca.2005.02.003}
#'
#' @family fractionation_factors
#'
#' @export

a18_CO2aq_H2O = function(temp) {
  TinK = temp + 273.15
  exp(2.52 * 1000 / TinK ^ 2 + 0.01212)
}

# ——————————————————————————————————————————————————————————————————————————— #
#### a18_CO3_H2O ####
#' @title
#' 18O/16O fractionation factor between CO3(2-) and H2O
#'
#' @description
#' `a18_CO3_H2O()` calculates the 18O/16O fractionation factor
#' between carbonate ion CO3(2-) and water.
#'
#' @param temp Temperature (°C).
#'
#' @details
#' \deqn{\alpha^{18}_{CO3(2-)/H2O} =
#' e^{2.39 \times \frac{1000}{T^{2}} - 0.00270}}
#'
#' The equation above and in the function is the uncorrected equation in
#' Beck et al. (2005). They experimentally determined the fractionation factor
#' using BaCO3 precipitation experiments. However, they applied the acid
#' fractionation factor of calcite during the data processing and
#' not that of BaCO3. The acid fractionation factor of BaCO3 is not known
#' accurately, which may result in a bias of up to 1‰
#' in the calculated 1000lna values.
#'
#' @return
#' Returns the 18O/16O fractionation factor.
#'
#' @references
#' Beck, W. C., Grossman, E. L., & Morse, J. W. (2005).
#' Experimental studies of oxygen isotope fractionation
#' in the carbonic acid system at 15°, 25°, and 40°C.
#' Geochimica et Cosmochimica Acta, 69(14), 3493-3503.
#' \doi{10.1016/j.gca.2005.02.003}
#'
#' @family fractionation_factors
#'
#' @export

a18_CO3_H2O = function(temp) {
  TinK = temp + 273.15
  exp(2.39 * 1000 / TinK ^ 2 - 0.0027)
}

# ——————————————————————————————————————————————————————————————————————————— #
#### a18_HCO3_H2O ####
#' @title
#' 18O/16O fractionation factor between HCO3(-) and H2O
#'
#' @description
#' `a18_HCO3_H2O()` calculates the 18O/16O fractionation factor
#' between bicarbonate ion HCO3(-) and water.
#'
#' @param temp Temperature (°C).
#'
#' @details
#' \deqn{\alpha^{18}_{HCO3(-)/H2O} =
#' e^{2.59 \times \frac{1000}{T^{2}} + 0.00189}}
#'
#' The equation above and in the function is the uncorrected equation in
#' Beck et al. (2005). They experimentally determined the fractionation factor
#' using BaCO3 precipitation experiments. However, they applied the acid
#' fractionation factor of calcite during the data processing and
#' not that of BaCO3. The acid fractionation factor of BaCO3 is not known
#' accurately, which may result in a bias of up to 1‰
#' in the calculated 1000lna values.
#'
#' @return
#' Returns the 18O/16O fractionation factor.
#'
#' @references
#' Beck, W. C., Grossman, E. L., & Morse, J. W. (2005).
#' Experimental studies of oxygen isotope fractionation
#' in the carbonic acid system at 15°, 25°, and 40°C.
#' Geochimica et Cosmochimica Acta, 69(14), 3493-3503.
#' \doi{10.1016/j.gca.2005.02.003}
#'
#' @family fractionation_factors
#'
#' @export

a18_HCO3_H2O = function(temp) {
  TinK = temp + 273.15
  exp(2.59 * 1000 / TinK ^ 2 + 0.00189)
}
