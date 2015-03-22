# Getting and Cleaning Data


## Course Project Description
You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to Reproduce
1. Download the data source and place it on your local drive. The root folder should be named `UCI HAR Dataset`.
2. Place `run_analysis.R` in the same directory as the `UCI HAR Dataset` folder.
3. Run `source(run_analysis.R)`, which will create a `tidy_dataset.txt` file in the same directory as the R file and the dataset root folder.
