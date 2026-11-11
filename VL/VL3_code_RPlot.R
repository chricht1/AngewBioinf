

#####################################
## Balkendiagramme
#####################################


# Mittelwerte der Experimente
means <- colMeans(iris[,1:4])
# Farben: gruen fuer Laengen, blau fuer Breiten
cols <- rep(3,length(means))
cols[ grepl( "Width", names(means ) ) ] <- 4
# Barplot
barplot(means, las=2, col=cols)

par(mar=c(6,4,4,2)+0.1)
barplot(means, las=2, col=cols)


#####################################
## Verteilungen
#####################################
N <- 10 # Anzahl Muenzwuerfe
x <- 0:N # moegliche Werte

plot( x, dbinom(x,size=N,prob=0.5), xlab="Anzahl Erfolge", 
      ylab="Wahrscheinlichkeit", ylim=c(0,0.3))

# weitere Wahrscheinlichsfunktionen in selber Graphik
# unterschiedliche Farben, Zeichen
points( x, dbinom(x,size=N,prob=0.4), col="red", pch=4)
points( x, dbinom(x,size=N,prob=0.3), col="blue", pch=20)


# Legende
legend( legend = c("p = 0.5", "p = 0.4", "p = 0.3"),
        col = c("black", "red", "blue"),
        pch = c(1,4,20),
        #lty = 1,
        x = "topright"
)


#####################################
## Histogramm
#####################################

# Wuerfe mit fairem Wuerfel
x <- sample.int(n = 6,size = 100, replace=TRUE)
	
# unguenstige bins
hist(x)
	
# absolutes Histogramm
hist(x,breaks=seq(0.5,6.5,by=1))

# relatives Histogramm = Schaetzwerte fuer Wahrscheinlichkeiten
hist(x,prob=TRUE,breaks=seq(0.5,6.5,by=1))
# theoretische Verteilung dazuplotten
points(1:6, rep(1/6,6))

#####################################
## Density-Plot
#####################################

x<-rgamma(n=1000, shape=2)
hist(x,breaks=100,probability = TRUE)
lines(density(x),col=2,lwd=3)

y<-rgamma(n=1000, shape=3)
plot(density(x))
lines(density(y),col=2)


#####################################
## Empirische Verteilungsfunktion
#####################################

x <- sample.int(n = 6,size = 100, replace=TRUE)
plot( ecdf( x))

plot(ecdf(y))




#####################################
## Anwendung auf Expressionsdaten
#####################################

golub <- read.table( "golub.tsv", sep="\t", header=TRUE, stringsAsFactors=FALSE, quote="" )


hist(golub$ALL)

plot(density(golub$ALL),ylim=c(0,0.7),main="Vergleich")
for(i in 4:40){
	lines(density(golub[[i]]),col=i)
}



#####################################
## Boxplots
#####################################

sample1 <- golub[[3]]
boxplot( sample1)

boxplot(golub[,c(-1,-2)],las=2)


#####################################
## Vergleich von Verteilungen
#####################################

sample2 <- golub[[4]]

plot(ecdf(sample1))
plot(ecdf(sample2))


plot(ecdf(sample1),main="Samples")
lines(ecdf(sample2),col=2)
abline(h=0.8)

#####################################
## qq-Plots
#####################################

# Vergleich der (empirischen) Verteilung von sample1 und sample2
qqplot( sample1, sample2)

# Vergleich der Verteilung von sample1 mit Normalverteilung
qqnorm( sample1)
qqline( sample1,col=2,lwd=3)

# simulierte Normalverteilung
x <- rnorm( 1000)
qqnorm(x)
qqline(x,col=2,lwd=3)




#####################################
## mehrere Plots in eine Grafik
#####################################
gene1 <- as.vector( as.matrix( golub[1,c(-1,-2)]))
gene2 <- as.vector( as.matrix( golub[2,c(-1,-2)]))

par(mfrow=c(2,3))
plot(gene1)
hist(gene1)
boxplot(gene1)
plot(gene2)
hist(gene2)
boxplot(gene2)

par(mfrow=c(1,1))

#####################################
## Clustern mit hclust
#####################################
gmat<-as.matrix(golub[,c(-1,-2)])
d<-dist(t(gmat))
tree<-hclust(d, method="single")
plot(tree)

tree<-hclust(d, method="complete")
plot(tree)

plot(tree)


#####################################
## Ausgabe in Datei
#####################################
# PDF:
# Breite = 3in, Hoehe = 2in
# mehrere Graphiken in eine Datei
pdf( "hist.pdf", width = 5, height = 7, onefile = TRUE)
hist( gene1)
hist( gene2)
dev.off()


png( "hist.png", width = 500, height = 700)
hist( gene1)
dev.off()

