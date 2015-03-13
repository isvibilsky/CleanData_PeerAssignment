# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

# load library
library(dplyr)
# read training data
train <- tbl_df(read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = F))
# read activities id for training data
activity <- tbl_df(read.table("UCI HAR Dataset/train/y_train.txt"))
# read subject id for training data
subject  <- tbl_df(read.table("UCI HAR Dataset/train/subject_train.txt"))
# add the ids as columns to training data
train <- cbind(train, activity, subject)
# reading test data
test <- tbl_df(read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = F))
# reading activities id for test data
activity <- tbl_df(read.table("UCI HAR Dataset/test/y_test.txt"))
# read subject id for training data
subject  <- tbl_df(read.table("UCI HAR Dataset/test/subject_test.txt"))
# add the ids as columns to test data
test <- cbind(test, activity, subject)
# merge training and test data
data <- rbind(train, test)
# remove not required data
rm(list=c("train","test","activity","subject"))
# read lis of features 
features <- tbl_df(read.table("UCI HAR Dataset/features.txt", stringsAsFactors = F))
# create a vector of column names
names <- t(features[,2])
# add the last column for activity id
names  <- c(names, "activity_id", "subject_id")
# assign column names to dataset
colnames(data)  <- names
# create a vector of required columns to keep in the data set mean and standard deviation
# regular expression is used to match on the words mean and std and id
index  <- grep("mean\\(|std\\(|^(.*)_id$",names)
# subset data with the required colums
data  <- data[, index]
# read activity labels
actlabs  <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F)
names(actlabs) <- c("activity_id", "desc")
# replace the id values with its description
data <- mutate(data, activity_id = actlabs[activity_id,"desc"])
# rename the "activity_id" column to "activity"
names(data)[names(data) == "activity_id"]  <- "activity"
# create a new data set with average value for all columns by activity and by subject
data.avg  <- data %>% group_by(activity, subject_id) %>% summarise_each(funs(mean))
write.table(data.avg, "tidy_data.txt", row.names = F)