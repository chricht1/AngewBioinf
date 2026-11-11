golub <- read.table( "golub.tsv", sep="\t", header=TRUE, stringsAsFactors=FALSE, quote="" )


#####################################
## Alle Gene eines Experiments
#####################################

# Expression im ersten Array
sample1 <- golub[[3]]
sample1 
# ... nicht ueberschaubar


plot( sample1)
plot( sample1, type="l")



#####################################
## Nur ein Teil der Gene
#####################################

# immer noch ein bisschen viel:
plot( sample1[1:10])

# welche Gene sind es denn ?
# Achsen und Beschriftung selbst machen
plot( sample1[1:10], xlab="", ylab="expression", axes=FALSE)
axis( side=1, at=1:10, labels = golub[1:10,1])
axis( side=2, at=-2:3, labels=TRUE)


#####################################
## Beschriftungen und Raender schoener
#####################################


# Text drehen (las=)
plot( sample1[1:10], xlab="", ylab="expression", axes=FALSE)
axis( side=1, at=1:10, labels = golub[1:10,1], las=2)
axis( side=2, at=-2:3, labels=TRUE)
# wo sind die Gen-IDs geblieben??
	
# --> kein Platz nach unten
oldmai <- par("mai")
par( mai=c(3,1,0.5,0.5) )

# erneut plotten (s.o.)
plot( sample1[1:10], xlab="", ylab="expression", axes=FALSE)
axis( side=1, at=1:10, labels = golub[1:10,1], las=2)
axis( side=2, at=-2:3, labels=TRUE)

par( mai=oldmai )
