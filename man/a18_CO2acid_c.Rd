% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/a18.R
\name{a18_CO2acid_c}
\alias{a18_CO2acid_c}
\title{18O/16O acid fractionation factor}
\usage{
a18_CO2acid_c(temp, min)
}
\arguments{
\item{temp}{Acid digestion temperature (°C).}

\item{min}{Mineralogy. Options are \code{"calcite"}, \code{"aragonite"},
and \code{"dolomite"}.}
}
\value{
Returns the 18O/16O fractionation factor.
}
\description{
\code{a18_CO2acid_c()} calculates the 18O/16O fractionation factor between
CO2 produced from acid digestion and carbonate.
}
\details{
\strong{calcite} (Kim et al. 2015):

\deqn{\alpha^{18}_{CO2acid/calcite} =
e^{(3.48 \times \frac{1}{T} - 0.00147)}}

\strong{aragonite} (Kim et al. 2007):

\deqn{\alpha^{18}_{CO2acid/aragonite} =
e^{(3.39 \times \frac{1}{T} - 0.00083)}}

\strong{dolomite} (Rosenbaum & Sheppard 1986):

\deqn{\alpha^{18}_{CO2acid/dolomite} =
e^{(665 \times \frac{1}{T^{2}} + 0.00423)}}
}
\examples{
a18_CO2acid_c(temp = 90, min = "calcite")
a18_CO2acid_c(temp = 72, min = "aragonite")

}
\references{
Sharma, T., and Clayton, R. N. (1965).
Measurement of ratios of total oxygen of carbonates.
Geochimica et Cosmochimica Acta, 29(12), 1347-1353.
\doi{10.1016/0016-7037(65)90011-6}

Rosenbaum, J. and Sheppard, S.M.F. (1986).
An isotopic study of siderites, dolomites and ankerites
at high temperatures.
Geochimica et Cosmochimica Acta, 50, 1147-1150.
\doi{10.1016/0016-7037(86)90396-0}

Kim, S.-T., Mucci, A., and Taylor, B. E. (2007).
Phosphoric acid fractionation factors for calcite and aragonite
between 25 and 75 °C: Revisited.
Chemical Geology, 246(3-4), 135-146.
\doi{10.1016/j.chemgeo.2007.08.005}

Kim, S.-T., Coplen, T. B., and Horita, J. (2015).
Normalization of stable isotope data for carbonate minerals:
Implementation of IUPAC guidelines.
Geochimica et Cosmochimica Acta, 158, 276-289.
\doi{10.1016/j.gca.2015.02.011}
}
\seealso{
Other fractionation_factors: 
\code{\link{a13_CO2g_CO2aq}()},
\code{\link{a18_CO2aq_H2O}()},
\code{\link{a18_CO2g_H2O}()},
\code{\link{a18_CO3_H2O}()},
\code{\link{a18_H2O_OH}()},
\code{\link{a18_HCO3_H2O}()},
\code{\link{a18_c_H2O}()},
\code{\link{a_A_B}()}
}
\concept{fractionation_factors}
