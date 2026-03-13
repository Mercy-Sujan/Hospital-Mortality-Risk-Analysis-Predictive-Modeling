
library(class) 
library(dplyr)


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
glimpse(df)

set.seed(123)
df_indices <- sample(1:nrow(df), size = 0.8 * nrow(df))
df_train <- df[df_indices, ]
df_test <- df[-df_indices, ]


selected_features = c("hospital_death", "age", "elective_surgery", "gender", 
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
                 "apache_3j_bodysystem", "apache_2_bodysystem")
df_selected <- df %>% select(all_of(selected_features), hospital_death) 


df_selected <- na.omit(df_selected)


df_normalized <- df_selected %>%
  mutate(across(all_of(selected_features), scale))


set.seed(123)  
sample_index <- sample(1:nrow(df_normalized), size = 0.8 * nrow(df_normalized))
train_data <- df_normalized[sample_index, ]
test_data <- df_normalized[-sample_index, ]


train_features <- train_data %>% select(-hospital_death)
train_target <- train_data$hospital_death
test_features <- test_data %>% select(-hospital_death)
test_target <- test_data$hospital_death


k <- 9  
knn_model <- knn(train = train_features,
                 test = test_features,
                 cl = train_target,
                 k = k)


knn_predictions <- as.factor(knn_model)


accuracy <- mean(knn_predictions == test_target)
cat("Model Accuracy:", accuracy, "\n")


table(Predicted = knn_predictions, Actual = test_target)


ggplot(test_data, aes(x = apache_4a_hospital_death_prob, y = d1_sysbp_min, color = knn_predictions)) +
  geom_point() +
  ggtitle("KNN Classification Results")


k <- 13  
knn_model <- knn(train = train_features,
                 test = test_features,
                 cl = train_target,
                 k = k)


knn_predictions <- as.factor(knn_model)


accuracy <- mean(knn_predictions == test_target)
cat("Model Accuracy:", accuracy, "\n")


table(Predicted = knn_predictions, Actual = test_target)


ggplot(test_data, aes(x = apache_4a_hospital_death_prob, y = d1_sysbp_min, color = knn_predictions)) +
  geom_point() +
  ggtitle("KNN Classification Results")


k <- 15  
knn_model <- knn(train = train_features,
                 test = test_features,
                 cl = train_target,
                 k = k)


knn_predictions <- as.factor(knn_model)


accuracy <- mean(knn_predictions == test_target)
cat("Model Accuracy:", accuracy, "\n")


table(Predicted = knn_predictions, Actual = test_target)


ggplot(test_data, aes(x =apache_4a_hospital_death_prob , y = d1_sysbp_min, color = knn_predictions)) +
  geom_point() +
  ggtitle("KNN Classification Results")
