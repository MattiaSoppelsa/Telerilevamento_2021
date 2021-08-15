# R_code_complete T

#Summary
#-----------------------------------------------------------
 
# day 1. Remote sensing first code
# day 2. Time series analysis
# day 3. R code copernicus.r
# day 4. R code knitr
# day 5. R code multivariate analysis.r (rpca)
# day 6. R code classification.r
# day 7. R code ggplot 2
# day 8. R code Vegetation index
# day 9. R code land cover
# day 10. R code variability.r

#-----------------------------------------------------------

# My first code in R for remote sensing!

#according to the work to be done we have to use different packages
#we download it in our pc through R with the function:
install.packages("raster")

#everytime we have to use the packages on R we have to recall it:
library(raster)

#connecting lab folder (where we put all the data regarding R)  to software
setwd("D:/lab/") 

#we can connect the image/file in lab folder to a name to recall easly
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#to check info about our image/file like class, dimension (pixels number), resolution, and also the names of the different bandes
p224r63_2011

#how to show (graphically) all the Bandes of a image
plot(p224r63_2011)

#colour change and set number levels
#we can "memorize" the new parameters by renaming them
cl <- colorRampPalette(c("black","grey","light grey"))(100)

#plotted with new colors. using the function "col" 
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

#if i want the number of column first i will use "col" instead of "row"  (#doesn't work anymore)
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

# -------------------------------------------------------------------------

# day 2. #Time series analysis 

#ritrovo la funzione "lapply" da questo punto di codice in poi
#--------------------------------------------------------------------------

#Time series analysis
#Greenland increase of temperature 
#Data and code from Emanuela Cosma

#we use the raster package
library(raster) 
setwd("D:/lab/greenland") #setting the folder we will use

#import single file/dataset with the function raster()
lst_2000<-raster("lst_2000.tif") 
plot(lst_2000) #we can check if the import is done.
#import also the other files
lst_2005<-raster("lst_2005.tif") 
lst_2010<-raster("lst_2010.tif") 
lst_2015<-raster("lst_2015.tif") 
#exercise with par
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#how to import all the file in the same time
#first at all we have to create a list with all files with using a pattern, and named 
rlist<-list.files(pattern="lst")
rlist

#using import<- lapply(rlist,raster)
#lapply serve per applicare la funzione raster a tutta la lista appena creata (o meglio "selezionata")
import<- lapply(rlist,raster)  #lapply (1°function), raster (2°f.), rlist (list of data) 
import

TGr<-stack(import) #Stacking vectors concatenates multiple vectors into a single vector along with a factor indicating where each observation originated. 

plotRGB(TGr, 1, 2, 3, stretch="Lin") #2000/2005/2010 all together.
plotRGB(TGr, 2, 3, 4, stretch="Lin") #plot rgb con valori satellitari che riguardano la temperatura
plotRGB(TGr, 4, 3, 2, stretch="Lin")

levelplot(TGr)                     #library("rasterVis")
  
levelplot(TGr$lst_2000) #evidence level you want

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100) #range of level of color, 100, from blue to red.
levelplot(TGr, col.regions=cl) #show level with different color (of cl, blue->red)

levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) # "names.attr=c()" to name the single attributes, name always with ""
levelplot(TGr,col.regions=cl,main="LST variation in time",names.attr=c("July 2000","July 2005", "July 2010", "July 2015")) #("main" to add title of page/graph)

# Melt,scioglimento ghiacciai dal 1979 al 2007
meltlist <- list.files(pattern="melt") #raccolgo/seleziono tutti i file denominati.melt in "meltlist"
melt_import <- lapply(meltlist,raster) #applico la funzione raster alla lista "meltlist", applicando malt_import a tutti i file
melt <- stack(melt_import) #raccolgo i vari files in un "vettore" unico =melt
melt

levelplot(melt)

#matrix algebra, we can reduct a single pixel's value of a matrix with the same pixels of other matrix   ("melt$" per legarlo al file melt da cui ricaviamo le 2 matrici)
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt

clb <- colorRampPalette(c("blue","white","red"))(100)   #gli mettiamo una colorRampPalette con i colori che ci aggradano
plot(melt_amount, col=clb)               #visualiziamo e possiamo vedere in rosso i valori più alti (ghiacciai sciolti)
melt_amount #per vedere i parametri, come ad esempio i valori minimi e massimi di differenza
levelplot(melt_amount, col.regions=clb)



#-------------------------------------------------------------------------------------------------

# day 3.    R_code_copernicus.r

#-------------------------------------------------------------------------------------------------

#R_code_copernicus.r
#Visualizing Copernicus data

#to see the library netCDF we have to add we packages
#install.packages("ncdf4")

#richiamo i due pacchetti che mi servono
library(raster)
library(ncdf4)

