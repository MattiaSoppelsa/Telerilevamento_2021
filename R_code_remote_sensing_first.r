# My first code in R for remote sensing!
#how import packages on R
instal.packages("raster")

#to use the packages on R
library(raster)
setwd("D:/lab/") #connecting lab folder to software

#we can connect the image/file to a name
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

# 2 row and 1 column? (just invert number)
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#if i want the number of column first i will use "col" instead of "row" 
par(mfcol=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot the first 4 bands of landsat
# 4 row and 1 col
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

# a quadrat of bands
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#every bands with own ColorRampPalette
par(mfrow=c(2,2))
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100) 
plot(p224r63_2011$B1_sre, col=clb)
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(p224r63_2011$B2_sre, col=clg)
clr <- colorRampPalette(c("dark red","red","pink"))(100) #using pink because light red doesn't exist
plot(p224r63_2011$B3_sre, col=clr)
clnir <- colorRampPalette(c("dark orange","orange","yellow"))(100)
plot(p224r63_2011$B4_sre, col=clnir)

#DAY4: Visualizing Data by RGB plotting

#Landsat bands (just to remember)
#B1=blue
#B2=green
#B3=red
#B4=nir
#B5=mir
#B6=thermal infrared (tir?)
#B7=mir*

#"stretch" function= Linear stretch of values in a Raster object, useful for viewing our bands
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #shift by 1, remove blue band and add nir band on red component
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #changing the bands in different components allows us to view interesting details
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#exercise mount a 2x2 multiframe with plotRGB
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #shift by 1, remove blue band and add nir band on red component
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #changing the bands in different components allows us to view interesting details
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
#import image in pdf in "lab" folder (form pdf to dev.off())
pdf("il_mio_primo_pdf_con_R.pdf")  
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

#histogram stretch, function with greater range of intermediate values (nir mount on green)
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #here we can see better the wetlands

#par with natural colours, false colours, false colours with histogram stretch
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#for the next time istall new package "RTtoolbox"
install.packages("RStoolbox")
library(RStoolbox) #to check if package is istalled corretly

#Add new image! p224r63_1988, same place different year (Multitemporal set)
library(raster) #remember to R to use raster package
setwd("D:/lab/") #connect the folder where image is
p224r63_1988 <- brick("p224r63_1988_masked.grd") #import the image/file on R and rename it/associate a name
p224r63_2011 <- brick("p224r63_2011_masked.grd") #that one was the image already used previously 
p224r63_1988 #check the info about the image
plot(p224r63_1988) #check all bands without any edit

#link the components of the RGB scheme to the bands, each bands with respective "natural colours"), and plot it
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="lin") #shift all by 1, Nir band used, no more blue
#compare the same image with same parameter, but taken in different year (1988-2011)
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#using also histogram streatch
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

#and make a pdf in lab folder
pdf("Confrontation_1988-2011.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()

#END



