# Load necessary library
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
df <- read.csv("D:/Data Mining/Project/patient ori.csv")


glimpse(df)
head(df)
dim(df)
str(df)
names(df)
summary(df)
## missing values
colSums(is.na(df))

## drop column
df = df[ ,c(-1, -2, -3,-84)]
glimpse(df)
## only select the complete cases
df = df[complete.cases(df), ]
summary(df)
colSums(is.na(df))

ggplot(df, aes(x = hospital_death)) +
  geom_bar() +
  labs(title = "Distribution of Hospital Death", x = "Hospital Death") +
  theme_minimal()+
  scale_fill_manual(values = c("0" = "lightblue", "1" = "red"))

ggplot(df, aes(x = gender, fill = factor(hospital_death))) +
  geom_bar(position = "fill") +
  labs(x = "Gender", y = "Proportion", fill = "Hospital Death") +
  theme_minimal()+
  scale_fill_manual(values = c("0" = "lightblue", "1" = "red"))

# Bar plot of diabetes_mellitus vs hospital_death

ggplot(data, aes(x = diabetes_mellitus, fill = as.factor(hospital_death))) +
  geom_bar(position = "dodge") +
  labs(x = "Diabetes Mellitus", y = "Count", fill = "Hospital Death") +
  theme_minimal()+
  scale_fill_manual(values = c("0" = "lightblue", "1" = "red"))


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
num_vars <- columns %>%
  select_if(is.numeric)
cor_matrix <- cor(num_vars, use = "complete.obs")

ggplot(df, aes(x = age, fill = factor(hospital_death))) +
  geom_histogram(bins = 30, alpha = 0.6, position = "identity") +
  facet_wrap(~ gender) +
  labs(x = "Age", fill = "Hospital Death") +
  theme_minimal()+
  scale_fill_manual(values = c("0" = "lightblue", "1" = "red"))
# Bar plot for icu_type vs hospital_death
ggplot(df, aes(x = icu_type, fill = factor(hospital_death))) +
  geom_bar(position = "fill") + # Use position fill for proportions
  labs(x = "ICU Type", y = "Proportion", fill = "Hospital Death") +
  theme_minimal() +
  scale_y_continuous(labels = scales::percent)+
  scale_fill_manual(values = c("0" = "lightblue", "1" = "red"))

ggplot(df, aes(x = factor(aids), fill = factor(hospital_death))) +
  geom_bar(position = "fill") + # Use position fill for proportions
  labs(x = "AIDS", y = "Proportion", fill = "Hospital Death") +
  theme_minimal() +
  scale_x_discrete(labels = c("No AIDS", "AIDS")) +
  scale_y_continuous(labels = scales::percent)+
  scale_fill_manual(values = c("0" = "lightblue", "1" = "red"))

ggplot(df, aes(x = factor(hepatic_failure), fill = factor(hospital_death))) +
  geom_bar(position = "fill") + # Use position fill for proportions
  labs(x = "Hepatic Failure", y = "Proportion", fill = "Hospital Death") +
  theme_minimal() +
  scale_x_discrete(labels = c("No Hepatic Failure", "Hepatic Failure")) +
  scale_y_continuous(labels = scales::percent)+
  scale_fill_manual(values = c("0" = "lightblue", "1" = "red"))

# Stacked bar plot for apache_3j_bodysystem vs hospital_death
ggplot(df, aes(x = factor(apache_3j_bodysystem), fill = factor(hospital_death))) +
  geom_bar(stat = "count") +
  labs(x = "Body System (Apache 3J)", y = "Count", fill = "Hospital Death") +
  theme_minimal()+
  scale_fill_manual(values = c("0" = "lightblue", "1" = "red"))

ggplot(df, aes(x = factor(apache_2_bodysystem), fill = factor(hospital_death))) +
  geom_bar(stat = "count") +
  labs(x = "Body System (Apache 2)", y = "Count", fill = "Hospital Death") +
  theme_minimal()+
  scale_fill_manual(values = c("0" = "lightblue", "1" = "red"))


ggplot(df, aes(x = hospital_death, fill = factor(icu_stay_type))) +
  geom_density(alpha = 0.5) +
  labs(x = "Hospital Death", y = "Density", fill = "ICU Stay Type") +
  theme_minimal()


# Histogram for heart_rate_apache and hospital death
ggplot(df, aes(x = heart_rate_apache, fill = factor(hospital_death))) +
  geom_histogram(position = "dodge", bins = 30) +
  labs(x = "Heart Rate (Apache)", y = "Count", fill = "Hospital Death") +
  theme_minimal()+
  scale_fill_manual(values = c("0" = "lightblue", "1" = "red"))
