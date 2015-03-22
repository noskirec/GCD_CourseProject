# Getting and Cleaning Data


## Course Project Description
You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Explanation of Functionality
There are three statements that encapsulate the data aggregation, cleaning, and tidying process.
```
merged_data <- merge_data("UCI HAR Dataset")
meanstd_dataset <- extract_meanstd(merged_data, "UCI HAR Dataset")
tidify_data(meanstd_dataset, "./tidy_dataset.txt")
```
These statements are each calling a separate function within the R file that tackle a different set of the 5 tasks above.

### merge_data
This function is designed solely to aggregate all the data from the various text files into one comprehensive data table. Aside from merging activity and y labels, no additional functionality is performed.
### extract_meanstd
This function is designed to extract a subset of columns from the `data_set` parameter, whose column names contain either "mean()" or "std()". In order to perform this, labels from `feature.txt` are grabbed and used to rename the columns in `data_set`.
### tidify_data
This function performs melt(), casts back to a tidy format, and then writes to a .txt file.

## Steps to Reproduce
1. Download the data source and place it on your local drive. The root folder should be named `UCI HAR Dataset`.
2. Place `run_analysis.R` in the same directory as the `UCI HAR Dataset` folder.
3. Run `source(run_analysis.R)`, which will create a `tidy_dataset.txt` file in the same directory as the R file and the dataset root folder.


### Dependencies
This file depends on reshape2 and data.table.
