# (a)

library(tximport)
library(DESeq2)

setwd("/home/chr/Uni/Master/6.Semester/AngewBioinf/Serien/S4/A3")

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

# (b)
# normalize counts
dds <- DESeq(dds)
norm<-counts(dds,normalized=TRUE)

# calc logarithm of counts
log.norm <- log(norm+1) # log.norm is a matrix


# (c)
# create plots
library(ggplot2)
library(tidyr)
library(dplyr)

colnames(log.norm) <- sampleTable$experiment

log_df <- as.data.frame(log.norm)
log_df$gene <- rownames(log_df) # create new gene column of rownames
# because we want to keep the gene column in the long df
# because the long df has a new index as rownames (obviously)

long_df <- log_df %>%
  pivot_longer(
    cols = -gene, # tidy-select syntax for all columns but column gene
                  # because that column doesn't contains values
    names_to = "experiment", 
    values_to = "log_count"
  )

# add a column with experiment condition
long_df <- left_join(long_df, sampleTable, by = "experiment")


# Boxplot
ggplot(long_df, aes(x = experiment, y = log_count, fill = condition)) +
  geom_boxplot(alpha = 0.8, outlier.size = 0.5, outlier.alpha = 0.3) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    legend.position = "right"
  ) +
  labs(
    title = "Distribution of Log-Normalized Counts per Sample",
    x = "Sample (Experiment)",
    y = "log(Normalized Counts + 1)",
    fill = "Condition"
  )

# Auswertung: 
# Die Boxplots zeigen innerhalb der Bedingungen, 
# als auch zwischen ihnen kaum Abweichungen, 
# die Quartile sind alle so gut wie gleich, 
# im Median kann man sehr leichte Differenzen erkennen.


# Density Plot
ggplot(long_df, aes(x = log_count, color = experiment)) +
  geom_density(alpha = 0.1, linewidth = 0.8) +
  theme_minimal() +
  labs(
    title = "Density of Log-Normalized Counts",
    x = "log(Normalized Counts + 1)",
    y = "Density",
    color = "Experiment"
  )

# Auswertung: 
# Man sieht auch wieder wie in den Boxplots kaum Abweichungen.
# nur das 8. Experiment SRR1952809 der Kontrollbedingung 
# weist bei Genen mit mittelhohem Counts in einem bestimmten kleineren Intervall
# deutlich weniger Werte auf.

# Generell sieht man, dass niedrige Counts sehr häufig vertreten sind, 
# dann nimmt die Zahl sehr schnell ab, erreicht aber bei hohen Expressionswerten 
# wieder ein lokales Maximum.
# Danach sinken die Counts wieder schnell ab.


# (d)
# compare expressions per gene

d <- dist(t(log.norm)) # we need to transpose to compute distances between experiments
clust <- hclust(d, method = "complete")
plot(clust,
     main = "Hierarchical Clustering of Gene-Expression-Distances between Experiments",
     xlab = "Experiments", 
     ylab = "Distance")

clust <- hclust(d, method = "average")
plot(clust,
     main = "Hierarchical Clustering of Gene-Expression-Distances between Experiments",
     xlab = "Experiments", 
     ylab = "Distance")

# Auswertung: 
# Das hierarchische Clustering mit Average- und Complete-Linkage zeigt, 
# dass die Expressionswerte zwischen den Replikaten 
# jeweils einer Bedingung ähnlicher sind, als zwischen den Bedingungen.
# Dies ist zu erwarten. 
# Darüber hinaus sieht man, dass die Expressionswerte bei den behandelten
# Pflanzen deutlich ähnlicher sind, als die behandelten Gruppen zur Kontroll-Gruppe.

# Es ist ungewöhnlich, dass die ersten beiden BLS256 Experimente 
# (Accessions: SRR195277(8/9)) eine Distanz von 0 haben.


set.seed(42)

# Randomly sample 5,000 genes (or the maximum number of rows if you have fewer)
subset_idx <- sample(1:nrow(log.norm), min(15000, nrow(log.norm)))
log_norm_subset <- log.norm[subset_idx, ]

# Generate the pairs plot
pairs(log.norm,#log_norm_subset, 
      pch = 20,                                # Use solid dots
      col = rgb(0.1, 0.3, 0.5, alpha = 0.15),  # Transparent blue for overlapping density
      cex = 0.5,                               # Smaller point size
      main = "Pairwise Scatter Plots (Subset of 15,000 Transcripts)",
      upper.panel = NULL)

# Auswertung:
# Man sieht generell, dass es größere Unterschiede zwischen den 
# behandelten Gruppen und der Kontrollgruppe gibt, als 
# innerhalb einer Gruppe oder zwischen den behandelten Gruppen.
# In allen Plots sieht man generell, 
# dass grundsätzlich die meisten Gene wahrscheinlich ähnlich stark exprimiert sind.
# Es gibt aber auch in jedem Vergleich auch eine gewisse Menge an Genen, 
# die in einem Experiment eher gering exprimiert sind und im anderen Experiment
# nicht exprimiert sind.

# Vergleicht man die Kontrollgruppe mit den behandelten Gruppen 
# so kann man erkennen, dass sind eine große Zahl an Genen in ersterer Bedingung
# niedriger exprimiert ist, als in den letzteren.

plotScatter <- function(exp1Idx, exp2Idx){
  p <- ggplot(log_df) +
    geom_point(aes(x = .data[[names(log_df)[exp1Idx]]],
                   y = .data[[names(log_df)[exp2Idx]]]),
               size=1) +
    geom_abline(slope = 1, intercept = 0, color = "red") +
    theme_minimal() +
    labs(
      title = "Scatterplot between log(Normalized Counts + 1) of 2 Experiments",
      x = paste(colnames(log_df)[exp1Idx], sampleTable$condition[exp1Idx]),
      y = paste(colnames(log_df)[exp2Idx], sampleTable$condition[exp2Idx])
    )
  print(p)
}

plotScatter(1,4)
plotScatter(1,7)
plotScatter(4,7)

# Auswertung:
# In den detaillierteren Plots ist zu erkennen, 
# dass niedrige Expressionswerten von Genen, 
#  diese für das jeweilige Experiment nur in bestimmten Intervallen auftreten, 
# ab einem bestimmten Expressionsniveau scheinen die Werte dann beliebig zustreuen. 