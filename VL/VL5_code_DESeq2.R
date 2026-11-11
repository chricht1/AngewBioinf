library(DESeq2)
library(ggplot2)
library(tidyr)
library(tibble)
library(dplyr)

#########################
## Beispiel-Daten laden
#########################

library(airway)
data(airway)

# Anschauen
airway
colData(airway)

# bauen ein DESeqDataSet
dds <- DESeqDataSet(airway, design = ~ cell + dex)

# wieviele Reads pro Experiment?
colSums(counts(dds))


#########################
## Density-Plot
#########################

# fuer ggplot
tbl<-as_tibble(counts(dds),rownames="Gene") %>% pivot_longer(names_to = "Experiment",values_to="Count",-Gene)
# wie unterscheidet sich die Verteilung der Zaehlwerte
ggplot( tbl, aes(x=Count,colour=Experiment) ) + geom_density()
# -> nicht viel zu sehen
# logarithmiert
ggplot( tbl, aes(x=log(Count+1),colour=Experiment) ) + geom_density()
# etwas besser...


#########################
## Normalisierung
#########################
# Welche Stufe ist Kontrolle?
dds$dex <- relevel(dds$dex, "untrt")
# Normalisieren
dds <- DESeq(dds)
# normalisierte Counts abfragen
norm<-counts(dds,normalized=TRUE)
# Vergleich mit vorher
colSums(norm)

# "norm" ist eine Matrix;
# wir koennen damit also wie vorher mit den
# Microarray-Daten arbeiten

# hier schauen wir uns logarithmierte Werte an
log.norm <- log(norm+1)

# Scatter-Plot
plot(log.norm[,1],log.norm[,2])

# Histogramm
hist(log.norm[,1])

# density-plot
plot(density(log.norm[,1]))

#qq-Plot
qqplot(log.norm[,1],log.norm[,2])


#########################
## Differentiell exprimierte Gene
#########################

res <- results(dds)
head(res)


#########################
## Volcano-Plot
#########################
res.df<-as.data.frame(res)

res.df <- res.df %>% mutate(colour=padj<0.05) %>% filter(!is.na(padj))

ggplot(res.df, aes(x=log2FoldChange,y=-log10(padj),colour=colour)) + 
  geom_point()



#########################
## Heatmap
#########################

sub.res<-res[!is.na(res$padj) & res$padj<0.05 & res$log2FoldChange>2,]

degs<-rownames(sub.res)

counts<-counts(dds,normalized=TRUE)
counts<-counts[ degs, ]

heatmap(counts)

colnames(counts)<-paste(colData(dds)[colnames(counts),c("dex")],colData(dds)[colnames(counts),c("cell")])

heatmap(counts)

pdf("heatmap.pdf",width=20,height=20);
heatmap(counts,margins=c(8,6))
dev.off()


#########################
## rlog-Transformation
#########################

rld <- rlog(dds)

# log+1 vs log+1
plot( log2( 1 + counts(dds, normalized=TRUE)[ , 1:2] ),
	  col=rgb(0,0,0,.2), pch=16, cex=0.3 )

# rlog vs rlog
plot( assay(rld)[ , 1:2],
	  col=rgb(0,0,0,.2), pch=16, cex=0.3 )

# rlog vs log+1
plot(log2( 1 + counts(dds, normalized=TRUE)[ ,1]),
	 assay(rld)[ ,1], xlab="log2",ylab="rlog",
	 col=rgb(0,0,0,.2), pch=16, cex=0.3 )


vsd<-vst(dds)


# vst vs log+1
plot(log2( 1 + counts(dds, normalized=TRUE)[ ,1]),
     assay(vsd)[ ,1], xlab="log2",ylab="rlog",
     col=rgb(0,0,0,.2), pch=16, cex=0.3 )

# rlog vs vst
plot(assay(vsd)[,1],
     assay(rld)[ ,1], xlab="vst",ylab="rlog",
     col=rgb(0,0,0,.2), pch=16, cex=0.3 )



# auch hier bekommen wir wieder eine Matrix:
rlog.counts <- assay(rld)
# Zeilen fuer DEGs
rlog.counts <- rlog.counts[degs,]

# auch damit koennen wir eine heatmap plotten
heatmap(rlog.counts,margins=c(8,6))


#########################
## Venn-Diagramm
#########################

# install.packages("ggVennDiagram")
library(ggVennDiagram)

degs.pval <- rownames( res[!is.na(res$padj) & res$padj<0.01,] )
degs.up <- rownames( res[!is.na(res$padj) & res$log2FoldChange>1,] )
degs.down <- rownames( res[!is.na(res$padj) & res$log2FoldChange<(-1),] )
degs.list <- list("pval"=degs.pval,"up"=degs.up,"down"=degs.down)

ggVennDiagram(degs.list)

#########################
## Upset-Plot
#########################

# install.packages("UpSetR")
library(UpSetR)
upset(fromList(degs.list))


