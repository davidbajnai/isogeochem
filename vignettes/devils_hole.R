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
  fig.path = "figures/devils_hole-",
  fig.height = 4,
  fig.width = 8,
  dpi = 150,
  out.width = "100%"
)
knitr::opts_knit$set(global.par = TRUE)
r = getOption("repos")
r["CRAN"] = "https://stat.ethz.ch/CRAN/"
options(repos = r)

## ---- include = FALSE---------------------------------------------------------
#> Set new parameters for this vignette.
par(mfrow = c(1, 1), mar = c(4.5, 4.5, 0.3, 0.3))

## -----------------------------------------------------------------------------
if (!require("devtools")) install.packages("devtools")
devtools::install_github("davidbajnai/isogeochem")

## -----------------------------------------------------------------------------
library("isogeochem")

## -----------------------------------------------------------------------------
# D47(CDES90) values of Devils Hole carbonates 
DH_D47     = c(0.573, 0.575, 0.572, 0.581, 0.575, 0.575, 0.570, 0.574, 0.568, 0.575)
DH_D47_err = c(0.003, 0.007, 0.003, 0.005, 0.006, 0.003, 0.005, 0.005, 0.007, 0.005)
DH_D47_age = c(10.70, 36.00, 90.35, 122.75, 180.45, 236.65, 295.15, 355.65, 380.05, 496.65)

## -----------------------------------------------------------------------------
DH_age        = devilshole$age
DH_d18O_VSMOW = devilshole$d18O_VSMOW
DH_d18O_err   = devilshole$d18O_error

## ---- label = "Figure1"-------------------------------------------------------
# Convert d18O VSMOW values to the VPDB scale 
DH_d18O_VPDB = to_VPDB(DH_d18O_VSMOW)

# Calculate the errors
DH_d18O_VPDB_err1 = to_VPDB(DH_d18O_VSMOW + DH_d18O_err)
DH_d18O_VPDB_err2 = to_VPDB(DH_d18O_VSMOW - DH_d18O_err)

# Plot the results
plot(0, type = "l" , las = 1, xaxs = "i", xaxt = "n", 
     ylim = c(-17.5, -14.5),
     xlim = c(0, 570), 
     ylab = expression(delta ^ 18 * "O"[calcite] * " (‰, VPDB)"),
     xlab = "Age (ka)")

# Set up the x axis with ticks and labels
axis(1, at = seq(0, 570, by = 90))
axis(1, at = seq(0, 570, by = 10), labels=NA)

# Add the error interval the plot
polygon(c(DH_age, rev(DH_age)), c(DH_d18O_VPDB_err1, rev(DH_d18O_VPDB_err2)),
        col="wheat", border = NA)

# Add the carbonate d18O VPDB time series to the plot
lines(DH_age, DH_d18O_VPDB, lwd=2, col="gray10")

## ---- label = "Figure2"-------------------------------------------------------
# Convert D47 values into temperatures using the equation in Fiebig et al. (2021)
DH_temp = temp_D47(DH_D47, DH_D47_err, eq = "Fiebig21")
DH_temp_mean = mean(DH_temp$temp)
DH_temp_mean
DH_temp_err  = mean(DH_temp$temp_err)
DH_temp_err

# Plot the results
plot(0, type = "l", las = 1, xaxt = "n", xaxs = "i",
     ylim = c(28, 38),
     xlim = c(0, 570),
     ylab = "Temperature (°C)",
     xlab = "Age (ka)")

# Set up the x axis with ticks and labels
axis(1, at = seq(0, 570, by = 90))
axis(1, at = seq(0, 570, by = 10), labels = NA)

# Add mean error range
rect(0, DH_temp_mean - DH_temp_err,
     570, DH_temp_mean + DH_temp_err,
     col = "wheat", border = NA)

# Add error bars
segments(DH_D47_age, DH_temp$temp - DH_temp$temp_err,
         DH_D47_age, DH_temp$temp + DH_temp$temp_err, col = "gray50")

# Add points
points(DH_D47_age, DH_temp$temp, col = "gray10", pch = 19)

## ---- label = "Figure3"-------------------------------------------------------
# Calculate groundwater d18O values and its error
DH_d18O_gw = d18O_H2O(
  temp = DH_temp_mean,
  d18O_c_VSMOW = DH_d18O_VSMOW,
  min = "calcite",
  eq = "Coplen07")
DH_d18O_gw_err_low = d18O_H2O(
  temp = DH_temp_mean + DH_temp_err,
  d18O_c_VSMOW = DH_d18O_VSMOW - DH_d18O_err,
  min = "calcite",
  eq = "Coplen07")
DH_d18O_gw_err_high = d18O_H2O(
  DH_temp_mean - DH_temp_err,
  DH_d18O_VSMOW + DH_d18O_err,
  min = "calcite",
  eq = "Coplen07")

# Plot the results
plot(0, type = "l", las = 1, xaxt = "n", xaxs = "i",
     ylim = c(-16, -12),
     xlim = c(0, 570),
     ylab = expression(delta ^ 18 * "O"[groundwater] * " (‰, VSMOW)"),
     xlab = "Age (ka)")

# Set up the x axis with ticks and labels
axis(1, at = seq(0, 570, by = 90))
axis(1, at = seq(0, 570, by = 10), labels = NA)

# Add the error interval the plot
polygon(c(DH_age, rev(DH_age)), c(DH_d18O_gw_err_low, rev(DH_d18O_gw_err_high)),
        col = "wheat", border = NA)

# Add the carbonate d18O time series to the plot
lines(DH_age, DH_d18O_gw, lwd = 2, col = "gray10")

## ---- include = FALSE---------------------------------------------------------
#> Reset to the user's options and parameters.
par(oldpar)
options(oldopt)

