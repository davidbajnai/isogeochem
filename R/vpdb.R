# Functions in this file: VSMOW(),VPDB()

#' @title Converting between VPDB and VSMOW scales
#' @description
#' `VMSOW()` converts d18O values expressed on the VPDB scale to the VSMOW scale.
#' @param d18O_VPDB d18O values expressed on the VPDB scale (parts per mille).
#' @param eq Defines the equation used for the conversion. Options are *"IUPAC"*, and *"Coplen83"*.
#' The default is *"IUPAC"*: the IUPAC recommended equation listed in Brand et al. (2014) and Kim et al. (2015).
#' To use the equation listed in Coplen et al. (1983) and the Hoefs book, set the parameter to *"Coplen83"*.
#' @return
#' Returns d18O values expressed on the VSMOW scale (parts per mille).
#' @references
#' Coplen, T. B., Kendall, C., & Hopple, J. (1983). Comparison of stable isotope reference samples. Nature, 302, 236-238. <https://www.doi.org/10.1038/302236a0>
#'
#' Brand, W. A., Coplen, T. B., Vogl, J., Rosner, M., & Prohaska, T. (2014). Assessment of international reference materials for isotope-ratio analysis (IUPAC Technical Report). Pure and Applied Chemistry, 86(3), 425-467. <https://www.doi.org/10.1515/pac-2013-1023>
#'
#' Kim, S.-T., Coplen, T. B., & Horita, J. (2015). Normalization of stable isotope data for carbonate minerals: Implementation of IUPAC guidelines. Geochimica et Cosmochimica Acta, 158, 276-289. <https://www.doi.org/10.1016/j.gca.2015.02.011>
#' @examples
#' VSMOW(0) # Returns 30.92
#' VSMOW(0, eq="Coplen83") # Returns 30.91
#' @seealso [VPDB()]
#' @export

VSMOW <- function(d18O_VPDB, eq = "IUPAC") {
  if(eq == "IUPAC") {
  VSMOW = 1.03092 * d18O_VPDB + 30.92
  }
  if(eq == "Coplen83") {
  VSMOW = 1.03091 * d18O_VPDB + 30.91
  }
  return(VSMOW)
}

##————————————————————————————————————————————————————————————————————————————————##

#' @title Converting between VSMOW and VPDB scales
#' @description
#' `VPDB()` converts d18O values expressed on the VSMOW scale to the VPDB scale.
#' @param d18O_VSMOW d18O values expressed on the VSMOW scale (parts per mille).
#' @param eq Defines the equation used for the conversion. Options are *"IUPAC"*, and *"Coplen83"*.
#' The default is *"IUPAC"*: the IUPAC recommended equation listed in Brand et al. (2014) and Kim et al. (2015).
#' To use the equation listed in Coplen et al. (1983) and the Hoefs book, set the parameter to *"Coplen83"*.
#' @return
#' Returns d18O values expressed on the VPDB scale (parts per mille).
#' @references
#' Coplen, T. B., Kendall, C., & Hopple, J. (1983). Comparison of stable isotope reference samples. Nature, 302, 236-238. <https://www.doi.org/10.1038/302236a0>
#'
#' Brand, W. A., Coplen, T. B., Vogl, J., Rosner, M., & Prohaska, T. (2014). Assessment of international reference materials for isotope-ratio analysis (IUPAC Technical Report). Pure and Applied Chemistry, 86(3), 425-467. <https://www.doi.org/10.1515/pac-2013-1023>
#'
#' Kim, S.-T., Coplen, T. B., & Horita, J. (2015). Normalization of stable isotope data for carbonate minerals: Implementation of IUPAC guidelines. Geochimica et Cosmochimica Acta, 158, 276-289. <https://www.doi.org/10.1016/j.gca.2015.02.011>
#' @examples
#' VPDB(0) # Returns -29.99
#' VPDB(0, eq="Coplen83") # Returns -29.98
#' @seealso [VSMOW()]
#' @export

VPDB <- function(d18O_VSMOW, eq = "IUPAC") {
  if(eq == "IUPAC") {
  VPDB = 0.97001 * d18O_VSMOW - 29.99
  }
  if(eq == "Coplen83") {
  VPDB = 0.97002 * d18O_VSMOW - 29.98
  }
  return(VPDB)
}
