library(raster)
library(rgdal)
library(rasterVis)


setwd("D:/lab/nami")
list21i<-list.files(pattern="20210408")
list18i<-list.files(pattern="")
list13i<-list.files(pattern="")
list08i<-list.files(pattern="")
list21f<-list.files(pattern="")
list18f<-list.files(pattern="")
list13f<-list.files(pattern="")
list08f<-list.files(pattern="")


imp21i<-lapply(list21i, raster)
imp18i<-lapply(list18i, raster)
imp13i<-lapply(list13i, raster)
imp08i<-lapply(list08i, raster)
imp21f<-lapply(list21f, raster)
imp18f<-lapply(list18f, raster)
imp13f<-lapply(list13f, raster)
imp08f<-lapply(list08f, raster)

eto21i <- stack(imp21i)
eto18i <- stack(imp18i)
eto13i <- stack(imp13i)
eto08i <- stack(imp08i)
eto21f <- stack(imp21f)
eto18f <- stack(imp18f)
eto13f <- stack(imp13f)
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


eto21i_res<-aggregate(eto21i, fact=10)
eto21i_pca<-rasterPCA(eto21i_res)
plot(eto21i_pca$map)
summary(eto21i_pca$model)
