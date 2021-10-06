# Functions in this file: X_DIC(), X_absorption

##———————————————————————————————————————————————————————————————————————————##
#### X_DIC ####
#' @title Dissolved inorganic carbon species
#'
#' @description `X_DIC()` calculates the relative abundance of the DIC species
#'   as a function of solution temperature, pH, and salinity.
#'
#' @param temp The temperature of the solution (°C).
#' @param pH The pH of the solution.
#' @param S The salinity of the solution (g/kg or ‰).
#'
#' @return
#' Returns a data frame with the relative abundance of the DIC species:
#' * Relative abundance of dissolved CO2 (%).
#' * Relative abundance of bicarbonate ion (%).
#' * Relative abundance of carbonate ion (%).
#'
#' @examples
#' X_DIC(temp = 25, pH = 7, S = 30)
#'
#' @export

X_DIC = function(temp, pH, S) {
  TinK = temp + 273.15

  # First and second stoichiometric dissociation constants of carbonic acid

  # from Harned and Davis (1943) and Harned and Scholes (1941)
  pK1_0 = -126.34048 + 6320.813 / TinK + 19.568224 * log(TinK)
  pK2_0 = -90.18333 + 5143.692 / TinK + 14.613358 * log(TinK)

  # from Millero (2006)
    A1 = 13.4191 * S^0.5 + 0.0331 * S - (5.33 * 10^-5) * S^2
    B1 = -530.123 * S^0.5 - 6.103 * S
    C1 = -2.06950 * S^0.5
  pK1 = A1 + (B1 / TinK) + C1 * log(TinK) + pK1_0
    A2 = 21.0894 * S^0.5 + 0.1248 * S - (3.687 * 10^-4) * S^2
    B2 = -772.483 * S^0.5 - 20.051 * S
    C2 = -3.3336 * S^0.5
  pK2 = A2 + (B2 / TinK) + C2 * log(TinK) + pK2_0

  # Relative proportion of the DIC species
  X_CO3  = ((10^(pK1 + pK2 - 2*pH) + 10^(pK2 - pH) + 1)^-1) * 100
  X_HCO3 = (10^(pK2 - pH) * (10^(pK1 + pK2 - 2*pH) +
                              10^(pK2 - pH) + 1)^-1) * 100
  X_CO2  = ((10^(2*pH - pK1 - pK2) + 10^(pH-pK1) + 1)^-1) * 100

  data.frame(X_CO2, X_HCO3, X_CO3)

}

##———————————————————————————————————————————————————————————————————————————##
#### X_absorption ####
#' @title Relative rates of CO2 absorption reactions
#'
#' @description `X_absorption()` calculates the relative abundance of the DIC species
#'   as a function of solution temperature, pH, and salinity.
#'
#' @param temp The temperature of the solution (°C).
#' @param pH The pH of the solution.
#' @param S The salinity of the solution (g/kg or ‰).
#'
#' @details
#'
#' X_hydration = ((kCO2 / (kCO2 + kOHxKw / aH)) * 100), where
#'
#' * kCO2 is the rate constant for CO2 hydration from Johnson (1982)
#' * kOHxKw is the rate constant for
#'   CO2 hydroxylation x Kw from Schulz et al. (2006).
#' * aH is 10^(-pH)
#'
#' @return
#' Returns a data frame with the relative rates of CO2 absorption reactions:
#' * Relative rate of CO2 hydration (%).
#' * Relative rate of CO2 hydroxylation (%).
#'
#' @references
#' Johnson, K. S. (1982).
#' Carbon dioxide hydration and dehydration kinetics in seawater.
#' Limnology and Oceanography, 27(5), 894-855.
#' <https://doi.org/10.4319/lo.1982.27.5.0849>
#'
#' Schulz, K. G., Riebesell, U., Rost, B., Thoms, S., & Zeebe, R. E. (2006).
#' Determination of the rate constants for the carbon dioxide to
#' bicarbonate inter-conversion in pH-buffered seawater systems.
#' Marine Chemistry, 100(1-2), 53-65.
#' <https://doi.org/10.1016/j.marchem.2005.11.001>
#'
#' @examples
#' X_absorption(temp = 25, pH = 7, S = 30)
#'
#' @export

X_absorption = function(temp, pH, S) {
  TinK = temp  + 273.15
  aH = 10 ^ -pH

  # Rate constant for CO2 (aq) hydration Johnson (1982)
  A_CO2 = 1246.98
  B_CO2 = 0
  D_CO2 = -6.19 * 10 ^ 4
  E_CO2 = -183.0
  kCO2 = exp(A_CO2 + B_CO2 * sqrt(S) + D_CO2 / TinK + E_CO2 * log(TinK))

  # Rate constant for CO2 (aq) hydroxylation x Kw from Schulz et al. (2006)
  kOHxKw = (499002.24 * exp(4.2986 * 10 ^ -4 * S ^ 2 + 5.75499 * 10 ^
                              -5 * S)) * exp(-90166.83 / (8.3145 * TinK))

  X_hydration     = ((kCO2 / (kCO2 + kOHxKw / aH)) * 100)
  X_hydroxylation = 100 - ((kCO2 / (kCO2 + kOHxKw / aH)) * 100)

  return(data.frame(X_hydration, X_hydroxylation))
}
