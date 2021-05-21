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

