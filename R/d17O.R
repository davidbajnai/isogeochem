# Functions in this file: d17O_c()

##———————————————————————————————————————————————————————————————————————————##
#### d17O_c ####
#' @title Triple oxygen isotope values
#'
#' @description
#' `d17O_c()` calculates equilibrium calcite d18O, d17O, and D17O values
#'   for a given temperature.
#'
#' @param temp Calcite growth temperature (°C).
#' @param d18O_H2O_VSMOW Water d18O value expressed on the VSMOW scale (‰).
#' @param eq18 Equation used to calculate the equilibrium 18O/16O
#'   fractionation factor between calcite and water.
#'   Options are as in [a18_c_H2O()] with `"Daeron19"` being here the default.
#' @param lambda Triple oxygen isotope reference slope. Default is `0.528`.
#'
#' @return
#' Returns a data frame:
#' * d18O value of the carbonate expressed on the VSMOW scale (‰).
#' * d18O value of the carbonate expressed on the VSMOW scale (‰).
#' * D17O value of the carbonate expressed on the VSMOW scale (‰).
#'
#' @details
#' \deqn{\theta_{A/B} = \frac{\alpha^{17}_{A/B}}{\alpha^{18}_{A/B}}}
#'
#' \deqn{ \delta'^{17}O_{w,VSMOW} =
#' \beta \times \delta'^{18}O_{w,VSMOW} + \gamma
#' \textrm{ where } \beta=0.528 \textrm{ and } \gamma = 0 }
#'
#' \deqn{\Delta^{17}O = \delta'^{17}O_{c,VSMOW} -
#' \lambda \times \delta'^{18}O_{c,VSMOW} }
#'
#' @examples
#' d17O_c(10,-1) # Returns the data frame (length = 3)
#' d17O_c(10,-1)[,1] # Returns the D18O value
#' prime(d17O_c(10,-1)[,2]) # Returns the d'17O value
#' d17O_c(10,-1)[,3] # Returns the D17O value
#'
#' @references
#' Guo, W., & Zhou, C. (2019).
#' Triple oxygen isotope fractionation in the DIC-H2O-CO2 system:
#' A numerical framework and its implications.
#' Geochimica et Cosmochimica Acta, 246, 541-564.
#' <https://www.doi.org/10.1016/j.gca.2018.11.018>
#'
#' @family equilibrium_carbonate
#'
#' @export

d17O_c = function(temp, d18O_H2O_VSMOW, eq18 = "Daeron19", lambda = 0.528) {

  # Guo and Zhou (2019)
  theta = 59.1047 / (temp + 273.15) ^ 2+-1.4089 / (temp + 273.15) + 0.5297

  a18_c_H2O = isogeochem::a18_c_H2O(temp = temp, min = "calcite", eq = eq18)
  a17c_H2O  = a18_c_H2O ^ theta

  d18O_c   = d18O_c(temp, d18O_H2O_VSMOW, min = "calcite", eq18)
  d17Ow_p = 0.528 * prime(d18O_H2O_VSMOW)

  d17O_c = (unprime(d17Ow_p) + 1000) * a17c_H2O - 1000
  D17O_c  = prime(d17O_c) - lambda * prime(d18O_c)

  data.frame(d18O_c, d17O_c, D17O_c)
  }

# ——————————————————————————————————————————————————————————————————————————— #
#### mix_d17O ####
#' @title Mixing curves in triple oxygen isotope space
#'
#' @description
#' `mix_d17O()` produces mixing curves between two endmembers (A and B) in
#'   triple oxygen isotope space (d18O vs. D17O).
#'
#' @param d18O_A d18O value of component A (‰).
#' @param d17O_A d17O value of component A (‰).
#' @param d18O_B d18O value of component B (‰).
#' @param d17O_B d17O value of component B (‰).
#' @param lambda Triple oxygen isotope reference slope. Default `0.528`.
#'
#' @return
#' Returns a data frame:
#' * d18O value of the mixture at x% mixing (‰).
#' * d18O value of the mixture x% mixing (‰).
#' * relative amount of component B in the mixture (%):
#'   from 100% A and 0% B to 0% A and 100% B.
#'
#' @examples
#' mix_d17O(d18O_A = d17O_c(10, -1)[1], d17O_A = d17O_c(10, -1)[2],
#'          d18O_B = d17O_c(100,0)[1], d17O_B = d17O_c(100, 0)[2])
#'
#' @seealso [d17O_c()] calculates equilibrium calcite d18O, d17O, and D17O
#'   values for a given temperature.
#'
#' @export

mix_d17O = function (d18O_A, d17O_A, d18O_B, d17O_B, lambda = 0.528) {
  ratio_B = seq(0, 1, 0.1)
  mix_d18O = ratio_B*as.numeric(d18O_B) + (1-ratio_B)*as.numeric(d18O_A)
  mix_d17O = ratio_B*as.numeric(d17O_B) + (1-ratio_B)*as.numeric(d17O_A)
  mix_D17O = (prime(mix_d17O) - lambda * prime(mix_d18O))
  xB = ratio_B * 100

  data.frame(mix_d18O, mix_D17O, xB)

  }
