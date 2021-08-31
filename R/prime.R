# Functions in this file: prime(), unprime()

#' @title Converting d18O to d'18O
#' @description
#' `prime()` converts d18O values to d'18O
#' @param d18O d18O values to be converted (parts per mille).
#' @return
#' Returns the d'18O value (parts per mille).
#' @examples
#' prime(10) # Returns 9.950331
#' @seealso [unprime()]
#' @export

prime = function(d18O) {
  d18O_prime = 1000 * log(1 + d18O/1000)
  return(d18O_prime)
}

##————————————————————————————————————————————————————————————————————————————————##

#' @title Converting d'18O to d18O
#' @description
#' `unprime()` converts d'18O values to d18O.
#' @param d18O_prime d18O values to be converted (parts per mille).
#' @return
#' Returns the d18O value (parts per mille).
#' @examples
#' unprime(9.950331) # Returns 10
#' @seealso [prime()]
#' @export

unprime = function(d18O_prime) {
  d18O = (exp(d18O_prime/1000)-1)*1000
  return(d18O)
}
