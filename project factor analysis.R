
library(dplyr)
library(ggplot2)
library(FactoMineR)
library(factoextra)
library(pillar)
library(corrplot)
library(psych)
library(readr)
library(GPArotation)

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
summary(df)
colSums(is.na(df))


cormat = cor(df)
cormat
cortest.bartlett(cormat, n=nrow(df))

glimpse(df)

f = factanal(df,factors=3, rotation="")
print(f,cutoff=.3)

##
columns = df[, c("hospital_death", "age", "elective_surgery", "gender", 
       "height", "icu_admit_source", "icu_id", "pre_icu_los_days", 
       "weight", "apache_post_operative", "arf_apache", 
       "gcs_eyes_apache", "gcs_motor_apache", 
       "intubated_apache", "map_apache", "resprate_apache", "ventilated_apache", 
       "d1_diasbp_min", "d1_heartrate_max", "d1_mbp_min", 
       "d1_resprate_min", "d1_spo2_max", "d1_spo2_min", "d1_sysbp_min", 
       "d1_sysbp_noninvasive_max", "d1_temp_max", "d1_temp_min", "h1_diasbp_max", 
       "h1_heartrate_max", "h1_mbp_noninvasive_min", "h1_resprate_max", 
       "h1_resprate_min", "h1_spo2_max", "h1_spo2_min", "h1_sysbp_min", 
       "d1_glucose_max", "d1_glucose_min", "d1_potassium_max", "apache_4a_hospital_death_prob", 
       "apache_4a_icu_death_prob", "cirrhosis", "diabetes_mellitus", 
       "hepatic_failure", "immunosuppression", "leukemia", "solid_tumor_with_metastasis", 
       "apache_3j_bodysystem", "apache_2_bodysystem")]

f = factanal(columns, factors=10, rotation="varimax")

print(f,cutoff=.3)

f = factanal(columns,factors=10, rotation="promax")
print(f,cutoff=.3)
