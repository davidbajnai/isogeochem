% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/d18O.R
\name{d18O_H2O}
\alias{d18O_H2O}
\title{Water d18O value}
\usage{
d18O_H2O(temp, d18O_c_VSMOW, min, eq)
}
\arguments{
\item{temp}{Carbonate growth temperature (°C).}

\item{d18O_c_VSMOW}{Carbonate d18O value expressed on the VSMOW scale (‰).}

\item{min}{Mineralogy. Options are \code{"calcite"}, \code{"aragonite"},
and \code{"dolomite"}.}

\item{eq}{Equation used to calculate the equilibrium 18O/16O oxygen isotope
fractionation factor between carbonate and water.
Options depend on mineralogy and listed in \code{\link[=a18_c_H2O]{a18_c_H2O()}}.}
}
\value{
Returns the water d18O value expressed on the VSMOW scale (‰).
}
\description{
\code{d18O_H2O()} calculates the d18O value of the ambient water
from the d18O value of a carbonate and its growth temperature.
}
\note{
Use \code{\link[=to_VSMOW]{to_VSMOW()}} and \code{\link[=to_VPDB]{to_VPDB()}} to convert between
the VSMOW and VPDB scales.
}
\examples{
d18O_H2O(temp = 33.7, d18O_c_VSMOW = 14.58,
         min = "calcite", eq = "Coplen07")
d18O_H2O(temp = 25, d18O_c_VSMOW = to_VSMOW(-7.47),
         min = "aragonite", eq = "GK86")

}
\references{
References are listed in the description of \code{\link[=a18_c_H2O]{a18_c_H2O()}}.
}
\seealso{
\code{\link[=d18O_c]{d18O_c()}} calculates the equilibrium d18O value of a carbonate
grown at a given temperature.
\code{\link[=temp_d18O]{temp_d18O()}} calculates growth temperatures from oxygen isotope data.
}
