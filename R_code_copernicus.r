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
