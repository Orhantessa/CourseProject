test_y     <- read.table("y_test.txt")
test_x     <- read.table("X_test.txt")
test_subj  <- read.table("subject_test.txt")
train_y    <- read.table("y_train.txt")
train_x    <- read.table("X_train.txt")
train_subj <- read.table("subject_train.txt")

test_nc <- ncol(test_x)
test_nr <- nrow(test_x)
train_nc <- ncol(train_x)
train_nr <- nrow(train_x)

for (i in 1:test_nr) {
      measurments <- test_x[i, 1:test_nc]
      test_mean[i]  <- lapply(measurments, mean)
      test_stDiv[i] <- lapply(measurments, st)
      if (test_y[i] == 1) test_y[i] <- "WALKING"
      if (test_y[i] == 2) test_y[i] <- "WALKING_UPSTAIRS"
      if (test_y[i] == 3) test_y[i] <- "WALKING_DOWNSTAIRS"
      if (test_y[i] == 4) test_y[i] <- "SITTING"
      if (test_y[i] == 5) test_y[i] <- "STANDING"
      if (test_y[i] == 6) test_y[i] <- "LAYING"
}

test <- cbind(test_subj, test_y, test_mean, test_stDiv)
colnames(test) <- c("Subject", "ActivityTest", "MeanTest", "StDivTest")

for (i in 1:train_nr) {
      measurments <- train_x[i, 1:train_nc]
      train_mean[i]  <- lapply(measurments, mean)
      train_stDiv[i] <- lapply(measurments, st)
      if (train_y[i] == 1) train_y[i] <- "WALKING"
      if (train_y[i] == 2) train_y[i] <- "WALKING_UPSTAIRS"
      if (train_y[i] == 3) train_y[i] <- "WALKING_DOWNSTAIRS"
      if (train_y[i] == 4) train_y[i] <- "SITTING"
      if (train_y[i] == 5) train_y[i] <- "STANDING"
      if (train_y[i] == 6) train_y[i] <- "LAYING"
}      

train <- cbind(train_subj, train_y, train_mean, train_stDiv)
colnames(train) <- c("Subject", "ActivityTrain", "MeanTrain", "StDivTrain")

merderSet_bySubject <- merge(test, train, by.x = "Subject", by.y = "Subject", all = TRUE)

test_subjMean  <- tapply(test$Subject, test$MeanTest, mean)
test_subjStDiv <- tapply(test$Subject, test$StDivTest, mean)
test_actMean   <- tapply(test$ActivityTest, test$MeanTest, mean)
test_actStDiv  <- tapply(test$ActivityTest, test$StDivTest, mean)

train_subjMean  <- tapply(train$Subject, test$MeanTrain, mean)
train_subjStDiv <- tapply(train$Subject, test$StDivTrain, mean)
train_actMean   <- tapply(train$ActivityTraint, test$MeanTrain, mean)
train_actStDiv  <- tapply(train$ActivityTrain, test$StDivTrain, mean)

MeanAverage  <- cbind(test_subjMean, test_actMean, train_subjMean, train_actMean)                          
StDivAverage <- cbind(test_subjStDiv, test_actStDiv, train_subjStDiv, train_actStDiv)
tidyDataSet <- rbind(MeanAverage, StDivAverage)

write.table(tidyDataSet, file = "TidyDataSet.txt", row.names = FALSE)