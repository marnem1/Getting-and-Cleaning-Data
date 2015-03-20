# Getting and Cleaning Data

The script `run_analysis.R` performs these 5 steps:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard devation for each measurement.

3. Uses descriptive activity names to name the activities in the data set.

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Variables

* `X_train`, `y_train`, and `subject_train` contain the training set from the files
* `X_test`, `y_test`, and `subject_test` contain the test set from the files
* `X_test` and `X_train` are modified to only contain the columns with mean and standard deviation
* `features` contains the correct names for `X_test` and `X_train`
* `activity.labels` is the correct names for `y_train` and `y_test`
* `Train` combines `subject_train`, `y_train`, and `X_train`
* `Test` combines `subject_test`, `y_test`, and `X_test`
* `Final` combines `Train` and `Test`
* `Melted` adds column names to `Final` and merges the variables correctly
* `Tidy` is the final variable that gets the mean for all the values for each activity and subject