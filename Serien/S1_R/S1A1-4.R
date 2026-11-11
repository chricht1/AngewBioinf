#1.1a) Folge von 113 bis -12
113:-12

#b.) dasselbe, aber in 3er-Schritten
seq(113,-12,3)

#c.) abwechselnd die Werte TRUE und FALSE, insgesamt 112 Werte
rep(c(TRUE,FALSE),126/2)

#d.) 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5 6 6 6 7 7 7
rep(1:7,each=3)

# Achtung times ist default argument
# rep(1:3,2) # [1] 1 2 3 1 2 3
rep(1:3,times=c(3,2,2))
# [1] 1 1 1 2 2 3 3


#1.2
dist <- runif(10, 0, 1)# runif(n, min, max)
#a) erste fünf Einträge 
dist[1:5]
dist[-6:-10]
#b) Einträge 1, 5 und 7
dist[c(1,5,7)]
#c) alle Einträge außer dem ersten und dem letzten
dist[c(-1,-10)]
#d) Selektion über logische Vektoren alle Eintr¨age mit einem Wert gr¨oßer als 0.5
dist[dist>0.5]
#e)
names(dist) <- letters[1:length(dist)]
#f)
dist[c("a", "f", "g")]


#1.3a)
rev_letters <- rev(letters)
#b) # Achtung: by Argument muss bei abfallender sequenz negativ sein!
letter_seq <- c(letters[seq(1,length(letters),2)], letters[seq(length(letters),1,-2)]) 
# [1] "a" "c" "e" "g" "i" "k" "m" "o" "q" "s" "u" "w" "y" "z" "x" "v" "t" "r" "p" "n" "l" "j"
# [23] "h" "f" "d" "b"


#1.4
bases <- c("a", "c", "g", "t")
first <- rep(bases, each=4)
snd <- rep(bases, times=4)
paste0(first, snd, ".fasta")
#[1] "aa.fasta" "ac.fasta" "ag.fasta" "at.fasta"
#[5] "ca.fasta" "cc.fasta" "cg.fasta" "ct.fasta"
#[9] "ga.fasta" "gc.fasta" "gg.fasta" "gt.fasta"
#[13] "ta.fasta" "tc.fasta" "tg.fasta" "tt.fasta"
