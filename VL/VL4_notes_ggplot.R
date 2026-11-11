# gehört zu tidyverse

# ggplot() erzeugt leeres Diagram (Grundplot)
# 1. Argument ist Dataframe (muss nicht tibble sein)
# 2. Arg.: aes() Spalten (=Variablen des DFs) des Dataframes mit Plot-Eig. verbinden
# - x,y 
# - color
# - spez. für geom_* Fkt.
  # z. B. Punktgröße 

# Legenden automat. erzeugt

library(ggplot2)

makePlot <- function(){
  p <- ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point() +
  theme_minimal()
  #print(p)
}
p <- makePlot()
print(p)


# standard R barplot ist geom_col() bei ggplot2

# man kann ggplot Objekt Variable nach definiton durch + erweitern



p0 <- ggplot(iris, aes(x=Sepal.Length, y=Petal.Width))
p0 <- p0 + geom_point(aes(shape=Species, color=Petal.Length))
p0 + geom_line()
# wir können das nehmen was Theme kommt als Konstante oder
# was eigenes überlegen
  

# geom bar berechnet automatisch summe!
ggplot(iris, aes(x=Species)) +
  geom_bar(aes(weight=Sepal.Length, fill=Species)) +
  ylab("Sum")

library(dplyr)
sepalLengthMeans <- iris |> 
  group_by(Species) |> 
  summarise(Sepal.Length.Mean=sum(Sepal.Length))
 

ggplot(sepalLengthMeans, aes(x=Species, y=Sepal.Length.Mean)) +
  geom_bar() + ylab("Mean")


# Histogramme
x <- data.frame(x=sample.int(n=6, size=1000, replace=TRUE))

# bins zu schmal
# ggplot(x, aes(x=x)) + geom_histogram()

# color: ist Rahmenfarbe der bins, deutl. besserer Kontrast!
# fill: noch besserer Kontrast durch weiße Füllung der Bars!
# das sollte der default sein
ggplot(x, aes(x=x)) + 
  geom_histogram(binwidth=0.5, color="black", fill="white")


# relatives Histogramm:
# after_stat()
ggplot(x, aes(x=x, y=after_stat(density))) + 
  geom_histogram(binwidth=1, color="black", fill="white")

# mehrere Plots mit ggplot:
# gridExtra Paket
# grid.arrange(p1, p2, ..., nrow=n)
# mit cowplot paket noch schönere grid plots erstellen


#Boxplots:
x1 <- rbinom(n=100, size=100, prob=0.5)
x2 <- rbinom(n=100, size=100, prob=0.6)
x3 <- rbinom(n=100, size=200, prob=0.5)
df <- data.frame(x1=x1, x2=x2, x3=x3)
boxplot(df) # with base R

# ggplot prefers tidy data:
# each column is a variable
library(tidyr)
library(dplyr)
df_long <- df |> pivot_longer(cols=everything(), names_to="Distribution", values_to="Observation")
ggplot(df_long, aes(x=Dist, y=Observation)) + geom_boxplot()

# if column names are not specified
df_long_def <- df |> pivot_longer(everything())
ggplot(df_long_def, aes(x=name, y=value)) + geom_boxplot()


# Violin-Plots:
# Basis sind Density-Plots um 90 Grad gedreht
# haben selbes Problem wie bei Density Plots (Daten hinzulügen)
# kann man auch mit Quartilen darstellen
# informationsreicher als Boxplots
ggplot(df_long, aes(x=Dist, y=Observation)) + geom_violin(draw_quantiles=c(0.25,0.5,0.75))


# Speichern:
# ggsave(filename, plot=<VariableOfPlotToSave>)

# Scatterplot als PDF abspeichern ist aufwändig,
# da jeder Punkt eigenes PDF-Objekt ist
# Rendering kann stocken
# Speicher?
# -> besser als Bildformat




# generelle Bemerkungen: 
# Hilfe zu R-Fkt. mit ?<fkt.>
