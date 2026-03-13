
library(dplyr)
library(ggplot2)
library(FactoMineR)
library(factoextra)
library(pillar)
library(corrplot)
library(psych)
library(readr)
library(GPArotation)
library(Metrics)
library(caret)
library(nortest)
library(lmtest)
library(car)
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


outliers <- apply(df, 2, function(x) boxplot.stats(x)$out)
print(outliers)


set.seed(123)
df_indices <- sample(1:nrow(df), size = 0.8 * nrow(df))
df_train <- df[df_indices, ]
df_test <- df[-df_indices, ]


train_lm = lm(hospital_death~., data=df_train)
summary(train_lm)

train_lm_step = step(train_lm, scope = hospital_death~., direction="both")
summary(train_lm_step)

signifi = hospital_death ~ age + elective_surgery + gender + 
  height + icu_admit_source + icu_id + pre_icu_los_days + 
  weight + apache_post_operative + arf_apache + 
  gcs_eyes_apache + gcs_motor_apache + 
  intubated_apache + map_apache + resprate_apache + ventilated_apache + 
  d1_diasbp_min + d1_heartrate_max + d1_mbp_min + 
  d1_resprate_min + d1_spo2_max + d1_spo2_min + d1_sysbp_min + 
  d1_sysbp_noninvasive_max + d1_temp_max + d1_temp_min + h1_diasbp_max + 
  h1_heartrate_max + h1_mbp_noninvasive_min + h1_resprate_max + 
  h1_resprate_min + h1_spo2_max + h1_spo2_min + h1_sysbp_min + 
  d1_glucose_max + d1_glucose_min + d1_potassium_max + apache_4a_hospital_death_prob + 
  apache_4a_icu_death_prob + cirrhosis + diabetes_mellitus + 
  hepatic_failure + immunosuppression + leukemia + solid_tumor_with_metastasis + 
  apache_3j_bodysystem + apache_2_bodysystem


train_lm1 = lm(signifi, data=df_train)
summary(train_lm1)

predictions =  predict( train_lm1, newdata=df_test, type = "response")
rmse_value <- sqrt(mean((df_test$hospital_death - predictions)^2))

cat("RMSE: ", rmse_value, "\n")

test_predictions_class <- ifelse(predictions > 0.5, 1, 0)


conf_matrix <- confusionMatrix(factor(test_predictions_class), factor(df_test$hospital_death))


print(conf_matrix)

mean(train_lm1$residuals)
ad.test(train_lm1$residuals)
bptest(train_lm1)
durbinWatsonTest(train_lm1)
plot(train_lm1)
return()
return()
return()
