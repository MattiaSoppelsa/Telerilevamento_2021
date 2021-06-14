#R_code_no2.r

library(raster)
library(RStoolbox)


#2.set the working directory:
setwd("D:/lab/EN/") 

#2.import the first image (single band) we will select band 1 but the raster is enable to select also other single bands.
EN01 <- raster("EN_0001.png")

#3. Plot the first importaed image with your preferred color

plot(EN01)
cl <- colorRampPalette(c("blue","green","red"))(100)
plot(EN01, col=cl)

#4. Import last image (13th) and plot it with the previous ColorRampPalette
EN13 <- raster("EN_0013.png")
cl <- colorRampPalette(c("blue","green","red"))(100)
plot(EN13, col=cl)

#5. Make the differnce between the two images and plot it (march - january or january - march)
ENdif <- EN13 - EN01
plot(ENdif, col=cl)

#6. plot everything in the same time
par(mfrow=c(3,1))         
plot(EN01, col=cl, main="January")
plot(EN13, col=cl, main="March")
plot(ENdif, col=cl, main="difference (January - March)")

#7. Import the whole set

ENlist<-list.files(pattern="EN")  
ENlist

ENimport<- lapply(ENlist,raster)  # abbiamo applicato la funzione raster sulla lista di immagine. 
ENimport  #to visualize the info about all the set of images.

EN <-stack(ENimport)
plot(EN, col=cl)

#8. Replicate the plot of images 1 and 13 using the function "stack" (andiamo a recuperare le immagini da stack e non dall'importazione iniziale

par(mfrow=c(2,1))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl

#9. Compute a PCA over the 13 images
# da aggiungere il pacchetto "RStoolbox
ENpca <- rasterPCA(EN)
summary(ENpca$model)                         
ENpca 
plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")
                                 
str(ENpca)  #

#10. Compute the variability (local standard deviation) of the first band (da riguardare)
ENpc1 <- ENpca$map$PC1
ENpc1 <- focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
clsd <- colorRampPalette(c("blue", "green","pink","magenta","orange", "brown", "red", "yellow"))(100)
plot(ndvisd5, col=clsd)



