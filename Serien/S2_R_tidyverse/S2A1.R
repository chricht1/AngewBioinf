#2.1
df <- iris
tb <- as_tibble(df)
#b) colMeans()
apply(df[,1:4], MARGIN=2, FUN=mean)

tb |> summarize(across(colnames(tb)[1:4], mean))
# tb |> summarize(Mean = mean(Petal.Length)) # nur Mean über Petallänge

#c) colMeans für alle Species separat
lapply(unique(df$Species), function(sp) {
  sapply(df[df$Species == sp,][,1:4], mean) # 2D Indizierung BEACHTEN!
})
tb |> group_by(Species) |> summarize(Anzahl=n(), across(colnames(tb)[1:4], mean))
# sp_mean <- function(sp){ # ohne group_by viel umständlicher
#   tb |>filter(Species==sp) |> summarize(across(colnames(tb)[1:4], mean))
# }
# sapply(unique(tb$Species),sp_mean)

#d) Sortierung nach Sepalbreite absteigend und dann nach Petalbreite aufsteigend
df[order(df$Sepal.Width,df$Petal.Width, decreasing=c(TRUE,FALSE)),]

tb |> arrange(desc(Sepal.Width), Petal.Width) 

#e) 10 Spezies mit den längsten Sepallängen
df[order(df$Sepal.Length, decreasing=TRUE),]$Species[1:10]
head(df[order(df$Sepal.Length, decreasing=TRUE),],10)$Species

head(tb |> arrange(desc(Sepal.Length)),10)$Species

#f)
df["Sepal.Area"] <- as.vector(df$Sepal.Length) * as.vector(df$Sepal.Width)
tb <- tb |> mutate(Petal.Area = Petal.Length * Petal.Width)

# select
tb |> select(c(!contains("S"),contains("S"))) # Kombination
tb |> select(colnames(tb)[1:3])


# pivoting
# - a unique id for every column is needed to retain old tb after pivot longer
# pivot_longer: fasst auswahl an spalten zu zwei Spalten zusammen 
#   - eine Spalte mit Werten u. eine mit Spaltenname dessen
tb.long <- tb |> mutate(id = 1:nrow(tb)) |> pivot_longer(cols=1:4, names_to="param", values_to="value")
tb.wide <- tb.long |> pivot_wider(names_from = "param", values_from = "value")