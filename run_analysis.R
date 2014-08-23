test_y     <- read.table("y_test.txt")
test_x     <- read.table("X_test.txt")
test_subj  <- read.table("subject_test.txt")
train_y    <- read.table("y_train.txt")
train_x    <- read.table("X_train.txt")
train_subj <- read.table("subject_train.txt")

library("stats")

test_nc <- ncol(test_x)
test_nr <- nrow(test_x)
test_mean <- data.frame(1:test_nr)
test_stDiv <- data.frame(1:test_nr)
train_nc <- ncol(train_x)
train_nr <- nrow(train_x)
train_mean <- data.frame(1:train_nr)
train_stDiv <- data.frame(1:train_nr)

for (i in 1:test_nr) {
      measurments <- as.vector(test_x[i, 1:test_nc])
      measurments <- as.numeric(measurments)
      test_mean[i, 1]  <- mean(measurments)
      test_stDiv[i, 1] <- sd(measurments)
      if (test_y[i, 1] == 1) test_y[i, 1] <- "WALKING"
      if (test_y[i, 1] == 2) test_y[i, 1] <- "WALKING_UPSTAIRS"
      if (test_y[i, 1] == 3) test_y[i, 1] <- "WALKING_DOWNSTAIRS"
      if (test_y[i, 1] == 4) test_y[i, 1] <- "SITTING"
      if (test_y[i, 1] == 5) test_y[i, 1] <- "STANDING"
      if (test_y[i, 1] == 6) test_y[i, 1] <- "LAYING"
}

test <- cbind(test_subj, test_y, test_mean, test_stDiv)
colnames(test) <- c("Subject", "ActivityTest", "MeanTest", "StDivTest")

for (i in 1:train_nr) {
      measurments <- as.vector(train_x[i, 1:train_nc])
      measurments <- as.numeric(measurments)
      train_mean[i, 1]  <- mean(measurments)
      train_stDiv[i, 1] <- sd(measurments)
      if (train_y[i, 1] == 1) train_y[i, 1] <- "WALKING"
      if (train_y[i, 1] == 2) train_y[i, 1] <- "WALKING_UPSTAIRS"
      if (train_y[i, 1] == 3) train_y[i, 1] <- "WALKING_DOWNSTAIRS"
      if (train_y[i, 1] == 4) train_y[i, 1] <- "SITTING"
      if (train_y[i, 1] == 5) train_y[i, 1] <- "STANDING"
      if (train_y[i, 1] == 6) train_y[i, 1] <- "LAYING"
}      

train <- cbind(train_subj, train_y, train_mean, train_stDiv)
colnames(train) <- c("Subject", "ActivityTrain", "MeanTrain", "StDivTrain")

merderSet_bySubject <- merge(test, train, by.x = "Subject", by.y = "Subject", all = TRUE)

test_subjMean  <- tapply(test$MeanTest, test$Subject, mean)
test_subjStDiv <- tapply(test$StDivTest, test$Subject, mean)
test_actMean   <- tapply(test$MeanTest, test$ActivityTest, mean)
test_actStDiv  <- tapply(test$StDivTest, test$ActivityTest, mean)

train_subjMean  <- tapply(train$MeanTrain, train$Subject, mean)
train_subjStDiv <- tapply(train$StDivTrain, train$Subject, mean)
train_actMean   <- tapply(train$MeanTrain, train$ActivityTrain, mean)
train_actStDiv  <- tapply(train$StDivTrain, train$ActivityTrain, mean)

MeanAverage_subj  <- cbind(test_subjMean, train_subjMean)
MeanAverage_act   <- cbind(test_actMean, train_actMean)                          

StDivAverage_subj <- cbind(test_subjStDiv, train_subjStDiv)
StDivAverage_act  <- cbind(test_actStDiv, train_actStDiv)

MeanAverage <- rbind(MeanAverage_subj, MeanAverage_act)
StDivAverage <- rbind(StDivAverage_subj, StDivAverage_act)

tidyDataSet <- rbind(MeanAverage, StDivAverage)

write.table(tidyDataSet, file = "TidyDataSet.txt", row.names = FALSE)