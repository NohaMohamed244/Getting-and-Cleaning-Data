### downloading and unzipping the data

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","week3.zip")
unzip("week3.zip")


### Merge training and test sets to create one data set

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(subject_test , subject_train)

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x <- rbind(x_test , x_train)

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y <- rbind(y_test , y_train)


### Extracts only the measurements on the mean and standard deviation for each measurement

features <- read.table("UCI HAR Dataset/features.txt")
mean.std.features <- grep("mean|std" , features[,2]) 
mean.std <- x[ , mean.std.features] 


### Uses descriptive activity names to name the activities in the data set

labels <- read.table ("UCI HAR Dataset/activity_labels.txt")
labels <- as.character(labels[ ,2])


### Appropriately labels the data set with descriptive variable names

var_names <- cbind(subject , x , y)
str(var_names)


### From the data set in the previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata <- aggregate (var_names , by=var_names, FUN = mean)
