#R_code_classification  

#if already installed cal back the packages
library(raster)
library(RStoolbox)

#set the folder with we will work
setwd("D:/lab/solar")

so<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

so # to check the levels we have

#visualize RGB levels
plotRGB(so, 1, 2, 3, stretch="lin")

#Unsupervised Classification 
soc<-unsuperClass(so, nClasses=3)
#per plottare usiamo l'immagine classificata "soc" e la leghiamo al modello della mappa
plot(soc$map)

#Unsupervised Classification with 20 classes
soc<-unsuperClass(so, nClasses=20)

plot(soc$map)
