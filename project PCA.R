
library(dplyr)
library(ggplot2)
library(FactoMineR)
library(factoextra)
library(pillar)
library(corrplot)
library(psych)
library(readr)
library(GPArotation)
source("http://blogs.5eanalytics.com/RCode/PCA_functions.R")
df <- read.csv("D:/Data Mining/Project/patient.csv")


glimpse(df)
head(df)
dim(df)
str(df)
names(df)
summary(df)

colSums(is.na(df))


df = df[ ,c(-1, -2, -3,-84)]
glimpse(df)

df = df[complete.cases(df), ]

colSums(is.na(df))
##
pca_result = PCA(df, scale.unit=T, graph=T)
summary(pca_result)
fviz_screeplot(pca_result, ncp=40)

communality(pca_result)

display_pc(pca_result, cutoff=0.4)

 
pca_result = PCA(df, scale.unit=T, graph=T)
pca_result$eig
pca_result$var
pca_result$var$coord
    
loadings.pcarot= varimax(pca_result$var$coord)$loadings
pca_result$var$coord = loadings.pcarot
plot(pca_result, choix  ="var")
display_pc(pca_result)

## 
summary(pca_result)
communality(pca_result)

pca_result$var$coord[,1:5] 
PC = as.matrix(df) %*% as.matrix(pca_result$var$coord[,1:5])
colnames(PC) = c("PC1", "PC2", "PC3", "PC4", "PC5")
df_PCA =cbind(df, PC)
cor(df, use="pairwise.complete.obs")
summary(df)

pca_result$var$contrib

