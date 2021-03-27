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
