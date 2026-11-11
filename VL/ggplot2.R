library(ggplot2)


ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, colour=Species)) +
  geom_point()


#####################################
## Themes
#####################################

po <- ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
	geom_point() +
	theme_classic()
po
po + theme_dark()



#####################################
## Scatterplot
#####################################
# Grundplot mit Definition von x, y
po <- ggplot(iris, aes(x=Sepal.Length, y=Petal.Length))

# Species als Farben
po + geom_point(aes(colour=Species))
# Species als Symbole
po + geom_point(aes(shape=Species))
# Weitere Variable auf Punktgroesse
po + geom_point(aes(colour=Species, size=Petal.Width))


#####################################
## Balkendiagramm
#####################################

library(dplyr)
df <- iris %>% group_by(Species) %>% summarise(Mean.Sepal.Length=mean(Sepal.Length))
# geht auch mit tibbles
ggplot(df,aes(x=Species,y=Mean.Sepal.Length)) + 
	geom_col(aes(fill=Species))

ggplot(iris,aes(x=Species)) +
	geom_bar(aes(weight=Sepal.Length/50, fill=Species)) + ylab("Mean")



#####################################
## Histogramm
#####################################

x <- data.frame( x=sample.int(n = 6,size = 100, replace=TRUE) )

# zu viele/schmale Bins:
ggplot(x, aes(x=x)) + geom_histogram()
# besser:
ggplot(x, aes(x=x)) + geom_histogram(binwidth=1, fill="white", color="black")

# absolutes Histogramm expliziter:
ggplot(x,aes(x=x,y=after_stat(count))) + geom_histogram(binwidth=1,fill="white",color="black")
# relatives Histogramm:
ggplot(x,aes(x=x,y=after_stat(density))) + geom_histogram(binwidth=1,fill="white",color="black")


#####################################
## 2D-Histogramm
#####################################
golub <- read.table( "golub.tsv", sep="\t", header=TRUE, stringsAsFactors=FALSE, quote="" )

ggplot(golub, aes(x=ALL,y=ALL.1)) + geom_bin2d() + scale_fill_viridis_c(trans="log")

# sechseckige Bins, logarithmische Farben
#install.packages("hexbin")
ggplot(golub, aes(x=ALL,y=ALL.1)) + geom_hex() + scale_fill_viridis_c(trans="log")

ggplot(golub, aes(x=ALL,y=ALL.1)) + 
  geom_hex() + 
  scale_fill_viridis_c(trans="log") + 
  geom_abline(colour="red",linewidth=3,alpha=0.5, slope=1,intercept=0)

#####################################
## mehrere Plots
#####################################

# 1D-Histogramme
h1 <- ggplot(golub, aes(x=ALL)) + geom_histogram(binwidth=0.2)
h2 <- ggplot(golub, aes(x=ALL.1)) + geom_histogram(binwidth=0.2)
# 2D-Hexbin
p <- ggplot(golub, aes(x=ALL,y=ALL.1)) + 
	geom_hex() + scale_fill_viridis_c(trans="log") + 
	geom_abline(colour="red",linewidth=3,alpha=0.5, slope=1,intercept=0)


#install.packages("gridExtra")
library(gridExtra)
grid.arrange(h1, h2, p, nrow=2)
# schoener:
grid.arrange(
  h2+ coord_flip() + scale_y_reverse(),  
  h1, p, 
  layout_matrix = matrix( c(1,NA,3,2), nrow=2 ), heights=c(3,1), widths=c(1,3))


golub <- read.table( "golub.tsv", sep="\t", header=TRUE, stringsAsFactors=FALSE, quote="" )


#####################################
## Boxplot
#####################################
library(tidyr)
# fuer alle Gene/Experimente
golub.tidy <- golub %>% pivot_longer(names_to="Experiment", values_to="Expression", 3:40)

ggplot(golub.tidy, aes(x=Experiment,y=Expression)) + geom_boxplot()
# => Beschriftung der x-Achse nicht lesbar
# Loesung ueber theme
ggplot(golub.tidy, aes(x=Experiment,y=Expression)) + geom_boxplot() + theme(axis.text.x = element_text(angle = 90, hjust = 1))


#####################################
## Violin-Plot
#####################################

# Standard Violin-Plot
ggplot(golub.tidy, aes(x=Experiment,y=Expression)) + geom_violin()

# Achsenbeschriftung anpassen + Quartile aus Boxplot einzeichnen
ggplot(golub.tidy, aes(x=Experiment,y=Expression)) + geom_violin(draw_quantiles=c(0.25,0.5,0.75)) + theme(axis.text.x = element_text(angle = 90, hjust = 1))



#####################################
## Plots speichern
#####################################

# Letzten Plot speichern
ggsave("plot.pdf", width=20, height=5)

# Plot-Objekt aus Variable speichern
myplot <- ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) + geom_point()
ggsave("plot.png", plot=myplot, width=5, height=5)

