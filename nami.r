library(raster)
library(rgdal)
library(rasterVis)
library(ggplot2)
library(gridExtra) #da aggiugere a ggplot2 perchè la funzione par in ggplot 2 non funge

setwd("D:/lab/nami")

## INDICE
# 1: importazione immagini satellitari (x mese e anno)
#
#
# 4: Raggruppamento degli anni per banda
---------------------------------------------------------------------------------------------------------------------

#### 1. IMPORTAZIONE IMMAGINI SATELLITARI X MESE e ANNO  ####

#immagine del 08/04/2021, creo una lista delle bande con un pattern, la importo e creo un file unico con le varie bande 
list21i<-list.files(pattern="20210408")
imp21i<-lapply(list21i, raster)
eto21i <- stack(imp21i)

#immagine del 31/03/2018
list18i<-list.files(pattern="20180331")
imp18i<-lapply(list18i, raster)
eto18i <- stack(imp18i)

#immagine del 18/04/2013
list13i<-list.files(pattern="20130418")
imp13i<-lapply(list13i, raster)
eto13i <- stack(imp13i)

#immagine del 20/04/2008
list08i<-list.files(pattern="20080420")
imp08i<-lapply(list08i, raster)
eto08i <- stack(imp08i)

#immagine del 01/10/2021
list21f<-list.files(pattern="20211001")
imp21f<-lapply(list21f, raster)
eto21f <- stack(imp21f)

#immagine del 09/10/2018
list18f<-list.files(pattern="20181009")
imp18f<-lapply(list18f, raster)
eto18f <- stack(imp18f)

#immagine del 11/10/2013
list13f<-list.files(pattern="20131011")
imp13f<-lapply(list13f, raster)
eto13f <- stack(imp13f)


#immagine del 27/09/2008
list08f<-list.files(pattern="20080927")
imp08f<-lapply(list08f, raster)
eto08f <- stack(imp08f)

plot(eto21i)
plot(eto18i)
plot(eto13i)
plot(eto08i)
plot(eto21f)
plot(eto18f)
plot(eto13f)
plot(eto08f)
--------------------------------------------------------------------------------------------------------------
par(mfrow=c(4,2))
plotRGB(eto08i, 3, 2, 1, stretch="lin", main="20/04/08")
plotRGB(eto08f, 3, 2, 1, stretch="lin", main="27/09/08")
plotRGB(eto13i, 3, 2, 1, stretch="lin", main="18/04/13")
plotRGB(eto13f, 3, 2, 1, stretch="lin", main="11/10/13")
plotRGB(eto18i, 3, 2, 1, stretch="lin", main="31/03/18")
plotRGB(eto18f, 3, 2, 1, stretch="lin", main="09/10/18")
plotRGB(eto21i, 3, 2, 1, stretch="lin", main="08/04/21")
plotRGB(eto21f, 3, 2, 1, stretch="lin", main="01/10/21")
----------------------------------------------------------------------------------------------------------------

# gradico dei valori di riflettanza per una banda (nota che l'immagine è stata ridotta di dimensioni di un fact=10)

eto08f_res<-aggregate(eto08f, fact=10)
green_res <- eto08f_res[[2]]

hist(green_res,
     maxpixels=ncell(green_res),
     breaks = 20,
     xlim = c(0, 2000),
     ylim = c(0, 120000),
     xlab = "band 3 reflectance value [DN * 0.01]",
     ylab = "frequency",
     main = "histogram L8 band 3 (green)"
    col="wheat")                                                                                                                                                                                                                                                                          


---------------------------------------------------------------------------------------------------------------
## NDWI - Normalized Difference Water Index ##

#Formula: NDWI= (NIR - SWIR)/(NIR + SWIR)
# in questo caso trovo ndwi dell'immagine del 27/09/2008
ndvi08f <- ((eto08f_res[[4]] - eto08f_res[[5]]) / (eto08f_res[[4]] + eto08f_res[[5]]))
levelplot(ndvi08f)


---------------------------------------------------------------------------------------------------------------
                                               
