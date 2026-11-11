library(tidyr)
library(ggplot2)

setwd("/home/chr/Uni/Master/6.Semester/AngewBioinf/Serien/S3/")

df <- read.table("Xanthomonas.tsv", header=TRUE)
df_td <- df |> pivot_longer(cols=everything(), names_to="Experiment", values_to="Expression")


ggplot(df_td, aes(x=Experiment, y=Expression)) +
  geom_boxplot() + 
  ggtitle("Comparison of expression distributions of experiments") +
  theme(plot.title = element_text(hjust = 0.5))
  
ggsave("A2dist_box.png")

ggplot(df_td, aes(x=Experiment, y=Expression)) +
  geom_violin(draw_quantiles = c(0.25,0.5,0.75)) +
  ggtitle("Comparison of expression distributions of experiments") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("A2dist_violin.png")

# Interpretation:
# Die Box- und Violin-Plots zeigen ein sehr ähnliches Bild wie die Plots aus Aufgabe 1.
# Bei den Boxplots weichen die Quartile zwischen den Experimenten so gut wie nicht ab und 
# die Länge der Whisker ebenfalls.
# An den Violin-Plots sieht man, wie nach Aufgabe 1 zu erwarten, kaum Unterschiede.