# My first code in R for remote sensing!
setwd("D:/lab/") #connecting lab folder to software

#how import packages on R
instal.packages("raster")
#to use the packages on R
library(raster)
#we can also connect the image/file to a name
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#to check info about our image/file
p224r63_2011

#how to show all the Bandes of a file/image
plot(p224r63_2011)

#colour change and set levels(out of my function), all renamed
cl <- colorRampPalette(c("black","grey","light grey"))(100)

#plotted with new colors
plot(p224r63_2011, col=cl)

#change with my new colours
cl <- colorRampPalette(c("blue","yellow","green","red"))(100)
plot(p224r63_2011, col=cl)

#important command: dev.off() to clean the current graph

#DAY 3
#Landsat bands
#B1=blue
#B2=green
#B3=red
#B4=nir
#B5=mir
#B6=thermal infrared (tir?)
#B7=mir*

dev.off()
# to see just 1 band we plot the file with B1 linked (using $ command)
plot(p224r63_2011$B1_sre)

#exercise: plot band 1 with a predefined color ramp palette
cl <- colorRampPalette(c("blue","yellow","green","red"))(100)
plot(p224r63_2011$B1_sre, col=cl)

#close the band window manually or with command dev.off()

#we can also plot 2 bands in the same windows with the function "par" followed by the plots we are interested
#we are doing a multiframe (fm) with 1 row and 2 column
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
