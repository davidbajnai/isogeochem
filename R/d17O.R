# Functions in this file: d17Oc()

#' @title Triple oxygen isotope values
#'
#' @description
#' `d17Oc()` calculates equilibrium calcite d18O, d17O, and D17O values for a given temperature.
#'
#' @param temp Calcite growth temperature in degrees Celsius.
#' @param d18Ow_VSMOW Water d18O value expressed on the VSMOW scale (parts per mille).
#' @param eq18 Equation used to calculate the equilibrium 18O/16O oxygen isotope
#'   fractionation factor between calcite and water.
#'   Options are `"Daeron19"` (default), `"Watkins13"`, `"Coplen07"`, `"KO97"` , and `"FO77"`.
#' @param lambda Triple oxygen isotope reference slope. Default is `0.528`.
#'
#' @return
#' Returns a data frame with the carbonate d18O, d17O, and D17O values
#' expressed on the VSMOW scale (all in parts per mille).
#'
#' @details
#' \deqn{\theta_{A/B} = \frac{\alpha^{17}_{A/B}}{\alpha^{18}_{A/B}}}
#'
#' \deqn{ \delta'^{17}O_{w,VSMOW} = \beta \times \delta'^{18}O_{w,VSMOW} + \gamma \textrm{ where } \beta=0.528 \textrm{ and } \gamma = 0 }
#'
#' \deqn{\Delta^{17}O = \delta'^{17}O_{c,VSMOW} - \lambda \times \delta'^{18}O_{c,VSMOW} }
#'
#' @examples
#' d17Oc(10,-1) # Returns d18Oc = 32.44, d17Oc = 16.91, D17O = -0.084
#' d17Oc(10,-1)[,3] # Returns D17O = -0.084
#' prime(d17Oc(10,-1)[,2]) # Returns d'17O = 16.77
#'
#' @references
#' Guo, W., & Zhou, C. (2019).
#' Triple oxygen isotope fractionation in the DIC-H2O-CO2 system: A numerical framework and its implications.
#' Geochimica et Cosmochimica Acta, 246, 541-564.
#' <https://www.doi.org/10.1016/j.gca.2018.11.018>
#'
#' @family equilibrium_carbonate
#'
#' @export

d17Oc = function(temp, d18Ow_VSMOW, eq18="Daeron19", lambda = 0.528) {
  theta_c_w = 59.1047/(temp + 273.15)^2 + -1.4089/(temp + 273.15) + 0.5297 # Guo and Zhou (2019)
  a18c_w = isogeochem::a18c_w(temp=temp, min="calcite", eq=eq18)
  a17c_w = a18c_w ^ theta_c_w

  d18Oc   = d18Oc(temp, d18Ow_VSMOW, min="calcite", eq18) # Calcite d18O value
  d17Ow_p = 0.528 * prime(d18Ow_VSMOW) # Water d17Op value; 0.528 is the Meteoric Water Line

  d17Oc = (unprime(d17Ow_p) + 1000) * a17c_w - 1000
  D17O  = prime(d17Oc) - lambda * prime(d18Oc)

  data.frame(d18Oc, d17Oc, D17O)

  }

#' @title Mixing curves in triple oxygen isotope space
#'
#' @description
#' `mix_d17O()` produces mixing curves in in triple oxygen isotope space (d18O vs. D17O).
#'
#' @param d18O_A d18O value of component A (parts per mille).
#' @param d17O_A d17O value of component A (parts per mille).
#' @param d18O_B d18O value of component B (parts per mille).
#' @param d17O_B d17O value of component B (parts per mille).
#' @param lambda Triple oxygen isotope reference slope. Default `0.528`.
#'
#' @return
#' Returns a data frame:
#' * d18O value of the mixture at % mixing
#' * d18O value of the mixture % mixing
#' * % mixing: from 100% A and 0% B to 0% A and 100% B.
#'
#' @examples
#' # Mixing between a Mesozoic marine carbonate and a diagentic carbonate
#' mix_d17O(d17Oc(10,-1)[1],d17Oc(10,-1)[2],d17Oc(100,0)[1],d17Oc(100,0)[2])
#'
#' @seealso [d17Oc()] calculates equilibrium calcite d18O, d17O, and D17O values for a given temperature.
#'
#' @export

mix_d17O = function (d18O_A, d17O_A, d18O_B, d17O_B, lambda = 0.528) {
  ratio_B = seq(0, 1, 0.1)
  mix_d18O = ratio_B*as.numeric(d18O_B) + (1-ratio_B)*as.numeric(d18O_A)
  mix_d17O = ratio_B*as.numeric(d17O_B) + (1-ratio_B)*as.numeric(d17O_A)
  mix_D17O = (prime(mix_d17O) - lambda * prime(mix_d18O))

  data.frame(mix_d18O, mix_D17O, ratio_B)

  }
