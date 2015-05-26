The task description

Merges the training and the test sets to create one data set Read the "train/X_train.txt" to X_train,"train/y_train.txt" to Y_train,"train/subject_train.tx" to subject_train, "test/X_test.txt" to X_test,"test/y_test.txt" to Y_test,"test/subject_test.tx" to subject_test.Then use the rbind to merge the data sets, "X_data" is a 10299 × 66 data frame "Y_data" is a 10299 × 1 data frame "Subject_data" also a 10299 × 1 data frame
Read the features.txt to features and read activity_labels to activity labels.

Extracts only the measurements on the mean and standard deviation for each measurement. Then extract only those columns with activity in to a subset HAR_SUBSET. 

Appropriately labels the data set with descriptive variable names. Merge the HAR_SUBSET with ,activity to HAR_SUBSET_ACTIVITY

From the data set in step 4, creates a second, independent tidy data set named "HAR_SUMMARY_DATASET" with the average of each variable for each activity and each subject. In order to get the average of each variable for each activity and each subject.Finnaly export the result to tidy_dataset.txt
