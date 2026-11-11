
setwd("/home/chr/Uni/Master/6.Semester/AngewBioinf/Serien/S3/")

df <- read.table("Xanthomonas.tsv", header=TRUE)

png("A1distr_hists.png", width=800, height=400) # open file to save plot in

par(mfrow=c(2,3))
par(oma=c(1,1,3,1)) # outer margins (of entire grid plot)
par(mar=c(2,2,2,2)) # inner margins (for every single plot)
for(i in 1:length(colnames(df))){
  x <- df[[colnames(df)[i]]]
  hist(x, breaks=10000, xlab="Expression", 
       ylim=c(0,1.5), # set same ylims for comparison between single plots
       main=colnames(df)[i], prob=TRUE)
  lines(density(x), lwd=1, col=2)
  grid(nx=NA, ny=NULL) # plot lines over plots for different y-axis values
}
# write text into margins at the top (-> side=3)
mtext("Distributions of Gene-Expressions of Experiments", side = 3, line = 1, outer=TRUE)

dev.off() # close file

# Interpretation:
# Betrachtet man die Verteilungen der Expressionswerte 
# in den 6 einzelnen Experimenten mit einer gewissen Unschärfe, 
# so sind sie sich sehr ähnlich.  
# Dies sieht man anhand der Density-Plots.
# In den Histogrammen sieht man allerdings, dass es feinere Unterschiede in den
# Verteilungen gibt.
# Auch zwischen der Kontrollgruppe und der behandelten Gruppe sind kaum Unterschiede 
# zu erkennen.