## downloading the file and saving it in to a folder named DATA

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## Unzipping the file 
unzip(zipfile="./data/Dataset.zip",exdir="./data")


##Reading training files 

x_training <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_training <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_training <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

##merging columns of training

training <- cbind(x_training, y_training, subject_training)
  

##Reading testing files 

x_testing <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_testing <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_testing <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

##merging columns of testing

testing <- cbind(x_testing, y_testing, subject_testing)


## Reading features
data_features <- read.table('./data/UCI HAR Dataset/features.txt')

##Reading labels of activities
activity_labels <- read.table('./data/UCI HAR Dataset/activity_labels.txt')

##naming the merged tables of training and testing

colnames(training) <- c( as.character(data_features[,2]), "activityID","subjectID")
colnames(testing) <- c( as.character(data_features[,2]), "activityID","subjectID")
colnames(activity_labels) <- c("activityID","activity")
## merging the testing and training data

data_merge <- rbind(training, testing)

## sortig out a table containing mean and standard values
a <- sort(c(grep("mean..",colnames(data_merge)),grep("std..",colnames(data_merge))))
data_sort <- data_merge[,c(563,562,as.numeric(a))]

## using descriptive activity names
data_named <- merge(activity_labels,data_sort,by = "activityID",all.x =TRUE)


##Data set with average values of each activity
library(plyr)

average_activity <- aggregate(data_named[,4:ncol(data_named)],by=list(data_named$activityID,data_named$subjectID),FUN= mean)

colnames(average_activity) <- c("activityID","subjectID",colnames(average_activity[,3:ncol(average_activity)]))

data_named_avg <- merge(activity_labels,average_activity,by = "activityID",all.x =TRUE)

x <- arrange(data_named_avg,subjectID)
x <- x[,c(3,1,2,4:ncol(x))]

## writing a table 
write.table(x, "average_activity.txt", row.name=FALSE)

