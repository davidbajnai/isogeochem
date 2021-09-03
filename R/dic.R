# Functions in this file: xdic()

#' @title Dissolved inorganic carbon species
#'
#' @description `xdic()` calculates the relative abundance of the DIC species
#'   as a function of solution temperature, pH, and salinity.
#'
#' @param temp The temperature of the solution in degrees Celsius.
#' @param pH The pH of the solution.
#' @param S The salinity of the solution in parts per mille.
#'
#' @return
#' Returns a data frame with the relative abundance of the DIC species.
#'
#' @export

xdic = function(temp, pH, S) {
  TinK = temp  + 273.15

  # Ionization constants from Harned and Davis (1943) and Harned and Scholes (1941)
  pK1_0 = -126.34048 + 6320.813/TinK + 19.568224*log(TinK)
  pK2_0 = -90.18333 + 5143.692/TinK + 14.613358*log(TinK)

  # Stoichiometric constants from Millero (2006)
  # [H+][HCO3-]/[CO2]
  A1 = 13.4191*S^0.5 + 0.0331*S - (5.33*10^-5) * S^2
  B1 = -530.123*S^0.5 - 6.103*S
  C1 = -2.06950*S^0.5
  pK1 = A1 + (B1/TinK) + C1*log(TinK) + pK1_0

  # [H+][CO32-]/[HCO3-]
  A2 = 21.0894*S^0.5 + 0.1248*S - (3.687*10^-4) * S^2
  B2 = -772.483*S^0.5 - 20.051*S
  C2 = -3.3336*S^0.5
  pK2 = A2 + (B2/TinK) + C2*log(TinK) + pK2_0

  # Relative proportion of the DIC species
  XCO3  = ((10^(pK1 + pK2 - 2*pH) + 10^(pK2 - pH) + 1)^-1) * 100
  XHCO3 = (10^(pK2 - pH) * (10^(pK1 + pK2 - 2*pH) + 10^(pK2 - pH) + 1)^-1) * 100
  XCO2  = ((10^(2*pH - pK1 - pK2) + 10^(pH-pK1) + 1)^-1) * 100

  data.frame(XCO2, XHCO3, XCO3)

}
