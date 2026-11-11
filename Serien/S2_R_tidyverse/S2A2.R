#2.2a)
pchmap <- 1:3
names(pchmap) <- sp
labs <- c("Sepal Length", "Sepal Width", "Petal Length", "Petal Width")
pairs(iris[,1:4], 
      col=colmap[iris$Species], 
      pch = pchmap[iris$Species], 
      cex = 0.5, # change size of points
      labels=labs, 
      main = "Pairwise comparison of iris-dataset measurements",
      # strangely lengend only gets displayed when plot title is set
      upper.panel = NULL)
# labels are written on the diagonal
legend("right", 
      inset = c(0.05, 0), # rag to the left
      legend=sp, 
      col=colmap[sp], 
      #lty=1, # wenn Linien vor Labels gezeigt werden sollen -> Linientyp
      pch=pchmap[sp],
      bty = "n",
      title="Species")



#(b)
# Bei der Petalen Länge und -Breite sieht man eine positive Korrelation 
# bei den Species Versicolor und Virginica, bei Setosa eigentlich nicht. 
# Bei Virginica ist dieser positive Zusammenhang mehr deutlich als bei der 
# anderen Art.

# Bei Setosa sieht man stattdessen einge gute pos. Korrelation 
# der Sepalen Länge und -Breite, was bei den anderen Species nicht der Fall ist.

# Betrachtet man nur die Längenmaße (Sepale- und Petale-), 
# so sieht man erneut bei Versicolor und Virginica die positive Korrelation und 
# bei Setosa nicht. 