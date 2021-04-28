library(raster)
library(RStoolbox)
 
setwd("D:/lab/")

# landsat usa 7 bande, la funzione da usare è brick per caricare un set multiplo di dati 
#raster invece carica solo un set alla volta
p224r63_2011 <- brick("p224r63_2011.grd")

#to see first rappresentation 
plot(p224r63_2011) 
# to check info
p224r63_2011

#plottiamo i valori della banda 1 vs i valori della banda 2 in pixels

plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2) 
#ci darà un warning perchè ci dice che sta plottando un campiopne, ovvero il 2.2% dei pixels
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2) 

#per farlo per tutte le bande? usiamo la funzione "pairs"
#per plottare tutte le correlazioni possibili (2 a 2) tra le variabili (ovvero tutte le bande)
pairs(p224r63_2011)


#aggregate function
#per diminuire o allargare la larghezza dei pixel, quindi se vogliamo modificare la risoluzione
#aggregate cells, res: resampling (ricampionamento)
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

p224r63_2011res #vedo che ho aumentato la grandezza del pixel quindi ho ridotto la risoluzione

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2,stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#PCA principal component analysis per ridurre n dimensioni in un numero minore. 
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
# ma viene generato un file con all'interno un modello, una mappa etc..

summary(p224r63_2011res_pca$model) #per vedere la varianza delle componenti 
# e vedo che la componente 1 (PC1) spiega il 99% della variabilità. Possiede la maggior parte dell'informazione    
# l'ultime componenti avranno un'informazione minima, sarà rumore.                                 
                                 

p224r63_2011res_pca 

plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin") #map 
                                 
str(p224r63_2011res_pca)  #per più informazioni, anche sulla struttura       

