# Functions in this file: d17O_c(), mix_d17O()

##———————————————————————————————————————————————————————————————————————————##
#### d17O_c ####
#' @title Triple oxygen isotope values of carbonates
#'
#' @description
#' `d17O_c()` calculates the equilibrium d18O, d17O, and D17O values of a
#' calcite grown at a given temperature.
#'
#' @param temp Calcite growth temperature (°C).
#' @param d18O_H2O_VSMOW Water d18O value expressed on the VSMOW scale (‰).
#' @param D17O_H2O D17O value of ambient water calculated using
#'   a lambda of `0.528`. Default `0`.
#' @param min Mineralogy. Options are `"calcite"` (default) and `"aragonite"`.
#' @param eq18 Equation used to calculate the 18O/16O fractionation factor
#'   between carbonate and water. Options are like in [a18_c_H2O()].
#'   Default `"Daeron19"`.
#' @param eq17 Equation used to calculate the 17O/16O fractionation factor
#'   between carbonate and water. Options are `"Wostbrock20"` (default) and `"GZ19"`.
#' @param lambda Triple oxygen isotope reference slope. Default `0.528`.
#'
#' @return
#' Returns a data frame:
#' 1. d18O value of the carbonate expressed on the VSMOW scale (‰).
#' 2. d17O value of the carbonate expressed on the VSMOW scale (‰).
#' 3. D17O value of the carbonate expressed on the VSMOW scale (‰).
#'
#' @details
#' \deqn{\theta_{A/B} = \frac{\alpha^{17}_{A/B}}{\alpha^{18}_{A/B}}}
#'
#' \deqn{ \delta'^{17}O_{H2O,VSMOW} =
#' \beta \times \delta'^{18}O_{H2O,VSMOW} + \gamma
#' \textrm{ , where } \beta=0.528 \textrm{ and } \gamma = 0 }
#'
#' \deqn{\Delta^{17}O_{CaCO3,VSMOW} = \delta'^{17}O_{CaCO3,VSMOW} -
#' \lambda \times \delta'^{18}O_{CaCO3,VSMOW} }
#'
#' `"Wostbrock20"`: Wostbrock et al. (2020):
#'
#' \deqn{\theta_{aragonite/water} = \frac{-1.53}{T} + 0.5305}
#'
#' \deqn{\theta_{calcite/water} = \frac{-1.39}{T} + 0.5305}
#'
#' `"GZ19"`: Guo and Zhou (2019):
#'
#' \deqn{\theta_{aragonite/water} = \frac{78.1173}{T^{2}} - \frac{1.5152}{T} + 0.5299}
#'
#' \deqn{\theta_{calcite/water} = \frac{59.1047}{T^{2}} - \frac{1.4089}{T} + 0.5297}
#'
#' @references
#' Wostbrock, J.A.G., Brand, U., Coplen, T.B., Swart, P.K.,
#' Carlson, S.J., Brearley, A.J., and Sharp, Z.D. (2020).
#' Calibration of carbonate-water triple oxygen isotope fractionation:
#' Seeing through diagenesis in ancient carbonates.
#' Geochimica et Cosmochimica Acta, 288, 369-388.
#' \doi{10.1016/j.gca.2020.07.045}
#'
#' Guo, W., and Zhou, C. (2019).
#' Triple oxygen isotope fractionation in the DIC-H2O-CO2 system:
#' A numerical framework and its implications.
#' Geochimica et Cosmochimica Acta, 246, 541-564.
#' \doi{10.1016/j.gca.2018.11.018}
#'
#' @family equilibrium_carbonate
#'
#' @examples
#' d17O_c(temp = 10, d18O_H2O_VSMOW = -1) # Returns the data frame (length = 3)
#' prime(d17O_c(temp = 10, d18O_H2O_VSMOW = -1)[, 2]) # Returns the d'17O value
#' d17O_c(temp = 10, d18O_H2O_VSMOW = -1)[, 3] # Returns the D17O value
#'
#' @export

