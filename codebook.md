## This programs runs in the following steps :

1.Downloading the file and saving it in to a folder named DATA
2.Unzipping the file 
3.Reading all the files in the unzipped file in to approprite tables
4. merging columns of tables to form two data sets namely training and testing
5. naming the columns of merged tables of training and testing
6. merging the testing and training data sets to form one mergred data set
7. Subsetting  out a table containing mean and standard values of variables 
8. Using descriptive activity names
9. Creating a new data set with average values of each activity
10. writing a table 

##The following are the vailables used :

- x_training, y_ training, subject_training, x_testing, y_testing, subject_testing  <- variables on to which the data is read
- training  <- dataset containing merged columns of x,y,subject of training
- testing <- dataset containing merged columns of x,y,subject of testing
- data_features <- features values
- activity_labels <- list of activities
- data_merge <- merged data set of training and testing
- data_sorted <- data set with sorted mean and standard values
- data_named <- data set with activities named.
