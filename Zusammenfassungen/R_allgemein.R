# R Allgemein:
#Kommandos werden getrennt durch
#▶ Semicolon
#▶ newline
# - indiziert wird immer beginnend mit 1

# R-Objekte
# Vektor ist Default Objekt/Datenstruktur in R (es gibt keine Skalare)

# (atomare) Datentypen von Objekten (modes):
# R is schwach typisiert (bei Deklaration Datentyp automat. 
# festgelegt, wird nicht angeg.)
# numeric, integer, complex, character (=String), logical


# class() gibt Klasse o. Typ (mode) von Objekt an
# typeof() gibt internen Speichertyp des Objekts an

# numeric: Datentyp für alle Zahlen (außer Komplex)
# - vereint Integer u. Double
# - wird als Double gespeichert
nums <- c(1.2, 2) # numeric

int <- 12L # integer

bool <- TRUE
chr <- "$" # character "abc"

# Objekte in R:
# - geschachtelte Struktur mögl.
# - Benennung jedes Elements einzeln mögl.
#   - names(<var>) <- c("<name1>, ...)
#   - <var> <- <obj>("<name1>"= <val1>, ...) 

# - vector, array, matrix -> Elemente dessselben modes

# - NA bedeutet fehlender Wert (z. B. wenn außerhalb 
# Indexgrenzen zugegriffen)

# Arten von Objekten:
#▶ NULL - leeres Objekt
#▶ vector
# - eindimensional, wird auch als array behandelt
# Indexierung:
v <- c(1:5)
v[c(3,0,3,1)] # Indices mit 0 werden ignoriert
# [1] 3 3 1

#▶ array 
# - vector mit Attribut dim
arr <- array(1:6, dim=c(2,3)) # kann bel. viele Dimensionen haben
# [,1] [,2] [,3]
# [1,]    1    3    5
# [2,]    2    4    6
# - spaltenorientierte Speicherung (Spalte vor Zeile gefüllt)
dim(arr)


# Zugriff:
arr[2:1,1:2] # z.B.
# - n-Col Array kann n-Dim-Array indexieren -> 
# Zeilen geben Index an

# Funktionen für Arrays:
t(arr) # Transponieren

# Kombination cbind, rbind:
cbind(c(1:3),c(4:6))
[,1] [,2]
[1,]    1    4
[2,]    2    5
[3,]    3    6
# rbind -> zeilenorientierte Komb.


#▶ matrix
# - array mit 2 Dimensionen
# matrix(data, nrow, ncol)
# Benennung von Zeilen u. Spalten: rownames(<var>), colnames(<var>)
# - auch Zugriff darauf


#▶ list (unterschiedliche modes)
l <- list("vec"=1:3, "n"=3)
l[1] # oder l["vec"] gibt Teilliste zurück, auch l[[1:2]], l[c("vec","n")]
l[[1]] # oder l$vec gibt Inhalt als vector zurück



#▶ data.frame (tabellenartig, unterschiedliche modes in Spalten)
# - konzeptionell Liste von Spaltenweisen Vektoren selber Länge
df <- data.frame("nums"=c(1:3,0), "ltrs"=letters[c(4:2,5)])

# Zugriff:
# - analog zu Listen
# df["nums"] oder df[1] gibt Liste zurück
# df[[1]] oder df$nums gibt Vektor zurück kann nur 1D sein, 
#  daher df[[x:y]] nicht mgl.

# Einlesen von Daten in Data-Frame:
# read.table(file, header=FALSE, sep, quote="\"", row.names, col.names)
# - quote: wenn 
#   Varianten:
#   - read.csv()
#   - read.delim() - für TSV-Dateien

#Funktionen auf Dataframes
order(df$ltrs,decreasing=FALSE) # gibt Indices in sortierter Liste zurück
# [1] 3 2 1 4

#▶ factor 
# - vector for eindeutigen kategorialen Elementen (wie Menge)
# - sind aber nicht explizit Mengen in R
facts <- factor(c(1,2,1.1,1,"1"))

#▶ function
# - unbenannte Arugmente zuerst, dann benannte
# mult <- function(x, y){
#     x * y
# }
# Funktionale Elemente R:
# apply(X, MARGIN, FUN, ...)
# - führt Funktion fun auf alle Zeilen (oder Spalten MARGIN=2) von Array aus
# - ... sind Argumente für FUN
# lapply, sapply: 
# - apply mit MARGIN=2
# - wobei lapply immer Liste zurückgibt
# - während sapply Ergebnis zu vektor/matrix versucht zu vereinfachen/reduzieren

# Nützl. Fkt.:
# which.min: gibt Pos. d. 1. minimums zurück

# Mathematik
# Runden: ceiling(1.4), floor(1.4)
# Betrag: abs(-3)



# Typkonversion
# as.<typ>(<Wert>)



# Vektorarithmetik
# - recycling mögl.:
c(1,2,3,4)*c(1,0.5)
# [1] 1 1 3 2



# Strings:
# Länge: nchar("abc") # [1] 3
# Escaping:
str <- "so called \"Vikings\""
# Werte konkatenieren:
#paste(<Werte>, sep=" ", collapse=NULL)
# gibt Vektor aus Strings
# collapse konkateniert alle Elemente des Vektors mit Argument

paste(1,2)
# [1] "1 2"

# wird auf jedes Element separat angewandt wenn Eingabe Vektor
paste(c(1,2))
# [1] "1" "2"

# wenn Eingabe mehrere Vektoren werden Vektoren elementweise durchgegangen
# mit recycling
paste0(c(1,2), c("a","b"), c(".txt"))
# [1] "1a.txt" "2b.txt"
