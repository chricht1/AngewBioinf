library(tidyr)
library(ggplot2)
library(dplyr)
library(stringr)

setwd("/home/chr/Uni/Master/6.Semester/AngewBioinf/Serien/S3/")

df <- read.table("Xanthomonas.tsv", header=TRUE)
df <- as_tibble(df)

# specify colnames with colnames(df) doesn't work
# -> use pick()
df <- df |> mutate(infMeanExpr=rowMeans(pick(1:3))) |> 
  mutate(ctrlMeanExpr=rowMeans(pick(4:6))) |>
  mutate(logFC=infMeanExpr-ctrlMeanExpr) 
# higher expressed genes in inf Group should have positive log-FC

dfTop <- df |> arrange(desc(logFC)) |> top_n(5)

dfTopL <- dfTop |>
  pivot_longer(1:6, names_to="Exp", values_to="LogExpr")


dfTopL <- dfTopL |>
  mutate(Gene=rep(1:5,each=6)) #add column to identify each Gene

  
theme_set(theme_bw())

ggplot(
  dfTopL,
  aes(
    x = Exp,
    y = LogExpr,
    colour = factor(Gene)
  )
) +
  geom_line(aes(group=Gene, color=factor(Gene))) +
  geom_point(size = 3) +
  scale_colour_manual(
    values = c("red","blue","green","gray","violet")) +
  labs(
    colour = "Gene",
    x = "Experiment",
    y = "LogExpr"
  )

ggsave("A4topDEGenes.png")

# Interpretation:
# Man kann sehr deutlich erkennen, dass die Expressionswerte
# der Gene mit dem größten positiven Log-Fold-Change bei den nicht-infizierten
# Pflanzen in den Replikaten deutliche niedrigere Expressionswerte haben,
# als in den infizierten Replikaten. 
# Bei manchen Genen schwanken die Expressionswerte etwas zwischen den Replikaten,
# diese ist aber verhältnismäßig klein zur Änderung bei Infektion.