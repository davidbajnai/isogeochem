% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{prime}
\alias{prime}
\title{Converting delta to delta prime}
\usage{
prime(classical)
}
\arguments{
\item{classical}{"Classical delta" values to be converted (‰).}
}
\value{
Returns the "delta prime" value (‰).
}
\description{
\code{prime()} converts "classical delta" values to "delta prime" values.
}
\details{
\deqn{\delta'^{17}O = 1000 \times \ln(\frac{\delta^{17}O}{1000}+1)}
}
\examples{
prime(10) # Return 9.950331

}
\seealso{
\code{\link[=unprime]{unprime()}} converts "delta prime" values to
"classical delta" values.
}
