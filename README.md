# GettingCleaningData
Getting and Cleaning Data
This is repository for Getting and Cleaning data course.
The run_analysis.R program is writtern for the course project and this program that is doing foloowing tasks - 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This code first read the data file from the internet location mentioned in the project description. Then program downloads file into a data folder and unzip the files.

Then program read following files using read.table -
activity_labels.txt
features.txt
Y_test.txt
Y_train.txt
subject_train.txt
subject_test.txt
X_test.txt
X_train.txt

Then program merging data for test and train files for X, Y and Subject files.
After row merging, programing merging all tables into one table.

In this program I am using Dplyr packge for performing database related functions like to find mean , filtering of data.

Then changed the label with gsub.

Later I used dplyr summarise_each function to get average by each activity and and each subject.

then used write table to generate final tidy dataset.

