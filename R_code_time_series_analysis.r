#Time series analysis
#Greenland increase of temperature 
#Data and code from Emanuela Cosma

#we use the raster package
library(raster) 
setwd("D:/lab/greenland") #setting the folder we will use

#import single file/dataset with the function raster()
lst_2000<-raster("lst_2000.tif") 
plot(lst_2000) #we can check if the import is done.
