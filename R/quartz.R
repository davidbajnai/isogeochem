# Functions in this file: d17O_qz(),

##———————————————————————————————————————————————————————————————————————————##
#### d17O_qz ####
#' @title Triple oxygen isotope values of quartz
#'
#' @description
#' `d17O_qz()` calculates the equilibrium d18O, d17O, and D17O values of
#' quartz grown at a given temperature.
#'
#' @param temp Quartz growth temperature (°C).
#' @param d18O_H2O_VSMOW Water d18O value expressed on the VSMOW scale (‰).
#' @param D17O_H2O D17O value of ambient water calculated using
#'   a lambda of `0.528`. Default `0`.
#' @param lambda Triple oxygen isotope reference slope. Default `0.528`.
#'
#' @return
#' Returns a data frame:
#' 1. d18O value of the quartz expressed on the VSMOW scale (‰).
#' 2. d18O value of the quartz expressed on the VSMOW scale (‰).
#' 3. D17O value of the quartz expressed on the VSMOW scale (‰).
#'
#' @details
#' \deqn{\theta_{A/B} = \frac{\alpha^{17}_{A/B}}{\alpha^{18}_{A/B}}}
#'
#' \deqn{ \delta'^{17}O_{H2O,VSMOW} =
#' \beta \times \delta'^{18}O_{H2O,VSMOW} + \gamma
#' \textrm{ , where } \beta=0.528 \textrm{ and } \gamma = 0 }
#'
#' \deqn{\Delta^{17}O_{SiO2,VSMOW} = \delta'^{17}O_{SiO2,VSMOW} -
#' \lambda \times \delta'^{18}O_{SiO2,VSMOW} }
#'
#' @references
#' Sharp, Z.D., Gibbons, J.A., Maltsev, O., Atudorei, V., Pack, A.,
#' Sengupta, S., Shock, E.L. and Knauth, L.P. (2016).
#' A calibration of the triple oxygen isotope fractionation in the
#' SiO2–H2O system and applications to natural samples.
#' Geochimica et Cosmochimica Acta, 186, 105–119.
#' \doi{10.1016/j.gca.2016.04.047}
#'
#' @family quartz
#'
#' @examples
#' d17O_qz(temp = 10, d18O_H2O_VSMOW = 0) # Returns the data frame (length = 3)
#' d17O_qz(temp = 10, d18O_H2O_VSMOW = 0)[, 3] # Returns the D17O value
#'
#' @export

d17O_qz = function(temp, d18O_H2O_VSMOW, D17O_H2O = 0, lambda = 0.528) {

  TinK = temp + 273.15

  # Sharp et al. (2016)
  theta = -1.85 / (temp + 273.15) + 0.5305

  a18_qz_H2O = exp((4.28 * 10 ** 6 / TinK ^ 2 - 3.5 * 10 ** 3 / TinK) / 1000)
  a17_qz_H2O  = a18_qz_H2O ^ theta

  d18O_qz   = a18_qz_H2O * (d18O_H2O_VSMOW + 1000) - 1000

  # calculating the d17O prime value of ambient water
  if (class(D17O_H2O) == "numeric" && is.finite(D17O_H2O)) {
    d17Ow_p = D17O_H2O + lambda * prime(d18O_H2O_VSMOW)
  } else {
    stop("Invalid input for D17O_H2O")
  }

  d17O_qz = (unprime(d17Ow_p) + 1000) * a17_qz_H2O - 1000
  D17O_qz  = prime(d17O_qz) - lambda * prime(d18O_qz)

  data.frame(d18O_qz, d17O_qz, D17O_qz)

  }
