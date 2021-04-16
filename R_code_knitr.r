#R_code_knitr.r

setwd("D:/lab/")



#per esportazione file in pdf (file r -> file TEX -> pdf
library(knitr)

#tinytex::install_tinytex()

# stitch("R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
stitch("D:/lab/greenland/R_code_greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr")) #serve .txt finale 

