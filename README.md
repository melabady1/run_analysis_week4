# Description of run_analysis.R script
## The script contains the following steps:
1- setting working directory to that folder contains the assignment data "UCI HAR Dataset":

  - here i use setwd to set the working directory if the folder is avilable,otherwise i assume the data is on the root of current working directory.
	
2- read the features names from feature.TXT :
  - in this step i prepare the colnames and what columns we read from the files X_train.txt and X_test.txt .
  - first i read the id and feature name from the file
  - then i set the colclass = "NULL" to all features except the features contains in thier name the keyword "mean()" - "std()" thier class will be numeric.
  - the reason of that we need only variables of mean and std.
3- read the training data:
  - here i read the training data  from the three files subject_train.txt, y_train.txt and X_train.txt and comine them using cbin
  - i use colnames and colclass that are prepared in step2 for the X_train.txt, not colclass = "null" means the column will not be readed
4- read the test data from 
  - same as step 4 but for testing data.
5- combines train and test data using rbind
6- add activity labels to the resulted data frame:
  - reading the activity label file and merge the combined data from the pervious step with the activity labels using activity id.
7- generate tidy data using the average of measurment group by activity and subject using aggregate function.
8- sort the result by subject id then activity id.
9- write the result to file.
10- return the working directory to its pervious value
11- clean up temp variables.
12- view the result using view function.


