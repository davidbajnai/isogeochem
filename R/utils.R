# Functions in this file: prime(), unprime(), a_A_B(), B_from_a(), A_from_a()

# ——————————————————————————————————————————————————————————————————————————— #
#### prime ####
#' @title Converting delta to delta prime
#'
#' @description
#' `prime()` converts "classical delta" values to "delta prime" values.
#'
#' @param classical "Classical delta" values to be converted (‰).
#'
#' @return Returns the "delta prime" value (‰).
#'
#' @details
#' \deqn{\delta'^{17}O = 1000 \times \ln(\frac{\delta^{17}O}{1000}+1)}
#'
#' @examples
#' prime(10) # Return 9.950331
#'
#' @seealso [unprime()] converts "delta prime" values to
#'   "classical delta" values.
#'
#' @export

prime = function(classical) {
  1000 * log(1 + classical/1000)
}

# ——————————————————————————————————————————————————————————————————————————— #
#### unprime ####
#' @title Converting delta prime to delta
#'
#' @description `unprime()` converts "delta prime" values
#'   to "classical delta" values.
#'
#' @param prime "Delta prime" values to be converted (‰).
#'
#' @return Returns the "classical delta" value (‰).
#'
#' @examples
#' unprime(9.950331) # Return 10
#'
#' @details
#' \deqn{\delta^{17}O = 1000 \times e^{(\frac{\delta'^{17}O}{1000}+1)}}
#'
#' @seealso [prime()] converts "classical delta" values to
#'   "delta prime" values.
#'
#' @export

unprime = function(prime) {
  (exp(prime/1000)-1)*1000
}

##———————————————————————————————————————————————————————————————————————————##
#### a_A_B ####
#' @title Isotope fractionation factor between A and B
#'
#' @description `a_A_B()` calculates the isotope fractionation factor.
#'
#' @param A Isotope delta value of A (‰).
#' @param B Isotope delta value of B (‰).
#'
#' @return Returns the isotope fractionation factor.
#'
#' @details
#' \deqn{\alpha^{i}E_{A/B} =
#' \frac{\delta^{i}E_{A} + 1}{\delta^{i}E_{B} + 1}}
#'
#' @seealso
#' [A_from_a()] calculates the isotope delta value of A.
#'
#' [B_from_a()] calculates the isotope delta value of B.
#'
#' @family fractionation_factors
#'
#' @examples
#' a_A_B(A = 10, B = 12)
#'
#' @export

a_A_B = function(A, B) {
  (A + 1000) / (B + 1000)
}

# ———————————————————————————————————————————————————————————————–——————————— #
#### B_from_a ####
#' @title Isotope delta from fractionation factor
#'
#' @description
#' `B_from_a()` calculates the isotope delta value of B from the
#' isotope fractionation factor and the isotope delta value of A.
#'
#' @param a Isotope fractionation factor between A and B.
#' @param A Isotope delta value of A (‰).
#'
#' @return Returns the Isotope delta value of B (‰).
#'
#' @seealso
#' [a_A_B()] calculates the isotope fractionation factor between A and B.
#'
#' [A_from_a()] calculates the isotope delta value of A.
#'
#' @examples
#' B_from_a(a = 1.033, A = 10)
#'
#' @export

B_from_a = function(a, A) {
  (A + 1000) / a - 1000
}

# ———————————————————————————————————————————————————————————————–——————————— #
#### A_from_a ####
#' @title Isotope delta from fractionation factor
#'
#' @description
#' `A_from_a()` calculates the isotope delta value of A from the
#' isotope fractionation factor and the isotope delta value of B.
#'
#' @param a Isotope fractionation factor between A and B.
#' @param B Isotope delta value of B (‰).
#'
#' @return Returns the isotope delta value of B (‰).
#'
#' @seealso
#' [a_A_B()] calculates the isotope fractionation factor between A and B.
#'
#' [B_from_a()] calculates the isotope delta value of B.
#'
#' @examples
#' A_from_a(a = 1.033, B = -10)
#'
#' @export

A_from_a = function(a, B) {
  (B + 1000) * a - 1000
}


# ——————————————————————————————————————————————————————————————————————————— #
#### epsilon ####
#' @title Isotope fractionation value
#'
#' @description
#' `epsilon()` converts isotope fractionation factors to isotope fractionation values.
#'
#' @param alpha Isotope fractionation factor
#'
#' @return Returns the isotope fractionation value (‰).
#'
#' @details
#' \deqn{\epsilon^{i}E_{A/B} = \alpha^{i}E_{A/B} - 1}
#'
#' @seealso
#' a_A_B() calculates the isotope fractionation factor between A and B.
#'
#' @examples
#' epsilon(a18_H2O_OH(25, "Z20-X3LYP"))
#'
#' @export

epsilon = function(alpha) {
  (alpha - 1) * 1000
}
