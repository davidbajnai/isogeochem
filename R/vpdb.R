# Functions in this file: to_VSMOW(), to_VPDB()

# ——————————————————————————————————————————————————————————————————————————— #
#### to_VSMOW ####
#' @title
#' Converting isotope delta from VPDB to VSMOW
#'
#' @description
#' `to_VSMOW()` converts d18O value expressed on the VPDB scale
#' to the VSMOW scale.
#'
#' @param d18O_VPDB d18O values expressed on the VPDB scale (‰).
#' @param eq Equation used for the conversion.
#' * `"IUPAC"` (default): the IUPAC recommended equation
#'   listed in Brand et al. (2014) and Kim et al. (2015).
#' * `"Coplen83"`: the equation listed in Coplen et al. (1983)
#'   and the Hoefs book.
#'
#' @return
#' Returns the d18O value expressed on the VSMOW scale (‰).
#'
#' @references
#' Coplen, T. B., Kendall, C., & Hopple, J. (1983).
#' Comparison of stable isotope reference samples.
#' Nature, 302, 236-238.
#' <https://doi.org/10.1038/302236a0>
#'
#' Brand, W. A., Coplen, T. B., Vogl, J., Rosner, M., & Prohaska, T. (2014).
#' Assessment of international reference materials for
#' isotope-ratio analysis (IUPAC Technical Report).
#' Pure and Applied Chemistry, 86(3), 425-467.
#' <https://doi.org/10.1515/pac-2013-1023>
#'
#' Kim, S.-T., Coplen, T. B., & Horita, J. (2015).
#' Normalization of stable isotope data for carbonate minerals:
#' Implementation of IUPAC guidelines.
#' Geochimica et Cosmochimica Acta, 158, 276-289.
#' <https://doi.org/10.1016/j.gca.2015.02.011>
#'
#' @examples
#' to_VSMOW(0)
#' to_VSMOW(0, eq = "Coplen83")
#'
#' @details
#' The IUPAC recommended equation to convert between the scales is:
#'
#' \deqn{\delta^{18}O_{VSMOW} = 1.03092 \times \delta^{18}O_{VPDB} + 30.92}
#'
#' @seealso [to_VPDB()] converts d18O values expressed
#'   on the VSMOW scale to the VPDB scale.
#'
#' @export

to_VSMOW <- function(d18O_VPDB, eq = "IUPAC") {
  if (eq == "IUPAC") {
    1.03092 * d18O_VPDB + 30.92
  } else if (eq == "Coplen83") {
    1.03091 * d18O_VPDB + 30.91
  } else {
    stop("Invalid input for eq")
  }
}

# ——————————————————————————————————————————————————————————————————————————— #
#### to_VPDB ####
#' @title
#' Converting isotope delta from VSMOW to VPDB
#'
#' @description
#' `to_VPDB()` convert d18O value expressed on the VSMOW scale
#'  to the VPDB scale.
#'
#' @param d18O_VSMOW d18O values expressed on the VSMOW scale (‰).
#' @param eq Equation used for the conversion.
#'   * `"IUPAC"` (default): the IUPAC recommended equation
#'     listed in Brand et al. (2014) and Kim et al. (2015).
#'   * `"Coplen83"`: the equation listed in Coplen et al. (1983)
#'     and the Hoefs book.
#'
#' @return
#' Returns the d18O value expressed on the VPDB scale (‰).
#'
#' @references
#' References are listed at [to_VSMOW()].
#'
#' @examples
#' to_VPDB(0)
#' to_VPDB(0, eq = "Coplen83")
#'
#' @details
#' The IUPAC recommended equation to convert between the scales is:
#'
#' \deqn{\delta^{18}O_{VPDB} = 0.97001 \times \delta^{18}O_{VSMOW} - 29.99}
#'
#' @seealso [to_VSMOW()] converts d18O values expressed on the VPDB scale
#'   to the VSMOW scale.
#'
#' @export

to_VPDB <- function(d18O_VSMOW, eq = "IUPAC") {
  if (eq == "IUPAC") {
    0.97001 * d18O_VSMOW - 29.99
  } else if (eq == "Coplen83") {
    0.97002 * d18O_VSMOW - 29.98
  } else {
    stop("Invalid input for eq")
  }
}
