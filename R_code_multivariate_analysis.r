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
