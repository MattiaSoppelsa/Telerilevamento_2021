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



