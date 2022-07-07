## ---- include = FALSE---------------------------------------------------------
#> Save the user's options and parameters
oldopt = options()
oldpar = par()

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
  eval = TRUE,
  fig.path = "figures/kim_oneil_1997-",
  fig.height = 5,
  fig.width = 5,
  dpi = 150,
  out.width = "55%"
)
knitr::opts_knit$set(global.par = TRUE)
r = getOption("repos")
r["CRAN"] = "https://stat.ethz.ch/CRAN/"
options(repos = r)

## ---- include = FALSE---------------------------------------------------------
#> Set new parameters for this vignette.
par(mfrow = c(1, 1), mar = c(4.5, 4.5, 0.3, 0.3))

## ---- include = TRUE, message = FALSE, eval = TRUE----------------------------
install.packages("isogeochem")
library("isogeochem")

## ---- include = TRUE, message = FALSE, eval = TRUE----------------------------
TinC = c(10, 10, 25, 25, 25, 25, 40, 40, 40)
TinK = 1000 / (TinC + 273.15)
d18O_H2O = c(-8.12, -8.23, -8.30, -8.25, -8.12, -8.23, -8.20, -8.12, -8.23)
d18O_calcite = c(23.47, 23.21, 19.73, 20.23, 20.00, 20.03, 17.06, 17.24, 17.01)

## ---- include = TRUE, message = FALSE, eval = TRUE----------------------------
# Calculate the fractionation factor between calcite and water
a18_calcite_H2O = a_A_B(A = d18O_calcite, B = d18O_H2O)

# Calculate the 1000ln alpha values, abbreviated here as "elena"
# Kim and O'Neil (1997) used values rounded to two decimals
elena_orig = round(1000 * log(a18_calcite_H2O), 2)

# Fit a linear regression on the values
lm_orig = lm(elena_orig ~ TinK)
slope_orig = round(as.numeric(coef(lm_orig)["TinK"]), 2)
intercept_orig = round(as.numeric(coef(lm_orig)["(Intercept)"]), 2)

# The original equation:
slope_orig
intercept_orig

## -----------------------------------------------------------------------------
# Convert d18O_calcite to d18O_CO2acid using the "old" AFF
d18O_CO2acid = A_from_a(a = 1.01050, B = d18O_calcite)

# Convert d18O_CO2acid to d18O_calcite using the "new" AFF
AFF_new = a18_CO2acid_c(25, "calcite")
d18O_calcite_newAFF = B_from_a(a = AFF_new, d18O_CO2acid)

## -----------------------------------------------------------------------------
# Calculate the new alpha and 1000ln alpha values
a18_calcite_H2O_new = a_A_B(A = d18O_calcite_newAFF, B = d18O_H2O)
elena_new = 1000 * log(a18_calcite_H2O_new)

# Calculate new slope and intercept
lm_new = lm(elena_new ~ TinK)
slope_new = round(as.numeric(coef(lm_new)["TinK"]), 2)
intercept_new = round(as.numeric(coef(lm_new)["(Intercept)"]), 2)
slope_new
intercept_new

## ---- label = "Figure1"-------------------------------------------------------
if (!require("viridisLite")) install.packages("viridisLite")

plot(0, type = "l", las = 1,
     ylim = c(28, 33),
     xlim = c(10, 30),
     ylab = expression("1000 ln " * alpha[calcite / water] ^ 18 * " (‰)"),
     xlab = "Temperature (°C)")

temp = seq(10, 30, 1)
cols = viridisLite::viridis(6, option = "D")

lines(temp, 1000 * log(a18_c_H2O(temp, "calcite", "Daeron19")),
      col = cols[1], lwd = 2)
lines(temp, 1000 * log(a18_c_H2O(temp, "calcite", "Watkins13")),
      col = cols[2], lwd = 2)
lines(temp, 1000 * log(a18_c_H2O(temp, "calcite", "Tremaine11")),
      col = cols[3], lwd = 2)
lines(temp, 1000 * log(a18_c_H2O(temp, "calcite", "ONeil69")),
      col = cols[4], lwd = 2)
lines(temp, 1000 * log(a18_c_H2O(temp, "calcite", "KO97")),
      col = cols[5], lwd = 2)
lines(temp, 1000 * log(a18_c_H2O(temp, "calcite", "KO97-orig")),
      col = cols[6], lwd = 2, lty = 2)

legend("topright", bty = "n", adj = c(0, NA),
       lty = c(1, 1, 1, 1, 1, 3),
       lwd = c(2, 2, 2, 2, 3, 3),
       col = cols,
       legend = c("Daeron19",
                  "Watkins13",
                  "Tremaine11",
                  "ONeil69",
                  "KO97",
                  "KO97-orig"))

## ---- include = FALSE---------------------------------------------------------
#> Reset to the user's options and parameters.
par(oldpar)
options(oldopt)

