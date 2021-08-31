# Functions in this file: d17O()

#' @title Triple oxygen isotope values
#' @description
#' `d17O()` calculates carbonate d18O, d17O, and D17O values for given temperatures.
#' @param temperature Carbonate growth temperature in degrees Celsius.
#' @param d18Ow_VSMOW Water d18O value expressed on the VSMOW scale (parts per mille).
#' @param eq18 Defines the equation used to calculate the equilibrium 18O/16O oxygen isotope
#' fractionation factor between water and calcium carbonate. Options are *"KO97", "Coplen07", "Watkins13"*, and *"Daeron19"*.
#' Default is *"Daeron19"*. See also [alpha18_cc_water()].
#' @param lambda Triple oxygen isotope reference slope. Default is 0.528.
#' @return
#' Returns a data frame with the carbonate d18O, d17Oand D17O values expressed on the VSMOW scale (all in parts per mille).
#' @details
#' \deqn{\theta_{A/B} = \frac{\alpha^{17}_{A/B}}{\alpha^{18}_{A/B}}}
#' \deqn{ \delta'^{17}O_{w,VSMOW} = \beta \times \delta'^{18}O_{w,VSMOW} + \gamma \textrm{ where } \beta=0.528 \textrm{ and } \gamma = 0 }
#' \deqn{\Delta^{17}O = \delta'^{17}O_{c,VSMOW} - \lambda \times \delta'^{18}O_{c,VSMOW} }
#' @examples
#' d17O(10,-1) # Returns d18Oc = 32.44, d17Oc = 16.91, D17O = -0.084
#' d17O(10,-1)[,3] # Returns D17O = -0.084
#' prime(d17O(10,-1)[,2]) # Returns d'17O = 16.77
#' @references
#' Guo, W., & Zhou, C. (2019). Triple oxygen isotope fractionation in the DIC-H2O-CO2 system: A numerical framework and its implications. Geochimica et Cosmochimica Acta, 246, 541-564. <https://www.doi.org/10.1016/j.gca.2018.11.018>
#'
#' Daëron, M., Drysdale, R. N., Peral, M., Huyghe, D., Blamart, D., Coplen, T. B., et al. (2019). Most Earth-surface calcites precipitate out of isotopic equilibrium. Nature Communications, 10, 429. <https://www.doi.org/10.1038/s41467-019-08336-5>
#' @seealso [d18O()]
#' @export

d17O = function(temperature, d18Ow_VSMOW, eq18="Daeron19", lambda = 0.528) {
  theta_c_w = 59.1047/(temperature + 273.15)^2 + -1.4089/(temperature + 273.15) + 0.5297 # Guo and Zhou (2019)
  alpha18_c_w = alpha18_cc_water(temperature, eq18) # Function in isogeochem
  alpha17_c_w = alpha18_c_w ^ theta_c_w

  d18Oc   = d18O(temperature,d18Ow_VSMOW,eq18) # Carbonate d18O value
  d17Ow_p = 0.528 * prime(d18Ow_VSMOW) # Water d17Op value; 0.528 is the Meteoric Water Line

  d17Oc = (unprime(d17Ow_p) + 1000) * alpha17_c_w - 1000
  D17O  = prime(d17Oc) - lambda * prime(d18Oc)

  d17O = data.frame(d18Oc, d17Oc, D17O)
  final=return(d17O)
  }
