# isogeochem README examples

setwd ("~/Documents/R/isogeochem/tools")

##——————————————————————————————————————————————————————————————————————##

library(isogeochem)
if (!require("shades")) install.packages("shades")

##——————————————————————————————————————————————————————————————————————##

#### Example 1 ####
pdf('README-example1.pdf', 5, 5, encoding = "MacRoman") # plotting starts here
par(mfrow = c(1, 1), mar = c(4.5, 4.5, 0.3, 0.3)) # rows-columns and margins

# <><><><><><><><><>START_CODE_1<><><><><><><><><> #


# Model equilibrium carbonate
temp  = seq(0, 100, 10) # temperature range: 0—100 °C
D47eq = D47c(temp, eq = "Fiebig21") # equilibrium ∆47 values
D48eq = D48c(temp, eq = "Fiebig21") # equilibrium ∆48 values

# Sample data
D47coral  = 0.617; D47coral_err  = 0.006
D48coral  = 0.139; D48coral_err  = 0.022
D47speleo = 0.546; D47speleo_err  = 0.007
D48speleo = 0.277; D48speleo_err  = 0.029

# Plot equilibrium calcite ∆47 vs ∆48
plot(0, type="l", axes=T, ylim=c(0.4,0.7), xlim=c(0.1,0.3),
     ylab=expression(Delta[47]*" (CDES90, ‰)"), xlab=expression(Delta[48]*" (CDES90, ‰)"),
     lty=0, font=1, cex.lab=1, las = 1)

lines (D48eq, D47eq, col="purple", lwd=2) # equilibrium curve
points(D48eq, D47eq, col=shades::gradient(c("blue","red"),length(temp)),
       pch=19, cex=1.2) # equilibrium points

# Add the sample data to the plot,
# ... plot the kinetic slopes,
# ... and calculate growth temperatures corrected for kinetic effects
# ... using a single function!
temp_D48(D47coral, D48coral, D47coral_err, D48coral_err, ks = -0.6,
         add = TRUE, col = "seagreen", pch = 15)
temp_D48(D47speleo, D48speleo, D47speleo_err, D48speleo_err, ks = -1,
         add = TRUE, col = "darkorange", pch = 17)

text(D48c(temp), D47c(temp), paste(temp,"°C"),
     col=shades::gradient(c("blue","red"),length(temp)), pos=4, cex=0.8)


# <><><><><><><><><>END_CODE_1<><><><><><><><><> #

dev.off()

##——————————————————————————————————————————————————————————————————————##
#### Example 2 ####
pdf('README-example2.pdf', 5, 5, encoding = "MacRoman") # plotting starts here
par(mfrow = c(1, 1), mar = c(4.5, 4.5, 0.3, 0.3)) # rows-columns and margins

# <><><><><><><><><>START_CODE_2<><><><><><><><><> #


## Model equilibrium carbonate
temp  = seq(0, 50, 10) # temperature range: 0—50 °C
d18Ow = -1
d18Op = prime(d17Oc(temp, d18Ow, eq18 = "Daeron19")[,1]) # equilibrium d'18O values
D17O  = prime(d17Oc(temp, d18Ow, eq18 = "Daeron19")[,3]) # equilibrium ∆17O values

## Model progressing meteoric diagenetic alteration
em_equi = d17Oc(10, d18Ow, eq18 = "Daeron19") # equilibrium endmember in mixing model
em_diag = d17Oc(25, -10, eq18 = "Daeron19") # diagenetic endmember in mixing model
# Mixing between the endmembers
mix = mix_d17O(d18O_A = em_equi[1], d17O_A = em_equi[2],
               d18O_B = em_diag[1], d17O_B = em_diag[2])

## Plot equilibrium calcite ∆17O vs d'18O
plot(0, type="l", axes=T, ylim=c(-0.1,-0.04), xlim=c(15,40),
     xlab=expression(delta*"'"^18*"O"[c]*" (‰, VSMOW)"), ylab=expression(Delta^17*"O (‰, VSMOW)"),
     lty=0, font=1, cex.lab=1, las = 1)

lines(d18Op, D17O, col="purple", lwd=2) # equilibrium curve
points(d18Op, D17O, col=shades::gradient(c("blue","red"), length(temp)),
       pch=19, cex=1.2) # equilibrium points

lines(prime(mix[,1]), mix[,2], col="tan4", lty=2, lwd=2) # diagenetic curve
points(prime(mix[,1]), mix[,2], col=shades::gradient(c("#3300CC","tan4"),length(seq(0,10,1))),
       pch=18, cex=1.2) # diagenetic points

text(d18Op+0.5, D17O, paste(temp,"°C"), pos=4, cex=1,
     col=shades::gradient(c("blue","red"), length(temp)))
text(prime(mix[,1]), mix[,2], paste(mix[,3],"%"), pos=1, cex=0.5,
     col=shades::gradient(c("#3300CC","tan4"), length(seq(0,10,1))))


# <><><><><><><><><>END_CODE_2<><><><><><><><><> #

dev.off()
setwd("~/Documents/R/isogeochem")
