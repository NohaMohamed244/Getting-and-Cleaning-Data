### downloading and unzipping the data

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","week3.zip")
unzip("week3.zip")


### Merge training and test sets to create one data set

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

features <- read.table("UCI HAR Dataset/features.txt")
labels <- read.table ("UCI HAR Dataset/activity_labels.txt")

x <- rbind(x_test , x_train)
y <- rbind(y_test, y_train)
subject <- rbind(subject_test,subject_train)

### Extracts only the measurements on the mean and standard deviation for each measurement

mean.std <- grep("mean()|std()" , features[,2])
x <- x[,mean.std]


### Uses descriptive activity names to name the activities in the data set
 
names(subject) <- "subject"
names(y) <- "activity"
features_names <- sapply(features[,2],function(x){gsub("[()]","",x)})
names(x) <- features_names[mean.std]
data <- cbind(x,y,subject)

finaldata <- factor(data$activity)
levels(finaldata) <- labels[,2]
data$activity <- finaldata

### Appropriately labels the data set with descriptive variable names

names(data) <- gsub("\\(|\\)","",names(data))
names(data) <- gsub("^t","time",names(data)) 
names(data) <- gsub("^f","Frequency",names(data))
names(data) <- gsub("BodyBody","Body",names(data))
names(data) <- gsub("Mag","Magnitude",names(data))
names(data) <- gsub("Acc","Accelometer",names(data))

### From the data set in the previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

install.packages("plyr")
library(plyr)
second_data <- ddply(data, c("subject","activity"), numcolwise(mean))
write.table(second_data, "task.txt", row.names = FALSE)






