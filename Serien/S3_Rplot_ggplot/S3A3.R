library(tidyr)
library(ggplot2)
library(gridExtra)
library(hexbin)
library(ggpubr)

setwd("/home/chr/Uni/Master/6.Semester/AngewBioinf/Serien/S3/")

df <- read.table("Xanthomonas.tsv", header=TRUE)
#df <- as_tibble(df)

ctrl_exps <- colnames(df)[1:3]
inf_exps <- colnames(df)[4:6]

# i like this theme more
# set it as default
theme_set(theme_bw())

makeBin2dPlots <- function(exps1, exps2, countRange, mode, title, dir){
  plots <- list()
  for(i in 1:length(exps1)){
    for(j in 1:length(exps2)){
      legendPos <- "none"
      if(j==2){legendPos <- c(0.5,-0.26)}
      plots[[length(plots)+1]] <- ggplot(df, aes(x=.data[[exps1[i]]], y=.data[[exps2[j]]])) +
        #geom_point(size=0.5) +
        geom_hex(bins=100) +
        # set single colormapping range for comparison
        scale_fill_viridis_c(limits=countRange) + 
        theme(legend.position=legendPos,
              legend.direction = "horizontal",
              axis.text=element_text(size=8),
              axis.title=element_text(size=8))
    }
  }
  # plot rows respectively together in one figure
  range <- 2:3  # because of duplications we only need to plot all three rows for 
                # infVsCtrl
  if(mode=="infVsCtrl"){range <- 1:3}
  for(i in range){
    fig <- ggarrange(plotlist=plots[((i-1)*3+1):(i*3)], nrow=1, ncol=3) +
      ggtitle(title) + 
      theme(plot.margin = margin(0.5,0,1.5,0, "cm"),
            plot.title = element_text(vjust=-0.2, hjust = 0.5))
    print(fig)
    ggsave(paste0(dir, "/pts_", mode, "_", i-1, ".png"))
  } 
}
dir <- "A3Plots"

#Control vs. Infection
title <- "Gene Count Correlation Infected vs Control"
mode <- "infVsCtrl"
countRange <- c(0,260)
makeBin2dPlots(ctrl_exps, inf_exps, countRange, mode, title, dir)

# Interpretation:
# Es werden stets 2D-Histogramme geplottet, da es sehr viele Gene gibt, 
# deren Punkte im Scatter-Plot übereinander liegen.

# Betrachtet man die Plots, welche die Gen-Count-Korrelation zwischen 
# den einzelnen Experimenten der Kontrollgruppe und der Infizierten-Gruppe  
# darstellen, so sieht man zunächst, 
# dass stets der Großteil der Gene in ihren Expressionswerten 
# unverändert oder relativ unverändert bleibt.
# Es gibt allerdings wenige Gene, die entweder in ihrer Expression zwischen
# beiden Bedingungen positiv oder negativ verändert sind.
# Außerdem gilt für alle Plots, je stärker die Veränderung, 
# desto seltener kommt diese vor.

# Variiert man die Kontrollgruppen bei den Genen-Count-Korrelationen, 
# (Spalten einer Zeile) sieht man nur ziemlich wenig Variation 
# wenn man die Gen-Korrelation betrachtet ohne einzelne Gene identifizieren zu können.
# Man sieht also nur dass die grobe Struktur der Korrelation gleich bleibt.

# Betrachtet man die Unterschiede zwischen den Infizierten Gruppen
# Vergleich der Zeilenplots pro best. Spalte, so sieht man eine kontinuierlich
# stärker werdende Streuung der Punkte von Gruppe 1 (PXO99A) bis 3 (PXO99A.2)


#Control vs. Control
title <- "Gene Count Correlation Infected vs Infected"
mode <- "infVsInf"
makeBin2dPlots(ctrl_exps, ctrl_exps, countRange, mode, title, dir)

# Interpretation:
# Zwischen den Infizierten-Gruppen sind die Expressionswerte stärker korelliert als 
# zwischen den Bedinungen, wobei es auch hier wieder einige Gene gibt, 
# die Ausreißer sind. 
# Es fällt außerdem auf, dass PXO99A.1 zu den den mit beiden Replikaten ähnlicher ist,
# als PXO99A mit PXO99A.2.

#Infection vs. Infection
title <- "Gene Count Correlation Control vs Control"
mode <- "ctrlVsCtrl"
makeBin2dPlots(inf_exps, inf_exps, countRange, mode, title, dir)

# Interpretation:
# Es wird zunächst deutlich ersichtlich, dass die Kontrollgruppe Mock und Mock.2
# eine deutlich bessere Korrelation als die beiden anderen Kombinationen der
# KGs hat, dies steht im Kontrast zum beobachteten Effekt bei den infizierten Gruppen.
# Allerdings gibt es die Gemeinsamkeit mit den Infizierten Gruppen, 
# dass wieder die Korrelation bei nicht identifizierbarer Gene von Mock.1 zu den 
# anderen Replikaten deutlich ähnlicher ist, als Mock und Mock.2.

# Die Korrelation ist allgemein besser bei den KGs als bei den Infizierten.   
