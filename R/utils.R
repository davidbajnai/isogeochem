# Functions in this file: prime(), unprime(), a_A_B(), B_from_a(), A_from_a()

##———————————————————————————————————————————————————————————————————————————##
#### prime ####
#' @title Converting delta to delta prime
#'
#' @description `prime()` converts "classical delta" values
#'    to "delta prime" values.
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

##———————————————————————————————————————————————————————————————————————————##
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
#' @param A Delta value of A (‰).
#' @param B Delta value of B (‰).
#'
#' @return Returns the isotope fractionation factor "alpha".
#'
#' @examples
#' a_A_B(10, 12)
#'
#' @details
#' \deqn{\alpha^{i}E_{A/B} =
#' \frac{\delta^{i}E_{A} + 1000}{\delta^{i}E_{B} + 1000}}
#'
#' @seealso [B_from_a()] calculates the delta value of B.
#'
#' @family fractionation_factors
#'
#' @export

a_A_B = function(A, B) {
  (A+1000)/(B+1000)
}

##——————————————————————————————————————————————————————————————————————————##
#### B_from_a ####
#' @title Isotope composition from fractionation factor
#'
#' @description `B_from_a()` calculates the delta value of B using
#'   an isotope fractionation factor alpha.
#'
#' @param a Isotope fractionation factor between A/B.
#' @param A Delta value of A (‰).
#'
#' @return Returns the delta value of B (‰).
#'
#' @examples
#' B_from_a(1.033, 12)
#'
#' @seealso [a_A_B()] calculates the isotope fractionation
#'   factor between A and B.
#' @seealso [A_from_a()] calculates the delta value of B.
#'
#' @export

B_from_a = function(a, A) {
  (A + 1000) / a - 1000
}

##———————————————————————————————————————————————————————————————————————————##
#### A_from_a ####
#' @title Isotope composition from fractionation factor
#'
#' @description `A_from_a()` calculates the delta value of A from the
#' isotope fractionation factor and the delta value of B.
#'
#' @param a Isotope fractionation factor between A/B "alpha".
#' @param B Delta value of B (‰).
#'
#' @return Returns the delta value of B (‰).
#'
#' @examples
#' A_from_a(1.033, -10)
#'
#' @seealso [a_A_B()] calculates the isotope fractionation factor
#'   between A and B.
#' @seealso [A_from_a()] calculates the delta value of B.
#'
#' @export

A_from_a = function(a, B) {
  (B + 1000) * a - 1000
}
