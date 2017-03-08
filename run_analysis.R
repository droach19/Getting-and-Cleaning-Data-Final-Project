
getwd()
setwd("~/R")

### import the files

x_train <- read.table("./Week 4/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./Week 4/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./Week 4/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./Week 4/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./Week 4/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./Week 4/UCI HAR Dataset/test/subject_test.txt")

head(test)

Activitylabels <- read.table("./Week 4/UCI HAR Dataset/activity_labels.txt")

Features <- read.table("./Week 4/UCI HAR Dataset/features.txt")

### assign column names/clean up data

colnames(x_train) <- Features[,2]

head(x_train)

colnames(x_test) <- Features[,2]

colnames(y_train) <- "ActivityID"
colnames(y_test) <- "ActivityID"

colnames(subject_train) <- "SubjectID"
colnames(subject_test) <- "SubjectID"

colnames(Activitylabels) <- c("ActivityID","ActivityName")

### merge together

Master_Train <- cbind(subject_train, y_train, x_train)
Master_Test <- cbind(subject_test, y_test, x_test)

Master_Combined <- rbind(Master_Train,Master_Test)

colNames <- colnames(Master_Combined)

##pull out just columns that include mean or standard deviation

Measures <- (grepl("ActivityID", colNames) | grepl("SubjectID", colNames) | 
  grepl("mean..",colNames) | grepl("std..",colNames) )

head(Measures)

##library(ggplot2)

##add activity names

Master_Subset <- Master_Combined [ , Measures ==TRUE]

Master_Subset_2 <- merge(Master_Subset, Activitylabels, by="ActivityID", all.x=TRUE)

##improve variable names

names(Master_Subset_2)

names(Master_Subset_2) <-gsub("^t", "time", names(Master_Subset_2))
names(Master_Subset_2) <-gsub("^f", "frequency", names(Master_Subset_2))
names(Master_Subset_2) <-gsub("Acc", "Accelerometer", names(Master_Subset_2))
names(Master_Subset_2) <-gsub("Gyro", "Gyroscope", names(Master_Subset_2))
names(Master_Subset_2) <-gsub("Mag", "Magnitude", names(Master_Subset_2))
names(Master_Subset_2) <-gsub("BodyBody", "Body", names(Master_Subset_2))

library(plyr)

##create tidy data set that averages the columns we care about

TidyDataSet <- aggregate(.~SubjectID + ActivityID, Master_Subset_2, FUN = mean)

TidyDataSet <- TidyDataSet[order(TidyDataSet$SubjectID),]

str(TidyDataSet)

names(TidyDataSet)

write.table(TidyDataSet, "TidyDataSet.txt", sep = ",")





