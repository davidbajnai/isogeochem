# Functions in this file: a18_c_H2O()

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
#'   `apatite`, `siderite`, and `"dolomite"`.
#' @param eq Equation used for the calculations. See details.
#'
#' @details
#' Options for eq if min = `"calcite"`:
#'
#' `"ONeil69"`: O'Neil et al. (1969), modified by Friedman and O'Neil (1977):
#'
#' \deqn{\alpha^{18}_{calcite/water} =
#' e^{(2.78 \times \frac{1000}{T^{2}} - 0.00289)}}
#'
#' `"KO97-orig"`: Kim and O'Neil (1997):
#'
#' \deqn{\alpha^{18}_{calcite/water} =
#' e^{(18.03 \times \frac{1}{T} - 0.03242)}}
#'
#' **NOTE:** The "KO97-orig" equation should only be applied to data that considers a
#' CO2(acid)/calcite AFF as in Kim & O'Neil (1997), i.e., 10.44 at 25 °C.
#'
#' `"KO97"`: Kim and O'Neil (1997), reprocessed here to match the IUPAC-recommended
#'   AFF as in Kim et al. (2007, 2015):
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
#' `"GK86"`: Grossman and Ku (1986), modified by Dettman et al. (1999):
#'
#' \deqn{\alpha^{18}_{aragonite/water} =
#' e^{(2.559 \times \frac{1000}{T^{2}} + 0.000715)}}
#'
#' `"Kim07"`: Kim et al. (2007):
#'
#' \deqn{\alpha^{18}_{aragonite/water} =
#' e^{(17.88 \times \frac{1}{T} - 0.03114)}}
#'
#' Options for eq if min = `"apatite"`.
#' Apatite refers to apatite-bound carbonate.
#'
#' `"Lecuyer10"`: Lécuyer et al. (2010):
#'
#' \deqn{\alpha^{18}_{apatite/water} =
#' e^{(25.19 \times \frac{1}{T} - 0.05647)}}
#'
#' Options for eq if min = `"siderite"`:
#'
#' `"vanDijk18"`: van Dijk et al. (2018):
#'
#' \deqn{\alpha^{18}_{siderite/water} =
#' e^{(19.67 \times \frac{1}{T} - 0.03627)}}
#'
#' Options for eq if min = `"dolomite"`:
#'
#' `"Vasconcelos05"`: Vasconcelos et al. (2005):
#'
#' \deqn{\alpha^{18}_{dolomite/water} =
#' e^{(2.73 \times \frac{1000}{T^{2}} + 0.00026)}}
#'
#' `"Muller19"`: Müller et al. (2019):
#'
#' \deqn{\alpha^{18}_{dolomite/water} =
#' e^{(2.9923 \times \frac{1000}{T^{2}} + 0.0023592)}}
#'
#' @return
#' Returns the 18O/16O fractionation factor.
#'
#' @references
#' O'Neil, J. R., Clayton, R. N., & Mayeda, T. K. (1969).
#' Oxygen isotope fractionation in divalent metal carbonates.
#' The Journal of Chemical Physics, 51(12), 5547-5558.
#' \doi{10.1063/1.1671982}
#'
#' Grossman, E. L., & Ku, T. L. (1986).
#' Oxygen and carbon isotope fractionation in biogenic
#' aragonite: Temperature effects.
#' Chemical Geology, 59(1), 59-74.
#' \doi{10.1016/0009-2541(86)90044-6}
#'
#' Kim, S.-T., & O'Neil, J. R. (1997).
#' Equilibrium and nonequilibrium oxygen isotope effects
#' in synthetic carbonates.
#' Geochimica et Cosmochimica Acta, 61(16), 3461-3475.
#' \doi{10.1016/S0016-7037(97)00169-5}
#'
#' Dettman, D. L., Reische, A. K., & Lohmann, K. C. (1999).
#' Controls on the stable isotope composition of seasonal growth bands
#' in aragonitic fresh-water bivalves (unionidae).
#' Geochimica et Cosmochimica Acta, 63(7-8), 1049-1057.
#' \doi{10.1016/s0016-7037(99)00020-4}
#'
#' Vasconcelos, C., McKenzie, J. A., Warthmann, R.,
#' & Bernasconi, S. M. (2005).
#' Calibration of the d18O paleothermometer for dolomite precipitated in
#' microbial cultures and natural environments.
#' Geology, 33(4), 317-320.
#' \doi{10.1130/g20992.1}
#'
#' Kim, S.-T., Mucci, A., & Taylor, B. E. (2007).
#' Phosphoric acid fractionation factors for calcite and aragonite between
#' 25 and 75 °C: Revisited. Chemical Geology, 246(3-4), 135-146.
#' \doi{10.1016/j.chemgeo.2007.08.005}
#'
#' Coplen, T. B. (2007).
#' Calibration of the calcite-water oxygen-isotope geothermometer
#' at Devils Hole, Nevada, a natural laboratory.
#' Geochimica et Cosmochimica Acta, 71(16), 3948-3957.
#' \doi{10.1016/j.gca.2007.05.028}
#'
#' Lécuyer, C., Balter, V., Martineau, F., Fourel, F., Bernard, A.,
#' Amiot, R., et al. (2010).
#' Oxygen isotope fractionation between apatite-bound carbonate
#' and water determined from controlled experiments with synthetic
#' apatites precipitated at 10-37°C.
#' Geochimica et Cosmochimica Acta, 74(7), 2072-2081.
#' \doi{10.1016/j.gca.2009.12.024}
#'
#' Tremaine, D. M., Froelich, P. N., & Wang, Y. (2011).
#' Speleothem calcite farmed in situ: Modern calibration of d18O and d13C
#' paleoclimate proxies in a continuously-monitored natural cave system.
#' Geochimica et Cosmochimica Acta, 75(17), 4929-4950.
#' \doi{10.1016/j.gca.2011.06.005}
#'
#' Watkins, J. M., Nielsen, L. C., Ryerson, F. J., & DePaolo, D. J. (2013).
#' The influence of kinetics on the oxygen isotope composition
#' of calcium carbonate.
#' Earth and Planetary Science Letters, 375, 349-360.
#' \doi{10.1016/j.epsl.2013.05.054}
#'
#' van Dijk, J., Fernandez, A., Müller, I. A., Lever, M., & Bernasconi, S.
#' M. (2018).
#' Oxygen isotope fractionation in the siderite-water system between 8.5
#' and 62 °C.
#' Geochimica et Cosmochimica Acta, 220, 535-551.
#' \doi{10.1016/j.gca.2017.10.009}
#'
#' Daëron, M., Drysdale, R. N., Peral, M., Huyghe, D., Blamart, D.,
#' Coplen, T. B., et al. (2019).
#' Most Earth-surface calcites precipitate out of isotopic equilibrium.
#' Nature Communications, 10, 429.
#' \doi{10.1038/s41467-019-08336-5}
#'
#' Müller, I.A., Rodriguez-Blanco, J.D., Storck, J.-C., do Nascimento, G.S.,
#' Bontognali, T.R.R., Vasconcelos, C.,
#' Benning, L.G. & Bernasconi, S.M. (2019).
#' Calibration of the oxygen and clumped isotope thermometers for
#' (proto-)dolomite based on synthetic and natural carbonates.
#' Chemical Geology, 525, 1-17.
#' \doi{10.1016/j.chemgeo.2019.07.014}
#'
#' @family fractionation_factors
#'
#' @examples
#' a18_c_H2O(temp = 25, min = "calcite", eq = "Coplen07")
#' a18_c_H2O(temp = 25, min = "aragonite", eq = "GK86")
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
      # Kim and O'Neil (1997) -- original
      exp((18.03 * 1000 / TinK - 32.42) / 1000)
    } else if (eq == "KO97") {
      # Kim and O'Neil (1997) -- reprocessed
      exp((18.04 * 1000 / TinK - 32.18) / 1000)
    } else if (eq == "Watkins13") {
      # Watkins et al. (2013)
      exp((17.747 * 1000 / TinK - 29.777) / 1000)
    } else if (eq == "ONeil69" | eq == "FO77") {
      # O'Neil et al. (1969) modified by Friedman and O'Neil (1977)
      exp((2.78 * 10 ^ 6 / TinK ^ 2 - 2.89) / 1000)
    } else if (eq == "Tremaine11") {
      # Tremaine et al. (2011)
      exp((16.1 * 1000 / TinK - 24.6) / 1000)
    } else {
      stop("Invalid input for eq. Options for calcite are Daeron19,
           Coplen07, KO97-orig, KO97, Watkins13, ONeil69, and Tremaine11.")
    }
  } else if (min == "aragonite") {
    if (eq == "GK86")  {
      # Grossman and Ku (1986) modified by Dettman et al. (1999)
      exp((2.559 * 10 ^ 6 / TinK ^ 2 + 0.715) / 1000)
    } else if (eq == "Kim07")  {
      # Kim et al. (2007)
      exp((17.880 * 1000 / TinK - 31.14) / 1000)
    } else {
      stop("Invalid input for eq. Options for aragonite are GK86
           and Kim07.")
    }
  } else if (min == "apatite") {
    if (eq == "Lecuyer10")  {
      # Lécuyer et al. (2010)
      exp((25.19 * 1000 / TinK  - 56.47) / 1000)
    } else {
      stop("Invalid input for eq. Use Lecuyer10 for apatite.")
    }
  } else if (min == "siderite") {
    if (eq == "vanDijk18")  {
      # van Dijk et al. (2018)
      exp((19.67 * 1000 / TinK  - 36.27) / 1000)
    } else {
      stop("Invalid input for eq. Use vanDijk18 for siderite.")
    }
  } else if (min == "dolomite") {
    if (eq == "Vasconcelos05")  {
      # Vasconcelos et al. (2005)
      exp((2.73 * 10 ^ 6 / TinK ^ 2 + 0.26) / 1000)
    } else if (eq == "Muller19")  {
      # Müller et al. (2019)
      exp((2.9923 * 10 ^ 6 / TinK ^ 2 - 2.3592) / 1000)
    } else {
      stop("Invalid input for eq. Options for dolomite are Vasconcelos05
           and Muller19.")
    }
  } else {
    stop("Invalid input for min. Options are calcite, aragonite, siderite,
         and dolomite.")
  }
}
