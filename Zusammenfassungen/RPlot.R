# R plotting:
# Base R Grafiken:
# plot erzeugende Fkt./High-Level plotting Fkt. 
# plot(), hist(), boxplot(), barplot() ...

# plot erweiternde Fkt./Low-Level plotting Fkt. 
# lines(), points(), density(), legend()

# Plotten einer Funktion:
f <- function(x){x^2}
x <- seq(-2, 2, 0.2)
plot(x,f(x), type="b", pch="+", xlab="x", ylab="f(x)", xlim=c(-2.5,2.5), 
     main="Function Plot")
# type:
# p - points
# l - line
# b - punkte u. line dazwischen
# ...

# Scatterplot
colmap <- 1:3#c("red", "green", "blue")
sp <- unique(iris$Species)
names(colmap) <- sp
plot(iris$Sepal.Length, iris$Sepal.Width, col=colmap[iris$Species],
     cex=0.8, xlim=c(0.7,7), ylim=c(0,5)) 
# Achtung: Achsenlimits müssen in der Hauptplotfkt. gesetzt werden
# können nicht in Plot-Erweiternden Fkt. gesetzt werden
points(iris$Petal.Length, iris$Petal.Width, col=colmap[iris$Species],
       cex=0.8)
# jeder geplotteter Punkt muss Farbe zugewiesen bekommen




# Barplots
means <- colMeans(iris[,1:4])
barplot(means, las=1, col=c(rep(c(2,3),2)), horiz=FALSE, main="Means iris parameters",
        names=NULL)
# names: Balkenlabels unter Balken (bei horiz=FALSE)
# las: Ausrichtung Achsenbeschriftungen
# 1 - beide horizontal, 4 - beide vertikal
# 2 - nur x vertikal, 3 - y vertikal

# Setzen von Default-Parametern für zukünftige Plots:
# par(col="red")
# par(col="red") setzt die Default Farbe auch für viele andere Elemente
# - wie z. B. plot box  


# Ändern der Plot-Ränder:
# par(mai=c(bottom, left, top, right)) -> Einheit: inches
# oder mar statt mai -> Einheit: Zeilenlänge


# Verteilungen
# Muster von built-in R-Funktionen für Verteilungen
# d<Dist> - Wert pdf
# p<Dist> - Wert cpdf
# r<Dist>(n, ...) - Sampled n Werte von der Verteilung

x_ <- seq(0,10,1)
plot(x_, dbinom(x_, size=10, prob=0.5), ylab="Wahrscheinlichkeit", 
     xlab="Erfolge", ylim=c(-0.05,1))
points(x_, dbinom(x_, size=8, prob=0.3), pch=2)
lines(pbinom(x_, size=8, prob=0.3))

# Histogramme
samp <- sample.int(n=6, replace=TRUE, size=100) # Würfelwürfe mit fairem Würfel
hist(samp, breaks=seq(0.5,6.5,1), probability = TRUE, axes=FALSE)
axis(side=1, at=seq(1,6,1), labels=TRUE)
points(1:6, rep(1/6,6))

# ECDF:
# Vgl. von Vert. 
# - nicht Abh. von Binbreite wie Histogramme
# - Vgl. von Kurven einfacher als Histogramme
# - Vgl. von Quantilen

# Density Plot
lines(density(samp), col=2, lwd=2)
# - Kernel-Dichteschätzung 
# - glättet Histogramm, approximiert kontinuierliche Verteilung des Histogramms
# Vorteile: 
# - visuell ansprechend
# - kann Identifikation d. Vert. vereinfachen durch geglättete Darstellung (Moden identifizieren)
# - keine Abh. von Parametern wie Binbreite
# - besser um untersch. Vert. zu vergleichen
# Probleme:
# - fügt künstliche Daten ein/generiert diese
#   -> Abweichung von realer Verteilung
#   - besonders an Rändern d. Vert.
# - verdeckt möglicherweise feine Peaks im Histogramm
# - für wenige Datenpkt. Dichtevert. sehr abh. von Kernel-Größe
#   - daher besser für große Datensätze 

# Density alleine
plot(density(samp))

x_d <- seq(0,10,0.5)
plot(x_d, pgamma(x_d, shape=2), type='l')
lines(x_d, dgamma(x_d, shape=2), type='l', col=2)


# Quantile:
# alpha-Quant. ist Mittel zw. dem kleinsten u. größten Wert 
# der (aufsteigend) sort. Daten, sodass alpha*100% der sort Daten <= diesem Wert sind 
# z. B. [1,2] oder [1,2,3] 
# Quartile: es gibt 1.-3. in 25% Schritten

# Boxplots
# Whisker zeigen am weitesten entfernt liegende Datenpunkte, 
# die noch <= range*IQR von 1. bzw. 3. Quartil entfernt sind
# range = 1,5 (default)
# IQR = 3. - 1. Quartil
# Ausreißer: alle weiter entfernt liengenden Datenpkt.
boxplot(iris[,1:4])
# - Nutzen: Gegenüberstellung der Streuungen versch. Verteilungen 
#   - auch Zsmf. einer Vert.

# QQ-Plots:
# - Scatterplot der Quantile
# - besserer Vgl. zw. 2 Verteilungen als ECDF
#   - ECDF zeigt zwar auch Quartile (alpha auf y-Achse) an
#   - QQ-Plot direkte Vergleich auf Entfernung zur Winkelhalbierenden Mgl. (einfacher)
# qqnorm(<Samples>) z. B. Vgl. gg. Normalvert.


# Violin-Plot:
# - Gegenüberstellungen von Density Plots von Verteilungen
# - besonders nützl. wenn viele Verteilungen
# Vgl. mit Boxplot:
# - keine Ausreißer bzw. Grenzen u. kann wieder Daten "dazulügen" (weniger genau)

# Hirarch-Clustern:
# UPGMA: iterativ 2 Cluster mit kleinster Distanz verschmolzen
# Experimente Clustern 
#   -> Qualitätskontrolle
#   - Überblick über Ähnlichkeiten Genexpression
# Auswahl zu Fusionierende Cluster
# Single-Linkage: - Kettenartige Cluster
# Complete-Linkage: - Kompakte Runde Cluster
# Average: Mittelweg



# ggplot2
library(ggplot2)
# Achtung Daten müssen Data-Frame/Tibble sein
# Scatterplot
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, colour=Species, shape=Species)) +
  geom_point()

# Histogramm
samp <- data.frame(x=sample.int(n=6, size=100, replace=TRUE))
ggplot(samp, aes(x=x)) +
  geom_histogram(binwidth=1, fill="white", color="black")
# geom_histogram hat spez. Parameter, kommen nicht in aes()

# 2D-Histogram:
# besser als Scatterplot, wenn viele Daten auf 1 Haufen

# Boxplot
# Data-Frame muss in long-Format überführt werden, 
# da aes() nur Angabe 1 Spalte für x u. für y erlaubt
library(tidyr)
iris.l <- iris |> pivot_longer(cols=1:4, names_to="Param", values_to="Value")
ggplot(iris.l, aes(x=Param, y=Value)) +
  geom_boxplot() +
  theme(axis.text.x=element_text(angle=90, vjust=-1))



