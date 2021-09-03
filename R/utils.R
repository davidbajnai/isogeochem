# Functions in this file: prime(), unprime()

#' @title Converting delta to delta prime
#'
#' @description `prime()` converts "classical delta" values to "delta prime" values.
#'
#' @param classical "Classical delta" values to be converted (parts per mille).
#'
#' @return Returns the "delta prime" value (parts per mille).
#'
#' @details
#' \deqn{\delta'^{17}O = 1000 \times \ln(\frac{\delta^{17}O}{1000}+1)}
#'
#' @examples
#' prime(10)
#'
#' @seealso [unprime()] converts "delta prime" values to "classical delta" values.
#'
#' @export

prime = function(classical) 1000 * log(1 + classical/1000)

##————————————————————————————————————————————————————————————————————————————————##

#' @title Converting delta prime to delta
#'
#' @description `unprime()` converts "delta prime" values to "classical delta" values.
#'
#' @param prime "Delta prime" values to be converted (parts per mille).
#'
#' @return Returns the "classical delta" value (parts per mille).
#'
#' @examples
#' unprime(9.950331)
#'
#' @details
#' \deqn{\delta^{17}O = 1000 \times e^{(\frac{\delta'^{17}O}{1000}+1)}}
#'
#' @seealso [prime()] converts "classical delta" values to "delta prime" values.
#'
#' @export

unprime = function(prime) (exp(prime/1000)-1)*1000
