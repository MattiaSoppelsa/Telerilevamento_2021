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
soc20<-unsuperClass(so, nClasses=20)

plot(soc20$map)

#we can use favorite colors using "colorRampPalette"
cl <- colorRampPalette(c("yellow","red","brown"))(100)
#plotted with new colors
plot(soc$map, col=cl)

#Download an image from: 
#https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <-brick("sun.png")

#Unsupervised classification with 3 classes:
sunc<-unsuperClass(sun, nClasses=3)  #sunc is a classified object
plot(sunc$map)


