library(dplyr)

if(!file.exists("./data")){dir.create("./data")}
fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")
filepath <-file.path("./data","UCI HAR Dataset")
files <- list.files(filepath, recursive=TRUE)

## Load All files in the R
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header=FALSE)
features <- read.table("./data/UCI HAR Dataset/features.txt", header=FALSE)
Y_test  <- read.table("./data/UCI HAR Dataset/test/Y_test.txt" ,header = FALSE)
Y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt",header = FALSE)

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header = FALSE)
subject_test  <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header = FALSE)

X_test  <- read.table("./data/UCI HAR Dataset/test/X_test.txt" ,header = FALSE)
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE)

## Merges the training and the test sets to create one data set.
X_data <- rbind(X_train,X_test)
Y_data <- rbind(Y_train,Y_test)
Subject_data <- rbind( subject_train, subject_test)

## X is Training set i.e. features
## Y is Training Labels i.e. activity
## Subject is subject

names(Subject_data) <- c("subject")
names(Y_data) <- c("activity")
names(X_data) <- features$V2

## Mearge all three tables into one to make data for Human Activity Recognition dataset (HAR_DATA)
Merge_subject_X_data <- cbind(Subject_data,X_data)
HAR_DATASET <- cbind(Y_data,Merge_subject_X_data)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
q2condition <- filter( features, grepl('mean', V2) | grepl('std', V2))

measurementName <- q2condition$V2
q2selectedColumns <- c("activity", "subject", as.character(measurementName))
HAR_SUBSET <- subset(HAR_DATASET, select=q2selectedColumns)

## Q3 Uses descriptive activity names to name the activities in the data set
names(activity_labels) <- c("activity","activity_desc")
HAR_SUBSET_ACTIVITY <- HAR_SUBSET %>% left_join(activity_labels, c("activity" = "activity"))


## 4. Appropriately labels the data set with descriptive variable names. 
##t - time
##f - frequency
##acc - accelerometer
##gyro - gyroscope
##Mag - Magnitude

names(HAR_SUBSET_ACTIVITY) <- gsub("Acc", "Accelerator", names(HAR_SUBSET_ACTIVITY))
names(HAR_SUBSET_ACTIVITY) <- gsub("Mag", "Magnitude", names(HAR_SUBSET_ACTIVITY))
names(HAR_SUBSET_ACTIVITY) <- gsub("Gyro", "Gyroscope", names(HAR_SUBSET_ACTIVITY))
names(HAR_SUBSET_ACTIVITY) <- gsub("^t", "time", names(HAR_SUBSET_ACTIVITY))
names(HAR_SUBSET_ACTIVITY) <- gsub("^f", "frequency", names(HAR_SUBSET_ACTIVITY))

## 5. From the data set in step 4, creates a second, 
## independent tidy data set with the average of each variable for each activity and each subject.

by_subject_activity <- group_by(HAR_SUBSET_ACTIVITY, subject, activity, activity_desc)
HAR_SUMMARY_DATASET <- by_subject_activity %>% summarise_each(funs(mean)) 
write.table(HAR_SUMMARY_DATASET,file = 'tidy_dataset.txt', row.name=FALSE)
