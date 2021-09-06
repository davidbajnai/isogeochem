# Datasets described in this file: "devilshole", "LR04"

##———————————————————————————————————————————————————————————————————————————##
#### devilshole ####
#' @title Devils Hole carbonate d18O time series
#'
#' @description
#' A dataset containing the d18O values of the "original" Devils Hole cores.
#'
#' @source \url{https://doi.org/10.3133/ofr20111082}
#'
#' @references
#' Winograd, I. J., Landwehr, J. M., Coplen, T. B., Sharp, W. D.,
#' Riggs, A. C., Ludwig, K. R., & Kolesar, P. T. (2006).
#' Devils Hole, Nevada, d18O record extended to the mid-Holocene.
#' Quaternary Research, 66(2), 202-212.
#' <https://doi.org/10.1016/j.yqres.2006.06.003>
#'
#' @format A data frame with 442 rows and 4 variables:
#' \describe{
#'   \item{age}{Interpolated uranium-series age of the sample expressed
#'   as thousands of years before present (ka).}
#'   \item{d18O_VSMOW}{Carbonate d18O value relative to VSMOW (per mille).}
#'   \item{d18O_error}{Standard deviation on the d18O value.}
#'   \item{core}{Name of the core (DHC2-8, DHC2-3, DH-11).}
#' }
#'
#' @family "datasets"
"devilshole"

##———————————————————————————————————————————————————————————————————————————##

#' @title A Pliocene-Pleistocene benthic foraminifera d18O stack
#'
#' @description
#' A dataset containing the LR04 benthic d18O stack.
#'
#' @source \url{https://lorraine-lisiecki.com/stack.html}
#'
#' @references
#' Lisiecki, L. E., & Raymo, M. E. (2005).
#' A Pliocene-Pleistocene stack of 57 globally distributed
#' benthic d18O records.
#' Paleoceanography, 20(1), PA1003.
#' <https://doi.org/10.1029/2004pa001071>
#'
#' @format A data frame with 2115 rows and 3 variables:
#' \describe{
#'   \item{age}{Age of the sample expressed as thousands of years
#'     before present (ka).}
#'   \item{d18O_VPDB}{Carbonate d18O value relative to VPDB (per mille).}
#'   \item{d18O_error}{Standard error on the d18O value.}
#' }
#'
#' @family "datasets"
"LR04"

##————————————————————————————————————————————————————————————————————————————————##

#' @title
#' Oxygen isotope stratigraphy from the Geologic Time Scale 2020: macrofossils
#'
#' @description A dataset containing a compilation of d18O and d13C values
#'   of various macrofossils
#'   (bivalves, gastropods, belemnites, ammonites) together with information
#'   on their age, shell mineralogy, and the climate zone they represent.
#'   This dataset is a condensed version of the entire dataset presented in the
#'   Geologic Time Scale 2020. Specifically, the full dataset was filtered for
#'   those "select" d18O and d13C values that also have age information.
#'
#' @source
#' \url{https://download.pangaea.de/dataset/930093/files/GTS2020-App_10.2A.xlsx}
#'
#' @references
#' Grossman, E. L., & Joachimski, M. M. (2020).
#' Oxygen isotope stratigraphy.
#' In F. M. Gradstein, J. G. Ogg, M. D. Schmitz, & G. M. Ogg (Eds.),
#' Geologic Time Scale 2020: Volume 1 (pp. 279-307): Elsevier.
#' <https://doi.org/10.1016/B978-0-12-824360-2.00010-3>
#'
#' @format A data frame with 9676 rows and 8 variables:
#' \describe{
#'   \item{age}{Age of the sample expressed as
#'     millions of years before present (Ma).}
#'   \item{d18O_VPDB}{Carbonate d18O value relative to VPDB (per mille).}
#'   \item{d13C_VPDB}{Carbonate d13C value relative to VPDB (per mille).}
#'   \item{mineralogy}{The mineralogy of the carbonate hard part.}
#'   \item{group}{The fossil group (bivalve, gastropod, belemnite, ammonite).}
#'   \item{clim_zone}{The climate zone the fossil represents.}
#' }
#'
#' @family "datasets"
"GTS2020"