d17O_c = function(temp, d18O_H2O_VSMOW, D17O_H2O = 0, min = "calcite", eq17 = "Wostbrock20", eq18 = "Daeron19", lambda = 0.528) {

  TinK = temp + 273.15

if (min == "aragonite") {
    if (eq17 == "GZ19")  {
      # Guo and Zhou (2019)
      theta = 78.1173 / TinK ^ 2 - 1.5152 / TinK + 0.5299
    } else if (eq17 == "Wostbrock20") {
      # Wostbrock et al. (2020)
      theta = -1.53 / TinK + 0.5305
    } else {
      stop("Invalid input for eq17. Options for aragonite are GZ19 and Wostbrock20.")
    }
  } else if (min == "calcite") {
    if (eq17 == "GZ19")  {
      # Guo and Zhou (2019)
      theta = 59.1047 / TinK ^ 2 - 1.4089 / TinK + 0.5297
    } else if (eq17 == "Wostbrock20") {
      # Wostbrock et al. (2020)
      theta = -1.39 / TinK + 0.5305
    } else {
      stop("Invalid input for eq17. Options for calcite are GZ19 and Wostbrock20.")
    }
  } else {
    stop("Invalid input for min. Options are calcite and aragonite.")
  }

  a18_c_H2O = isogeochem::a18_c_H2O(temp = temp, min = min, eq = eq18)
  a17_c_H2O  = a18_c_H2O ^ theta
  d18O_c   = d18O_c(temp, d18O_H2O_VSMOW, min = min, eq18)

  d17Ow_p = D17O_H2O + lambda * prime(d18O_H2O_VSMOW)

  d17O_c = (unprime(d17Ow_p) + 1000) * a17_c_H2O - 1000
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
#' @param D17O_A Alternatively, the D17O value of component A (‰).
#' @param d18O_B d18O value of component B (‰).
#' @param d17O_B d17O value of component B (‰).
#' @param D17O_B Alternatively, the D17O value of component B (‰).
#' @param lambda Triple oxygen isotope reference slope. Default `0.528`.
#' @param step Output resolution, i.e., step size. Default `10`%.
#'
#' @details
#' If both d17O and D17O values are specified for a component,
#' the function uses the d17O values for the calculations.
#'
#' @return
#' Returns a data frame:
#' 1. d18O value of the mixture at x% mixing (‰).
#' 2. D17O value of the mixture at x% mixing (‰).
#' 3. relative amount of component B in the mixture (%):
#'   from 100% A and 0% B to 0% A and 100% B.
#' 4. d17O value of the mixture at x% mixing (‰).
#'
#' @examples
#' # The two functions below yield the same output.
#' mix_d17O(d18O_A = d17O_c(10, -1)[1], d17O_A = d17O_c(10, -1)[2],
#'          d18O_B = d17O_c(100,0)[1], d17O_B = d17O_c(100, 0)[2])
#' mix_d17O(d18O_A = d17O_c(10, -1)[1], D17O_A = d17O_c(10, -1)[3],
#'          d18O_B = d17O_c(100,0)[1], D17O_B = d17O_c(100, 0)[3])
#'
#' @seealso [d17O_c()] calculates equilibrium calcite d18O, d17O, and D17O
#'   values for a given temperature.
#'
#' @export

mix_d17O = function (d18O_A, d17O_A, D17O_A, d18O_B, d17O_B, D17O_B, lambda = 0.528, step = 10) {

  ratio_B = seq(0, 1, step / 100)

  if (missing(d17O_A)) {
    d17O_A = unprime(D17O_A + lambda * prime(d18O_A))
  }

  if (missing(d17O_B)) {
    d17O_B = unprime(D17O_B + lambda * prime(d18O_B))
  }

  mix_d18O = ratio_B * as.numeric(d18O_B) + (1 - ratio_B) * as.numeric(d18O_A)
  mix_d17O = ratio_B * as.numeric(d17O_B) + (1 - ratio_B) * as.numeric(d17O_A)
  mix_D17O = D17O(mix_d18O, mix_d17O, lambda)
  xB = ratio_B * 100

  data.frame(mix_d18O, mix_D17O, xB, mix_d17O)

}
