# My first code in R for remote sensing!
setwd("D:/lab/") #connecting lab folder to software

#how import images on R
#instal.packages("raster")
library(raster)
#we can also connect the image/file to a name
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#to check info 
p224r63_2011

#how to show all the B
plot(p224r63_2011)
