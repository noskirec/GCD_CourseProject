# Getting and Cleaning Data Course Project


#############################################################################
# 1. Merges the training and the test sets to create one data set.          #
# 3. Uses descriptive activity names to name the activities in the data set.#
# 4. Appropriately labels the data set with descriptive variable names.     #
#############################################################################

# Reads in the location of the directory (assuming same path as current file)
# and grabs all the appropriate data, combining it into one data set with
# appropriate and descriptive variable names.
merge_data <- function(fileFolder) {
  # Grabs test and training data
  test_path <- paste("./", fileFolder, "/test/X_test.txt", sep="")
  test_data <- read.table(test_path)
  train_path <- paste("./", fileFolder,"/train/X_train.txt", sep="")
  train_data <- read.table(train_path)
  
  # Grabs activity labels
  activity_path <- paste("./", fileFolder, "/activity_labels.txt", sep="")
  activity_labels <- read.table(activity_path)
  
  # Grabs test and training subject labels
  subjtest_path <- paste("./", fileFolder, "/test/subject_test.txt", sep="")
  subjtest_data <- read.table(subjtest_path)
  subjtrain_path <- paste("./", fileFolder, "/train/subject_train.txt", sep="")
  subjtrain_data <- read.table(subjtrain_path)
  
  # Grabs test and training y labels
  ytest_path <- paste("./", fileFolder, "/test/y_test.txt", sep="")
  y_test <-read.table(ytest_path)
  ytrain_path <- paste("./", fileFolder, "/train/y_train.txt", sep="")
  y_train <-read.table(ytrain_path)
  
  # Merges y- and activity-labels for testing and training
  y_test_labels <- merge(y_test, activity_labels, by="V1")
  y_train_labels <- merge(y_train, activity_labels, by="V1")
  
  # Munge subject labels, y-activity labels, and data together for testing and training
  test_data <- cbind(subjtest_data, y_test_labels, test_data)
  train_data <- cbind(subjtrain_data, y_train_labels, train_data)
  
  # Merge test and training set together
  all_data <-rbind(test_data, train_data)
  
  return(all_data)
}


#########################################################################
# 2. Extracts only the measurements on the mean and standard deviation  #
#    for each measurement.                                              #
# 4. Appropriately labels the data set with descriptive variable names. #
#########################################################################

# For a data set and directory, grabs the appropriate "mean" and "std" columns
# from a data set. Adds more descriptive variable names for "Subject", "ActivityID",
# and "Activity".
extract_meanstd <- function(dataset, fileFolder) {
  # Grabs feature data from the .txt file
  feat_path <- paste("./", fileFolder, "/features.txt", sep="")
  features_data <-read.table(feat_path)
  
  # Sets column headers for combined data 
  # Merges feature data labels with Subject, ActivityID, and Activity
  colnames(dataset) <- c("Subject", "ActivityID", "Activity", as.vector(features_data[,2]) )
  
  # Extract column numbers for columns with "mean()" and for columns with "std()" 
  mean_col <- grep("mean()", colnames(dataset), fixed = TRUE)
  std_col <- grep("std()", colnames(dataset), fixed = TRUE)
  
  # Create vector of all column numbers with either "mean" or "std"
  meanstd_col <- c(mean_col, std_col)
  
  # Sort the vector to use in subsetting
  meanstd_col <- sort(meanstd_col)
  
  # Extract Subject, ActivityID, Activity, and all mean/std columns
  extracted_data <- dataset[,c(1,2,3, meanstd_col)]
  return(extracted_data)
}


###############################################################################
# 4. Appropriately labels the data set with descriptive variable names.       #
# 5. From the data set in step 4, creates a second, independent tidy data set #
#    with the average of each variable for each activity and each subject.    #
###############################################################################


tidify_data <- function(data_set, path_to_tidyset_file) {
  require(reshape2)
  # Melt the data
  melt_data <- melt(data_set, id=c("Subject","ActivityID","Activity"))
  
  # Cast the data back into a tidy format
  tidy_data <- dcast(melt_data, formula = Subject + ActivityID + Activity ~ variable, mean)
  
  # Format/clean the column names further
  col_names_vector <- colnames(tidy_data)
  col_names_vector <- gsub("-mean()","Mean",col_names_vector,fixed=TRUE)
  col_names_vector <- gsub("-std()","Std",col_names_vector,fixed=TRUE)
  col_names_vector <- gsub("BodyBody","Body",col_names_vector,fixed=TRUE)
  
  # Add column names back to tidy_data
  colnames(tidy_data) <- col_names_vector
  
  # Write tidy data back to .txt file
  write.table(tidy_data, file=path_to_tidyset_file, sep="\t", row.names=FALSE)
}

merged_data <- merge_data("UCI HAR Dataset")
meanstd_dataset <- extract_meanstd(merged_data, "UCI HAR Dataset")
tidify_data(meanstd_dataset, "./tidy_dataset.txt")
