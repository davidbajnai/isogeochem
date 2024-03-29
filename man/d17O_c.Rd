% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/d17O.R
\name{d17O_c}
\alias{d17O_c}
\title{Triple oxygen isotope values of carbonates}
\usage{
d17O_c(
  temp,
  d18O_H2O_VSMOW,
  D17O_H2O = 0,
  min = "calcite",
  eq17 = "Wostbrock20",
  eq18 = "Daeron19",
  lambda = 0.528
)
}
\arguments{
\item{temp}{Calcite growth temperature (°C).}

\item{d18O_H2O_VSMOW}{Water d18O value expressed on the VSMOW scale (‰).}

\item{D17O_H2O}{D17O value of ambient water calculated using
a lambda of \code{0.528}. Default \code{0}.}

\item{min}{Mineralogy. Options are \code{"calcite"} (default) and \code{"aragonite"}.}

\item{eq17}{Equation used to calculate the 17O/16O fractionation factor
between carbonate and water. Options are \code{"Wostbrock20"} (default) and \code{"GZ19"}.}

\item{eq18}{Equation used to calculate the 18O/16O fractionation factor
between carbonate and water. Options are like in \code{\link[=a18_c_H2O]{a18_c_H2O()}}.
Default \code{"Daeron19"}.}

\item{lambda}{Triple oxygen isotope reference slope. Default \code{0.528}.}
}
\value{
Returns a data frame:
\enumerate{
\item d18O value of the carbonate expressed on the VSMOW scale (‰).
\item d17O value of the carbonate expressed on the VSMOW scale (‰).
\item D17O value of the carbonate expressed on the VSMOW scale (‰).
}
}
\description{
\code{d17O_c()} calculates the equilibrium d18O, d17O, and D17O values of a
calcite grown at a given temperature.
}
\details{
\deqn{\theta_{A/B} = \frac{\alpha^{17}_{A/B}}{\alpha^{18}_{A/B}}}

\deqn{ \delta'^{17}O_{H2O,VSMOW} =
\beta \times \delta'^{18}O_{H2O,VSMOW} + \gamma
\textrm{ , where } \beta=0.528 \textrm{ and } \gamma = 0 }

\deqn{\Delta^{17}O_{CaCO3,VSMOW} = \delta'^{17}O_{CaCO3,VSMOW} -
\lambda \times \delta'^{18}O_{CaCO3,VSMOW} }

\code{"Wostbrock20"}: Wostbrock et al. (2020):

\deqn{\theta_{aragonite/water} = \frac{-1.53}{T} + 0.5305}

\deqn{\theta_{calcite/water} = \frac{-1.39}{T} + 0.5305}

\code{"GZ19"}: Guo and Zhou (2019):

\deqn{\theta_{aragonite/water} = \frac{78.1173}{T^{2}} - \frac{1.5152}{T} + 0.5299}

\deqn{\theta_{calcite/water} = \frac{59.1047}{T^{2}} - \frac{1.4089}{T} + 0.5297}
}
\examples{
d17O_c(temp = 10, d18O_H2O_VSMOW = -1) # Returns the data frame (length = 3)
prime(d17O_c(temp = 10, d18O_H2O_VSMOW = -1)[, 2]) # Returns the d'17O value
d17O_c(temp = 10, d18O_H2O_VSMOW = -1)[, 3] # Returns the D17O value

}
\references{
Wostbrock, J.A.G., Brand, U., Coplen, T.B., Swart, P.K.,
Carlson, S.J., Brearley, A.J., and Sharp, Z.D. (2020).
Calibration of carbonate-water triple oxygen isotope fractionation:
Seeing through diagenesis in ancient carbonates.
Geochimica et Cosmochimica Acta, 288, 369-388.
\doi{10.1016/j.gca.2020.07.045}

Guo, W., and Zhou, C. (2019).
Triple oxygen isotope fractionation in the DIC-H2O-CO2 system:
A numerical framework and its implications.
Geochimica et Cosmochimica Acta, 246, 541-564.
\doi{10.1016/j.gca.2018.11.018}
}
\seealso{
Other equilibrium_carbonate: 
\code{\link{D47}()},
\code{\link{D48}()},
\code{\link{d18O_c}()}
}
\concept{equilibrium_carbonate}
