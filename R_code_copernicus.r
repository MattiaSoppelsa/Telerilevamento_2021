#R_code_copernicus.r
#Visualizing Copernicus data

#to see the library netCDF we have to add we packages
#install.packages("ncdf4")

#richiamo i due pacchetti che mi servono
library(raster)
library(ncdf4)

setwd("D:/lab/") #selezioniamo la cartella dalla quale andremo a prendere i dati
#diamo un nome al file che analizzeremo 
wain<-raster("index.nc") #ho rinominato il file raster e l'ho collegato ad R. "wain"="water.index" 
wain #per vedere i parametri dell'immagine 
#per il plottaggio abbiamo un singolo layer quindi non useremo il metodo rgb ma colourRampPalette
cl<-colorRampPalette(c("light blue","green","red","pink"))(100) 
plot(wain,col=cl)
#per diminuire la risoluzione andando ad aumentare la grandezza dei pixels
# con la funzione main="" posso aggiungere un titolo
plot(wain,col=cl,main="2016-04-01")
#se la funzione è troppo pesante posso aggregare un'area di pixels e la trasformiamo in un unico pixel "medio"
wain50 <-aggregate(wain,fact=50)  #ogni 50x50 pixel è come se fosse 1
wain100 <-aggregate(wain,fact=100)  # ogni 100x100

#ricorda usare file sempre con estensione .nc

#per esportazione file in pdf (file r -> file TEX -> pdf
library(knitr)
# stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
stitch("D:/lab/greenland/R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr")) #serve .txt finale 
