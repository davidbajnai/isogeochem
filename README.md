
# isogeochem: Tools For Carbonate Isotope Geochemistry

**Author:** [David Bajnai](https://www.davidbajnai.eu/)<br/>
**License:** [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/)

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN status](https://www.r-pkg.org/badges/version/isogeochem)](https://CRAN.R-project.org/package=isogeochem)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![R-CMD-check](https://github.com/davidbajnai/isogeochem/workflows/R-CMD-check/badge.svg)](https://github.com/davidbajnai/isogeochem/actions)
<!-- badges: end -->

This package is a collection of functions that makes working with stable oxygen and clumped isotope data easier.

## Installation

You can install the development version from Github with devtools:

``` r
install.packages("devtools")
devtools::install_github("davidbajnai/isogeochem")
```

## Example 1: Triple oxygen isotopes

The `d17O()` and `d18O()` functions calculate equilbrium oxygen isotope values for given temperature and ambient water composition.

``` r
library(isogeochem)
plot(0, type="l", axes=T, ylim=c(-0.15,0.05), xlim=c(-10,40),
     ylab="D17O (per mille, VSMOW)", xlab="d'18O (per mille, VSMOW)", lty=0, font=1, cex.lab=1, las = 1)

# Equilibrium calcite: temperature varies between 0—50°C
temperature = seq(0, 50, 5)
cols = gradient(c("blue","red"), length(temperature))
lines( prime(d17O(temperature,-1)[,1]), d17O(temperature,-1)[,3], col="purple", lwd=2)
points(prime(d17O(temperature,-1)[,1]), d17O(temperature,-1)[,3], pch = 20, col=cols)
points(prime(d17O(10,-1)[,1]), d17O(10,-1)[,3], pch = 19, col="purple")
```

## Example 2: Dual clumped isotope thermometry

The `D47()` and `D48()` functions calculate equilbrium oxygen clumped isotope values for given temperature.

``` r
library(isogeochem)
plot(0, type="l", axes=T, ylim=c(0.4,0.7), xlim=c(0.15,0.3),
     ylab="D47 (per mille,CDES90)", xlab="D48 (per mille, CDES90)", lty=0, font=1, cex.lab=1, las = 1)
lines(D48(seq(0,100,1)),D47(seq(0,100,1)) )

temps=seq(0,100,10)
cols = gradient(c("blue","red"), length(temps))
points(D48(temps),D47(temps),pch=20, col=cols)
text(D48(temps),D47(temps),paste(temps,"°C"),col=cols,pos=2,cex=0.6)
```
