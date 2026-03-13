
library("rpart.plot") 
library("rpart")
library("readr")
library(party)
library(dplyr)
library(C50)
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


str(df)

set.seed(123)
df_indices <- sample(1:nrow(df), size = 0.8 * nrow(df))
df_train <- df[df_indices, ]
df_test <- df[-df_indices, ]

fullmodel = 'hospital_death ~ .'

rpart_tree <- rpart(hospital_death ~., data = df_train, method = "class")


rpart.plot(rpart_tree, type = 2, extra = 101, under = TRUE)


predictions <- predict(rpart_tree, df_test, type = "class")


confusion_matrix <- table(Predicted = predictions, Actual = df_test$hospital_death)
print(confusion_matrix)


accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
cat("Accuracy:", round(accuracy * 100, 2), "%\n")


df_train$hospital_death <- as.factor(df_train$hospital_death)
c50_model <- C5.0(hospital_death ~ ., data = df_train)


summary(c50_model)


predictions <- predict(c50_model, df_test)


confusion_matrix <- table(Predicted = predictions, Actual = df_test$hospital_death)
print(confusion_matrix)


accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
cat("Accuracy:", round(accuracy * 100, 2), "%\n")


plot(c50_model)

c50_model_pruned <- C5.0(hospital_death ~ ., 
                          data = df_train, 
                          control = C5.0Control(minCases = 150, CF = 0.5))


summary(c50_model_pruned)


predictions_pruned <- predict(c50_model_pruned, df_test)


confusion_matrix_pruned <- table(Predicted = predictions_pruned, Actual = df_test$hospital_death)
print(confusion_matrix_pruned)


accuracy_pruned <- sum(diag(confusion_matrix_pruned)) / sum(confusion_matrix_pruned)
cat("Pruned Tree Accuracy:", round(accuracy_pruned * 100, 2), "%\n")


plot(c50_model_pruned)


c_tree <- ctree(hospital_death ~ ., data = df_train)


plot(c_tree, main = "Conditional Inference Tree")


predictions <- predict(c_tree, df_test)


confusion_matrix <- table(Predicted = predictions, Actual = df_test$hospital_death)
print(confusion_matrix)


accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
cat("Accuracy:", round(accuracy * 100, 2), "%\n")

c_tree_pruned <- ctree(
  hospital_death ~ ., 
  data = df_train, 
  controls = ctree_control(
    mincriterion = 0.95,  
    minsplit = 20,        
    maxdepth = 3          
  )
)


plot(c_tree_pruned, main = "Pruned Conditional Inference Tree")


predictions_pruned <- predict(c_tree_pruned, df_test)


confusion_matrix_pruned <- table(Predicted = predictions_pruned, Actual = df_test$hospital_death)
print(confusion_matrix_pruned)


accuracy_pruned <- sum(diag(confusion_matrix_pruned)) / sum(confusion_matrix_pruned)
cat("Pruned Tree Accuracy:", round(accuracy_pruned * 100, 2), "%\n")
