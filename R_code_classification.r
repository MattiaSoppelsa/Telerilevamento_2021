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

#R_code Grand Canyon classification
#link of used image: https://landsat.visibleearth.nasa.gov/view.php?id=80948

library(raster)
library(RStoolbox)
setwd("D:/lab")
gc<- brick("dolansprings_oli_2013088_canyon_lrg.jpg") #bring the image on R

plotRGB(gc, r=1, g=2, b=3, stretch="lin") #plot in RGD "mode" in linear mode

#we can use hist to use tutti i legami possibili per visualizzare l'immagine
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)

#using 4 classes
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)
