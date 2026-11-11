# VL 3 Plotting in R:

	# high-level -> erzeugen neue Figure/Grafik
	
	# low-level -> erweitern bestehende Figure


means <- colMeans(iris[,1:4])

means <- rep(3,length(means))

# barPlot
# las=2 param achsen beschriftung vertikal schreiben 
# margin


# Wahrscheinlichkeitsverteilungen in R
# d - dichte
# p - wert der cdf

# r - zufälligen Wert aus verteilung ziehen
N <- 10
x <- 0:N
plot(x, dbinom(x, size=N, prob=0.5), xlab="Anzahl pos. Ausgänge", ylab="Whk", ylim=c(0,0.3))
# man muss ylim setzen, da wenn wir weitere points s. u. reinplotten würden 
# ylim nicht angepasst wird
# ggplot kann das 



points(x, dbinom(x, size=N, prob=0.4), col="blue", pch="x")

legend(legend=c("p=0.5", "p=0.4"), col=c("black", "blue"), fill = c("black", "blue"), x="topright")


# Expressionsdaten
# Microarray-Daten
#   Index: ist Sondenset auf Microarray, steht für best. Gen !?
#     - für jedes Gen 

# Problem: zu viele Daten für Visualsisierung (wir plotten keine Verteilung)
#   -> nimm nur erste 10 Gene

# Plot Räder (margin) nach innen/außen setzen
#   mai -> Einheit Inches
#   mar - interne R Einheit



x <- sample(x=6, size=100, replace=TRUE)
hist(x) # Balken-Zentren bei wenigen diskreten Balken nicht gut :(

# Balken-Zentren genau über 1 bis 6 setzen
hist(x, prob=TRUE, breaks=seq(0.5,6.5,1))

# erwartete Häufigk. darüber plotten
points(1:6, rep(1/6,6))




# Density-Plots
# glättet diskrete Werte
# lügt aber Daten hinzu
x <- rgamma(n=1000, shape=2)
hist(x, 100, probability=TRUE)
lines(density(x), col=2)


# ECDF:
# - einfacher vergleich zwischen Verteilungen (fkt. nicht immer)
plot(ecdf(x))


# Boxplots
#   - Werte sortiert u.Quartile (3) dargest., a-Quantil q_a = a% der Daten <= q_a


# Whisker:
# IQR - Abstand 1. 3. Quartil
# upper whisker = min(max(x), Q_3 + 1.5 * IQR)
# lower whisker = max(min(x), Q_1 – 1.5 * IQR) 


# QQ-Plot
# - besserer Vergl. zwischen 2 Verteilungen
# - Quantile gegeneinander plotten

# QQ-Plot Verteilung gegen Normalverteilung
x <- rnorm(1000)
qqnorm(x)
qqline(x) # Winkelhalbierende
# wenn Pkt. ungefähr auf dieser liegen sind Daten NV


# hierarchisches Clustern
# single-linkage (min-Abstand) 
#   Problem: Chanining:
#   


# Abspeichern von Plots:
# 
# -> versch. Dateitypen
# wann sinnvoll: 
# - bei mehreren Plots
# - für automatisiertes Abspeichern

# Devices



# Bemerkungen:
# Vordef. Farben in R 
# - es gibt nur 8 Stück, col=9 ist gleich col=1

# par() - setzt Parameter für alle künftigen Plots



