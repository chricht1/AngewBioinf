library(tximport)
library(DESeq2)
library(dplyr)
library(pheatmap)
library(ggVennDiagram)
library(ggplot2)

setwd("/home/chr/Uni/Master/6.Semester/AngewBioinf/Serien/S4/A4")

accessions <- c("SRR1952778",
                "SRR1952779",
                "SRR1952780",
                "SRR1952793",
                "SRR1952794",
                "SRR1952795",
                "SRR1952808",
                "SRR1952809",
                "SRR1952810")

tsvPaths <- as.vector(sapply(accessions, function(acc){
  paste0("kallisto/",acc,"/abundance.tsv")
}))

txi <- tximport(tsvPaths, type="kallisto",
                txOut=TRUE)

sampleTable <- read.csv("sample_table.tsv", sep = "\t")
dds <- DESeqDataSetFromTximport(txi = txi,
                                colData = sampleTable, 
                                design = ~ condition)

# tell DESeq2 what is control condition
dds$condition <- relevel(dds$condition, ref="Mock")

# fit the DESeq2 model
dds <- DESeq(dds)

#(a)
blsVsMock <- as.data.frame(results(dds, name=resultsNames(dds)[2]))

rsVsMock <- as.data.frame(results(dds, name=resultsNames(dds)[3]))

getDEGsAndHeatmap <- function(df, cols){
  df_filt <- df |> filter(padj < 0.01 & !is.na(padj) & log2FoldChange > 4)
  DEGs <- rownames(df_filt)
  
  norm<-counts(dds,normalized=TRUE)
  colnames(norm) <- paste(accessions, sampleTable$condition)
  normDEGCounts <- norm[DEGs,]
  #op <- par(no.readonly = TRUE)
  #par(mar = c(8, 4, 4, 2) + 0.1)   # bottom, left, top, right
  #par(mai = c(1.2, 0.8, 0.6, 0.6)) 
  heatmap(
    normDEGCounts[,cols],
    main = "DEG Expression Profile",
    #xlab = "Experiment",
    ylab = "Differentially Expressed Genes",
    labRow = NA, # hide row names
    Rowv = NA, # suppresses row dendrogram
    cex.main = 0.85,
    #labCol=NA
  )
  #par(op)
  # axis(1, at=seq(0.5,8.5,1), colnames(norm), cex=0.5, las=2)
}

getDEGsAndHeatmap(blsVsMock, c(1:3,7:9))
getDEGsAndHeatmap(rsVsMock, c(4:9))

# Auswertung:
# Man sieht, dass bei den interessanten Differenziell Exprimierten Genen (DEGs), 
# deutliche Unterschiede in den Expressionswerten zwischen den 3 Bedingungen
# vorherrschen. 
# Man sieht, dass bestimmte Gene der behandelten Bedingungen 
# gegenüber der Kontrollbedingung in ihrer Expression hoch- oder herunterreguliert sind.
# Diese Gene unterscheiden sich zwischen den behandelten Bedingungen.
# Dabei ist die Differenzielle Expression bei der Bedinung BLS256 deutlich stärker als 
# der Bedingung RS105.
# Auch innerhalb der behandelten Bedinungen zeigen sich unterschiedliche DEGs.

# Das Clustering zeigt hauptsächlich auch diese Beobachtungen anhand der Ähnlichkeiten.
# Allerdings ordnet es das erste Replikat von RS105 anhand der Ähnlichkeit
# eher zur Kontrollgruppe als zu seiner Gruppe zu, allerdings ist die Distanz
# zu seiner Gruppe fast gleich.


getVennSets <- function(res, condName){
  degs.up <- rownames( res[!is.na(res$padj) & res$log2FoldChange>4,] )
  degs.down <- rownames( res[!is.na(res$padj) & res$log2FoldChange<(-4),] )
  
  degs.list <- list(c(degs.up,degs.down))
  names(degs.list) <- c(condName)
  return(degs.list)
}
  
blsVsMock.degs <- getVennSets(blsVsMock, "blsVsMock")

rsVsMock.degs <- getVennSets(rsVsMock, "rsVsMock")

ggVennDiagram(c(blsVsMock.degs, rsVsMock.degs)) +
  coord_cartesian(clip = "off") +
  labs(
    title = "Venn Diagam of DEG Sets of two Infected vs Control Comparisons",
  ) +
  theme(
    plot.margin = margin(t = 10, r = 10, b = 10, l = 30)
  )

# Auswertung:
# Man sieht, dass die DEGs der BLS256 gegenüber KG und RS105 gegenüber KG einige 
# DEGs gemeinsam haben, allerdings gibt es auch große Differenzen.
# RS105 ggü. KG hat nur ca halb so viele DEGs wie der andere Faktor 
# und ein überwiegender Anteil seiner DEGs ist in der Schnittmenge. 
# Umgekehrt sieht es bei BLS256 ggü. KG aus.

# install.packages("UpSetR")
# library(UpSetR)
# upset(fromList(degs.list))