setwd("D:/lab/") #selezioniamo la cartella dalla quale andremo a prendere i dati
#diamo un nome al file che analizzeremo 
wain<-raster("index.nc") #ho rinominato il file raster e l'ho collegato ad R. "wain"="water.index" 
wain #per vedere i parametri dell'immagine 
#per il plottaggio abbiamo un singolo layer quindi non useremo il metodo rgb ma colourRampPalette
cl<-colorRampPalette(c("light blue","green","red","pink"))(100) 
plot(wain,col=cl)
#per diminuire la risoluzione andando ad aumentare la grandezza dei pixels
# con la funzione main="" posso aggiungere un titolo
plot(wain,col=cl,main="2016-04-01")
#se la funzione è troppo pesante posso aggregare un'area di pixels e la trasformiamo in un unico pixel "medio"
wain50 <-aggregate(wain,fact=50)  #ogni 50x50 pixel è come se fosse 1
wain100 <-aggregate(wain,fact=100)  # ogni 100x100

#ricorda usare file sempre con estensione .nc

#per esportazione file in pdf (file r -> file TEX -> pdf
library(knitr)
# stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
stitch("D:/lab/greenland/R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr")) #serve .txt finale 

#--------------------------------------------------------------------------------

# day 4. R_code_knitr.r

# -------------------------------------------------------------------------------

#R_code_knitr.r

setwd("D:/lab/")



#per esportazione file in pdf (file r -> file TEX -> pdf
library(knitr)

#tinytex::install_tinytex()
#texlive-msg-translations

# stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
stitch("D:/lab/greenland/R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr")) #serve .txt finale 

#-------------------------------------------------------------------------------

# day 5. R code multivariate analysis.r

#-------------------------------------------------------------------------------

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


#aggregate function
#per diminuire o allargare la larghezza dei pixel, quindi se vogliamo modificare la risoluzione
#aggregate cells, res: resampling (ricampionamento)
p224r63_2011res <- aggregate(p224r63_2011, fact=10)

p224r63_2011res #vedo che ho aumentato la grandezza del pixel quindi ho ridotto la risoluzione

par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2,stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#PCA principal component analysis per ridurre n dimensioni in un numero minore. 
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
# ma viene generato un file con all'interno un modello, una mappa etc..

summary(p224r63_2011res_pca$model) #per vedere la varianza delle componenti 
# e vedo che la componente 1 (PC1) spiega il 99% della variabilità. Possiede la maggior parte dell'informazione    
# l'ultime componenti avranno un'informazione minima, sarà rumore.                                 
                                 

p224r63_2011res_pca 

plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin") #map 
                                 
str(p224r63_2011res_pca)  #per più informazioni, anche sulla struttura       

#------------------------------------------------------------------------------------------------

# day 6. R code classification.r

#------------------------------------------------------------------------------------------------


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

#----------------------------------------------------------------------------------------

# day 7. R code ggplot 2

#----------------------------------------------------------------------------------------

#library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#------------------------------------------------------------------------------------------

# day 8. R code Vegetation index

#------------------------------------------------------------------------------------------

#R_code_Vegetation_index

library(raster) #=require(raster)
library(RStoolbox) # for vegetation indices calculation
#install.packages("rasterdiv") 
library(rasterdiv) # for the worldwide NDVI
library(rasterVis)

setwd("D:/lab/") # Windows


defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# b1=NIR, b2=red, b3=green

par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

defor1 #vediamo i nomi delle nostre variabili "names"

dvi1 <- defor1$defor1.1 - defor1$defor1.2  #commento

#dev.off()
plot(dvi1)


cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1,col=cl)

#per visualizzare e titolare
plot(dvi1, col=cl, main="DVI at time 1")

#per defor2
defor2 #controllo i nomi delle bande

dvi2 <- defor2$defor2.1 - defor2$defor2.2  #in pratica sottraggo la banda NIR alla banda del rosso

plot(dvi2)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2,col=cl)

par(mfrow=c(2,1))          #metto a confronto
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")
#posso anche trovare la differenza tra le due mappe. DVI prima mappa - DVI seconda

difdvi <- dvi1 - dvi2 #per ogni pixels

# dev.off() per visualizzare l'immagine meglio
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

#calcoliamo NVDI
# (NIR-RED)/ (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
#ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1,col=cl)



ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
#ndvi2 <- dvi2 / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2,col=cl)

#RStoolbox: spectralIndicies
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi,col=cl)
#
vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)


difndvi <- ndvi1 - ndvi2
 
# dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)

#day2 Worldwide NDVI
plot(copNDVI)

#Pixels with values 253, 254 and 255 (water) will be set  as NA's

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

#rasterVis package needed:

levelplot(copNDVI)

#----------------------------------------------------------------------------------------------

# day 9. R code land cover

#----------------------------------------------------------------------------------------------

# R_code_land_cover

library(raster) 
library(RStoolbox)
#install.packages("ggplot2")
library(ggplot2)
#install.packages("gridExtra")
library(gridExtra)

setwd("D:/lab/")

#NIR= 4 
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

# same action with defor2
defor2 <- brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