eto21i_res<-aggregate(eto21i, fact=10)
eto21i_pca<-rasterPCA(eto21i_res)
plot(eto21i_pca$map)
summary(eto21i_pca$model)

------------------------------------------

p1 <- ggRGB(eto08f, 1, 2, 3, stretch="lin")
p2 <- plotRGB(eto08f, 1, 2, 3, stretch="lin")
grid.arrange(p1,p2,nrow=2)
---------------------------------------------------------------------------------------------------------------------
## 4. Raggruppamento degli anni per banda ##

# B2 - blue (prova)

B2_20080420 <- raster("LT05_L2SP_179073_20080420_20200829_02_T2_SR_B2.TIF")
B2_20080927 <- raster("LT05_L2SP_179073_20080927_20200829_02_T1_SR_B2.TIF")  
B2_20130418 <- raster("LC08_L2SP_179073_20130418_20200912_02_T1_SR_B2.TIF")
B2_20131011 <- raster("LC08_L2SP_179073_20131011_20200913_02_T1_SR_B2.TIF")
B2_20180331 <- raster("LC08_L2SP_179073_20180331_20200901_02_T1_SR_B2.TIF")
B2_20181009 <- raster("LC08_L2SP_179073_20181009_20200830_02_T1_SR_B2.TIF")
B2_20210408 <- raster("LC08_L2SP_179073_20210408_20210416_02_T1_SR_B2.TIF")
B2_20211001 <- raster("LC08_L2SP_179073_20211001_20211013_02_T1_SR_B2.TIF")



xmin1<- c(xmin(extent(B2_20080420)), xmin(extent(B2_20080927)), xmin(extent(B2_20130418)), xmin(extent(B2_20131011)), xmin(extent(B2_20180331)), 
          xmin(extent(B2_20181009)), xmin(extent(B2_20210408)), xmin(extent(B2_20211001)))
xmin_new1<- max(xmin1) #prendo valore massimo

xmax1<- c(xmax(extent(B2_20080420)), xmax(extent(B2_20080927)), xmax(extent(B2_20130418)), xmax(extent(B2_20131011)), xmax(extent(B2_20180331)), 
          xmax(extent(B2_20181009)), xmax(extent(B2_20210408)), xmax(extent(B2_20211001)))
xmax_new<- min(xmax1) #prendo valore minimo

ymin1<- c(ymin(extent(B2_20080420)), ymin(extent(B2_20080927)), ymin(extent(B2_20130418)), ymin(extent(B2_20131011)), ymin(extent(B2_20180331)), 
          ymin(extent(B2_20181009)), ymin(extent(B2_20210408)), ymin(extent(B2_20211001)))
ymin_new1<- max(ymin1)

ymax1<- c(ymax(extent(B2_20080420)), ymax(extent(B2_20080927)), ymax(extent(B2_20130418)), ymax(extent(B2_20131011)), ymax(extent(B2_20180331)), 
          ymax(extent(B2_20181009)), ymax(extent(B2_20210408)), ymax(extent(B2_20211001)))
ymax_new<- min(ymax1)

#controllo quali siano in nuovi valori delle cordinate della nuova estensione
xmin_new
xmax_new
ymin_new
ymax_new

#setto la nuova extent
e <- extent(524985, 751815, -2182815, -1974285)

B2_20080420_crop <- crop(B2_20080420, extent(e))
B2_20080927_crop <- crop(B2_20080927, extent(e))
B2_20130418_crop <- crop(B2_20130418, extent(e))
B2_20131011_crop <- crop(B2_20131011, extent(e))
B2_20180331_crop <- crop(B2_20180331, extent(e))
B2_20181009_crop <- crop(B2_20181009, extent(e))
B2_20210408_crop <- crop(B2_20210408, extent(e))
B2_20211001_crop <- crop(B2_20211001, extent(e))

extent(B2_20080420_crop)
extent(B2_20211001_crop)

bandB2ys <- stack(B2_20080420_crop, B2_20080927_crop, B2_20130418_crop, B2_20131011_crop, B2_20180331_crop, B2_20181009_crop, B2_20210408_crop, B2_20211001_crop)

# B5

