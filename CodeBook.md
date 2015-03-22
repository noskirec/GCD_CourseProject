# CodeBook

## Process Flow
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
 
 
### Transformations inside merge_data

- Combining activity labels with the y-labels (`y_train_labels` and `y_test_labels`) so the actual labels for activities will be displayed as WALKING, etc.
- `test_data` is the merged data table of the raw test data with the subject, activity, activity id, and the other 541 variables
- `train_data` is the merged data table of the raw training data with the subject, activity, activity id, and the other 541 variables
- `all_data` is the merged version of `train_data` and `test_data`
