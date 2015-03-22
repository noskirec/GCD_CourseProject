# Getting and Cleaning Data Course Project

merged_data <- merge_data("UCI HAR Dataset")


####################################################################
# 1. Merges the training and the test sets to create one data set. #
####################################################################
# Reads in the location of the directory (assuming same path as current file)
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