B5_20080420 <- raster("LT05_L2SP_179073_20080420_20200829_02_T2_SR_B5.TIF")
B5_20080927 <- raster("LT05_L2SP_179073_20080927_20200829_02_T1_SR_B5.TIF")  
B5_20130418 <- raster("LC08_L2SP_179073_20130418_20200912_02_T1_SR_B5.TIF")
B5_20131011 <- raster("LC08_L2SP_179073_20131011_20200913_02_T1_SR_B5.TIF")
B5_20180331 <- raster("LC08_L2SP_179073_20180331_20200901_02_T1_SR_B5.TIF")
B5_20181009 <- raster("LC08_L2SP_179073_20181009_20200830_02_T1_SR_B5.TIF")
B5_20210408 <- raster("LC08_L2SP_179073_20210408_20210416_02_T1_SR_B5.TIF")
B5_20211001 <- raster("LC08_L2SP_179073_20211001_20211013_02_T1_SR_B5.TIF")


e <- extent(524985, 751815, -2182815, -1974285)

B5_20080420_crop <- crop(B5_20080420, extent(e))
B5_20080927_crop <- crop(B5_20080927, extent(e))
B5_20130418_crop <- crop(B5_20130418, extent(e))
B5_20131011_crop <- crop(B5_20131011, extent(e))
B5_20180331_crop <- crop(B5_20180331, extent(e))
B5_20181009_crop <- crop(B5_20181009, extent(e))
B5_20210408_crop <- crop(B5_20210408, extent(e))
B5_20211001_crop <- crop(B5_20211001, extent(e))
bandB5iys <- stack(B5_20080420_crop, B5_20130418_crop, B5_20180331_crop, B5_20210408_crop)

bandB5iys_18_21 <- bandB5iys[[3]] - bandB5iys[[4]]
bandB5iys_13_21 <- bandB5iys[[2]] - bandB5iys[[4]]
bandB5iys_08_21 <- bandB5iys[[1]] - bandB5iys[[4]]

clb <- colorRampPalette(c("blue","white","red"))(100)

par(mfrow=c(2,2))
plot(bandB5iys_18_21, col=clb)
plot(bandB5iys_13_21, col=clb)
plot(bandB5iys_08_21, col=clb)

bandB5iys_18_21c4 <- unsuperClass(bandB5iys_18_21, nClasses=4)
bandB5iys_13_21c4 <- unsuperClass(bandB5iys_13_21, nClasses=4)
bandB5iys_08_21c4 <- unsuperClass(bandB5iys_08_21, nClasses=4)

par(mfrow=c(2,2))
plot(bandB5iys_18_21c4$map)
plot(bandB5iys_13_21c4$map)
plot(bandB5iys_08_21c4$map)

bandB5fys <- stack(B5_20080927_crop, B5_20131011_crop, B5_20181009_crop, B5_20211001_crop)
---------------------------------------------------------------------------------------------------------------------
## 4.1 ## prova fallita
listb2<-list.files(pattern="SR_B2")
listb2_crop <- lapply( X = listb2, FUN = crop, y = 518085, 755715, -2182815, -1972485)
listb2_crop <- lapply(listb2, crop, 518085, 755715, -2182815, -1972485)
importb2<-lapply(listb2, raster)
importb2
bandsb2 <- stack(importb2)
plot(bandsb2)

list_mar_apr_crop <- lapply(X = list_mar_apr, FUN = crop, y = boundary)

listb2[[i]] <- resample(rsts[[i]], r1)
listb2 <- list.files(path ="D:/lab/nami", pattern = "B2", full.names = TRUE)
stack <- do.call("rbind", lapply(listb2, readRDS))

r_sum = stack(importb2, extend_all(importb2))
plot(r_sum)

importb2<-lapply(listb2, raster)
importb2r <-lapply(importb2, extend_all(importb2))
----------
ex <- extent(c(518085, 755715, -2182815, -1972485))
site_crop <- crop(importb2, ex)
plot(site_crop)
---------------------------------------------------------
listde<-list.files(pattern="defor")
importde<-lapply(listde, raster)
listde
bandsde <- stack(importde)
plot(bandsde)
