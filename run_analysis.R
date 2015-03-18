if (!require("data.table")) {
  install.packages("data.table")
}
if (!require("reshape2")) {
  install.packages("reshape2")
}
if (!require("dplyr")) {
  install.packages("dplyr")
}
require("data.table")
require("reshape2")
require("dplyr")

#get labels for data
features = read.table("./UCI HAR Dataset/features.txt")[,2]
activity.labels = read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

#get test data
X_test = read.table("./UCI HAR Dataset/test/X_test.txt")
y_test = read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt")
#label test data
names(X_test) = features
names(subject_test) = "subject"

#remove all values except those with mean or standard deviation
getmeanstd =  grepl("mean|std", features)
X_test = X_test[,getmeanstd]

#Add the name of the activity to the ID in y_test
y_test[,2] = activity.labels[y_test[,1]]
names(y_test) = c("activity_number","Activity")

#combine test data
Test = cbind(as.data.table(subject_test),y_test,X_test)


#get train data
X_train = read.table("./UCI HAR Dataset/train/X_train.txt")
y_train = read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt")
#label train data
names(X_train) = features
names(subject_train) = "subject"

#remove all values except those with mean or standard deviation
X_train = X_train[,getmeanstd]

y_train[,2] = activity.labels[y_train[,1]]
names(y_train) = c("activity_number","Activity")

#combine test data
Train = cbind(as.data.table(subject_train),y_train,X_train)

#merge the test and train sets
Final = rbind(Test, Train)
ID = c("subject", "activity_number", "Activity")
Final_labels = setdiff(colnames(Final), ID)
melted = melt(Final, id = ID, measure.vars = Final_labels)

#apply mean function to dataset
Tidy = dcast(melted, subject + Activity ~ variable, mean)

#print dataset
write.table(Tidy, file = "./Tidy.txt", row.name = FALSE)