# CodeBook


On lines 113-115 of run_analysis.R, there are three statements that encapsulate the data aggregation, cleaning, and tidying processes.

```
merged_data <- merge_data("UCI HAR Dataset")
meanstd_dataset <- extract_meanstd(merged_data, "UCI HAR Dataset")
tidify_data(meanstd_dataset, "./tidy_dataset.txt")
```

## merge_data
### Data: 
The `merge_data` function takes as its argument a file folder/directory where the test and training data is stored. Each file is assigned to a local variable within the function:

- `test/X_test.txt` is assigned to `test_data`, containing all the 541 columns of raw data in the test set
- `train/X_train.txt` is assigned to `train_data`, containing all the 541 columns of raw data in the training set
- `activities.txt` is assigned to `activity_labels`, containing all the different types of activities: `WALKING`, `WALKING_UPSTAIRS`, `SITTING`, etc.
- `test/subject_test.txt` is assigned to `subjtest_data`, containing all the possible subject data inside the test set.
- `train/subject_train.txt` is assigned to `subjtrain_data`, containing all the possible subject data inside the training set.
- `test/y_test.txt` is assigned to `y_test`, containing all the possible label data inside the test set.  
- `train/y_train.txt` is assigned to `y_train`, containing all the possible label data inside the training set.
 
 
### Transformations:

- Combining activity labels with the y-labels (`y_train_labels` and `y_test_labels`) so the actual labels for activities will be displayed as WALKING, etc.
- `test_data` is the merged data table of the raw test data with the subject, activity, activity id, and the other 541 variables.
- `train_data` is the merged data table of the raw training data with the subject, activity, activity id, and the other 541 variables.
- `all_data` is the merged version of `train_data` and `test_data`.


## extract_meanstd
### Data:
As with `merge_data`, this function takes as an argument a file folder containing the file necessary to determine the appropriate column names. Within this folder, the file `features.txt` is assigned to the variable `features_data`, containing all the 541 features and their names.
 
### Transformations:

 -  Use `colnames()` to set the column headers for Subject, Activity, ActivityID, and the associated features.
 - `mean_col` are the indices of columns that contain "mean()".
 - `std_col` are the indices of columns that contain "std(). 
 - `meanstd_col` is the vector containing the `mean_col` and `std_col` indices, and sorted.
 - `extracted_data_set` is the final data table containing Suject, Activity, and ActivityID, and all the columns whose indices are contained within the `meanstd_col` vector.

## tidify_data

### Transformations:

 - `melt_data` is the data after performing `melt` on the `data_set` parameter.
 - `tidy_data` is the data after performing dcast on `melt_data`, providing the mean of the related activities across the different activities and different subjects.
 - `col_names_vector` is the data vector containing new formatted column headers where we replace mean() with Mean, std() with Std, and BodyBody with Body.
 - `tidy_data` has its column headers updated with those in `col_names_vector`.
