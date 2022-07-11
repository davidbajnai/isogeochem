# isogeochem 1.1.0

## Function updates
* a18_c_H2O(temp = 25, min = "dolomite", eq = "Muller19") Can now calculate the dolomite/water 18O/16O fractionation factor.
* a18_CO2acid_c(temp = 25, min = "dolomite") Can now calculate the dolomite/CO2 18O/16O AFF.
* d17O_c(D17O_H2O = 0.025) Can now take into account a non-zero D17O value for the ambient water.
* mix_d17O(step = 20) Now allows to adjust the resolution of the output.

## New functions
* d17O_qz() to calculate equilibrium oxygen isotope values for quartz

## New dataset
* meteoric_waters is a compilation of d17O and d18O values for meteoric waters.

## Misc
* Readme updates
* Vignette updates
* Description updates

# isogeochem 1.0.9

## Misc
* vignette updates

# isogeochem 1.0.8
The first CRAN release

## New functions
* D17O() to calculate triple oxygen isotope value from d18O and d17O values

## Function updates
* plot_york() returns silently

## Misc
* vignettes reset to the user's parameters and options
* updated DOI links
* updated README
* added webpage <https://davidbajnai.github.io/isogeochem/>

# isogeochem 1.0.7

## Function updates
* xDIC() renamed to X_DIC()
* xabs() renamed to X_absorption()
* temp_D47() and temp_D48() both result in a similar data frame (length = 2) if errors are specified

## Misc
* README updates
* Vignette updates
* Installing isogeochem with vignettes now works (#2, @japhir)

# isogeochem 1.0.6

## New functions
* a18_CO2g_H2O()
* a18_CO2aq_H2O()
* a18_CO3_H2O()
* a18_HCO3_H2O()
* a13_CO2g_CO2aq()

## Misc
* Added CodeFactor badge to README
* Adjusted the logo

# isogeochem 1.0.5

* Added the "Anderson21" option to D47() and temp_D47()
* Typo fixes in the manual
* Updated README
* Updated Kim&ONeil vignette
* Improved and increased test coverage

# isogeochem 1.0.4

* Added the new function xabs() to calculate the relative rates of CO2 absorption reactions
* Added the new function epsilon() to calculate isotope fractionation values from fractionation factors
* Updated README
* Improved and increased test coverage

# isogeochem 1.0.3

* Vignettes are now working properly
* temp_D47(), temp_D48(), and temp_d18O() are `optimize`-d
* Added the "Kim07" eq to "aragonite" in a18_c_H2O()
* Added the "vanDijk18" eq to "siderite" in a18_c_H2O()

# isogeochem 1.0.2

* Updated the DESCRIPTION file
* Updated the README file
* Updated the isogeochem_manual.pdf file
* Update to temp_D48() #1: the curve_intersect() part was slimmed down
* Update to temp_D48() #2: temperatures are now calculated with the "Fiebig21" eq
* Typo corrected in a18_H2O_OH(): "Z21-X3LYP" —> "Z20-X3LYP"

# isogeochem 1.0.1

* This is the first stable release of isogeochem.

# isogeochem 0.0.0.9

* This is the first development version of the package.
