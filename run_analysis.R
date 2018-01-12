##step 1 - set working directory to the folder contains 
## the assignment extracted data
dir = "./UCI HAR Dataset";
org_wd = getwd()
if(dir.exists(dir))
{
  setwd(dir)
}

##step 2 - read the features names from feature.TXT
## and set the colclass of each feature that does not contains mean() or std()
## in its name to "NULL" otherwith the colclass will be numeric
features <- read.table("./features.txt",
                       header = F, colClasses = c("integer", "character"), 
                       col.names = c("id", "name"))
features$colclass <- "NULL"
features[grep("mean\\(\\)|std\\(\\)",features[[2]],
              ignore.case = TRUE), "colclass"] <- "numeric"

##step 3 - read the training data from 
## the three files subject_train.txt, y_train.txt and X_train.txt
## and comine them using cbind
train_data <- read.table("./train/subject_train.txt",
                         header = F, colClasses = "numeric",
                         col.names = "subjectId")
train_data <- cbind(train_data, read.table("./train/y_train.txt",
                                           header = F, colClasses = "numeric",
                                           col.names = "activityId"))
train_data <- cbind(train_data, read.table("./train/X_train.txt",
                                           header = F, colClasses = features[["colclass"]],
                                           col.names = features[["name"]] ))

##step 4 - read the test data from 
## the three files subject_test.txt, y_test.txt and X_test.txt
## and comine them using cbind
test_data <- read.table("./test/subject_test.txt",
                        header = F, colClasses = "numeric",
                        col.names = "subjectId")
test_data <- cbind(test_data, read.table("./test/y_test.txt",
                                         header = F, colClasses = "numeric",
                                         col.names = "activityId"))
test_data <- cbind(test_data, read.table("./test/X_test.txt",
                                         header = F, colClasses = features[["colclass"]],
                                         col.names = features[["name"]] ))

##step 5 - combines train and test data using rbind
combined_data <- rbind(train_data, test_data)

##step 6 - read the activity label file and merge the combined data from
## the pervious step with the activity labels using activity id.
activities <- read.table("./activity_labels.txt", 
                         header = F, colClasses = c("integer", 
                                                    "character"), 
                         col.names = c("activityId", "activity"))
combined_data <- merge(activities, combined_data, by = "activityId")

##step 7 - generate tidy data using the average of measurment group by 
## activity and subject.
tidy_data <- aggregate(x= combined_data[4:ncol(combined_data)],
                       combined_data[c("subjectId",
                                       "activityId", 
                                       "activity")],
                       mean)

##step 8 - sort the result by subject id then activity id.
tidy_data <- tidy_data[order(tidy_data$subjectId, tidy_data$activityId),]

##step 9 - remove activity id and then write the result to file.
tidy_data <- tidy_data[c(1, 3:ncol(tidy_data))]
write.table(tidy_data,file = "./tidy_data.txt", row.name=FALSE )

##step 10 - return the working directory to its pervious value

setwd(org_wd)

##step 11 - clean up temp variables.
rm(dir)
rm(org_wd)
rm(features)
rm(activities)
rm(train_data)
rm(test_data)
rm(combined_data)

##step 12 - view the result.
View(tidy_data)

