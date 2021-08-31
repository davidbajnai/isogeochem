# Functions in this file: mix_d17O()

#' @title Mixing curves
#' @description
#' Use `mix_d17O()` to produce mixing curves in in triple oxygen isotope space (d18O vs. D17O).
#' @param d18O_A d18O values of component A (parts per mille).
#' @param d17O_A d17O values of component A (parts per mille).
#' @param d18O_B d18O values of component B (parts per mille).
#' @param d17O_B d17O values of component B (parts per mille).
#' @param lambda Triple oxygen isotope reference slope. Default is 0.528.
#' @return
#' Returns a data frame that contains the d18O and d17O values of the mixture,
#' from 100% A and 0% B to 0% A and 100% B.
#' @examples
#' # Mixing between a Mesozoic marine carbonate and a diagentic carbonate
#' mix_d17O(d17O(10,-1)[1],d17O(10,-1)[2],d17O(100,0)[1],d17O(100,0)[2])
#' @seealso [d17O()]
#' @export

mix_d17O = function(d18O_A, d17O_A, d18O_B, d17O_B, lambda = 0.528) {
  x = seq(0,1,0.1)
  mix_d18O = x*as.numeric(d18O_B) + (1-x)*as.numeric(d18O_A)
  mix_d17O = x*as.numeric(d17O_B) + (1-x)*as.numeric(d17O_A)
  mix_D17O = (prime(mix_d17O) - lambda * prime(mix_d18O))
  mix_d17O = data.frame(mix_d18O, mix_D17O)
  return(mix_d17O)
  }