par(mfrow=c(1,2))   #par for plotRGB
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#par semplicemente non funziona con la funzione ggr, quindi si utilizza altro
#multiframe with ggplot2 and gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

grid.arrange(p1, p2, nrow=2)

#Unsupervides classification 
d1c <- unsuperClass(defor1, nClasses=2)

plot(d1c$map) 

#set.seed() would allow you to attain the same result

d2c <- unsuperClass(defor2, nClasses=2) #classe 2 foresta, classe 1 campi coltivati (fiume indistinto) 
plot(d2c$map)

d2c3 <- unsuperClass(defor2, nClasses=3) # with 3 classi nell'immagine c'è un'ulteriore distinzione nella parte agricola (bianco giallo)
plot(d2c3$map)

#frequency
freq(d1c$map)
#     value  count
#[1,]     1  35867
#[2,]     2 305425

#prima di tutto si somma 
s1 <- 305425 + 35867  
s1 #341292
#continuiamo con la proporzione
prop1 <- freq(d1c$map)/s1 
prop1

# prop1
#            value     count
#[1,] 2.930042e-06 0.1050918
#[2,] 5.860085e-06 0.8949082


s2 <- 342726
prop2 <- freq(d2c$map) /s2
prop2 

#            value     count
#[1,] 2.917783e-06 0.4776002    campi coltivati
#[2,] 5.835565e-06 0.5223998    foresta

#Build a dataframe
cover <- c("Forest","Agriculture")
percent_1992 <- c(89.49, 10.50)
percent_2006 <- c(52.23, 47.76)

percentages <- data.frame(cover, percent_1992, percent_2006)
percentages

#with ggplot we can plot 

ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")

# 2006 plot percentages 
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#assegnamo nomi!
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#mettiamo a confronto le percentuali di copertura vegetale e campi coltivati anni 1992/2006
grid.arrange(p1, p2, nrow=1)

#------------------------------------------------------------------------------------------------------------------

# day 10. R code variability.r

#------------------------------------------------------------------------------------------------------------------

#R_code_variability.r

#set the packages we will use
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
#install.packages("viridis")
library(viridis)

#set our fold directory
setwd("D:/lab/")
sent <- brick("sentinel.png")

#NIR 1 RED 2 GREEN 2 
# 
plotRGB(sent)
plotRGB(sent, stretch="lin")
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

nir <- sent$sentinel.1
red <- sent$sentinel.2
 
ndvi <- (nir-red) / (nir+red)
plot(ndvi)
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c("blue", "green","pink",magenta","orange", "brown", "red", "yellow"))(100)
plot(ndvisd5, col=clsd)

ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol==3), fun=mean)
clsd <- colorRampPalette(c("blue", "green","pink",magenta","orange", "brown", "red", "yellow"))(100)
plot(ndvisd5, col=clsd)
# mean ndvi with focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd)
#---------------------------------------------------------------------------------------------------
#PCA 
sentpca <- rasterPCA(sent)
plot(sentpca$map)

summary(sentpca$model) 
#the first PC contains 67% circa delle informazioni originali

#day 2
pc1 <- sentpca$map$PC1

pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c("blue", "green","pink","magenta","orange", "brown", "red", "yellow"))(100)
plot(ndvisd5, col=clsd)

#(SOURCE command: per caricare direttamente un codice in R senza nemmeno aprire il file)
#esempio:
source("source_test_lezione.r")
source("source_ggplot.r")

#per creare una nuova finestra vuota
ggplot() +  # "+" per aggiungere nuovi blocchi
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis() + #come defoult posso scrivere viridis(), oppure possiamo scegliere di aggiungere un colore
ggtitle("Standard deviation of PC1 by viridis colour scale")  #posso aggiungere un titolo o legenda

#facciamo un altro ggplot con il colore magma
p1 <- ggplot() +  # "+" per aggiungere nuovi blocchi
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma") + # magma oppure avrei potuto scrivere "A"
ggtitle("Standard deviation of PC1 by viridis colour scale")  

#usiamo il colore INFERNO
p2 <- ggplot() +  # "+" per aggiungere nuovi blocchi
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "B") + # magma oppure avrei potuto scrivere "inferno"
ggtitle("Standard deviation of PC1 by viridis colour scale") 

#usiamo il colore TURBO
p3 <- ggplot() +  # "+" per aggiungere nuovi blocchi
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "H") + # magma oppure avrei potuto scrivere "turbo"
ggtitle("Standard deviation of PC1 by viridis colour scale") 

#usiamo il colore CIVIDIS
p4 <- ggplot() +  # "+" per aggiungere nuovi blocchi
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "E") + # magma oppure avrei potuto scrivere "cividis"
ggtitle("Standard deviation of PC1 by viridis colour scale") 

#possiamo unire tutti i file raster visualizzati precedentemente
#prima di tutto bisogna associare ogni plot precedente ad un oggetto/nome
grid.arrange(p1, p2, p3, p4, nrow=1) 

#-----------------------------------------------------------------------------------------------------------------------------










