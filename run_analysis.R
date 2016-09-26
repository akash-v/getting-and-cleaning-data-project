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
data_sort <- data_merge[,c(as.numeric(a),562,563)]

## using descriptive activity names
data_named <- merge(data_sort,activity_labels,by = "activityID",all.x =TRUE)

##Data set with average values of each activity
average_activity <- aggregate(. ~subjectID + activityID, data_named, mean)
average_activity <- average_activity[order(average_activity$subjectID, average_activity$activityID),]

## writing a table 
write.table(average_activity, "average_activity.txt", row.name=FALSE)