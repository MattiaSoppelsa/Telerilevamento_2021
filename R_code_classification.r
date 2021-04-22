#R_code_classification  

#if already installed cal back the packages
library(raster)
library(Rtoolbox)

#set the folder with we will work
setwd("D:/lab/solar")

so<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

so # to check the levels we have

#visualize RGB levels
plotRGB(so, 1, 2, 3, stretch="lin")
