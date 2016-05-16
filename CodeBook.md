
# Final assignment in "Getting and Cleaning Data" on Coursera, May 2016
Submitted by Theodor Stenevang Klemming

## Background and instructions followed
This assignment uses data available from this URL (the "assignment data")
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data was produced in a research project presented here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Description of the assignment
The assignment instructions were to create an R-script that would

1. Merge the training and the test sets from the assignment data to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

All of the above is achieved by the submitted script in the file run_analysis.R


## Description of R code in run_analysis.R

### SECTION 1
The packages tidyr and dplyr are loaded.
The working directory is set to the location of the assignment data after unzipping the zip-file to disk

### SECTION 2
A character vector called col_nms is created, containing the 561 names of features collected by gyro sensors in the research project.
A data frame called actlables is created, containing 6 different activity codes with the corresponding activity names.

### SECTION 3
A function that loads data, getthedata, is defined and called for the training data, and for the test data.
The function starts by loading the data, which is fixed column width, into a single-column data frame.
Trailing and leading white space is trimmed, and double space is changed into single space. Following that, the separate function from tidyr can be used to split up the single column into 561 columns, on for each feature (each measure).
A data frame containing activity codes is created, with a row count matching that of the main data.
actlables data frame created in SECTION 2, containing the clear text activity names, is joined with the activity codes data frame.
A data frame containing the subject code for each row is created.
The main data, and the activity data and the subject data is put together using cbind (they have identical row counts)
The resulting data frames "train" and "test" have identical column structure by different row count (approx 70% vs 30%), and are merged using rbind (similar to a UNION ALL operation in SQL)

### SECTION 4
The assignment, as described in point 2, is to keep only measure columns that contain a mean or a standard deviation value. The correct columns are indicated by the column titles originally fetched in SECTION 2 from the file features.txt in the assignment data, and described in a file named features_info.txt in the assignment data. 
By putting all the column namnes of the "traintest" data frames in a vector, and checking that vector for values containing "mean()" OR "std()", the desired subset of columns is found and the index numbers of those columns are assigned to a vector "keepers", which is used for subsetting the "traintest" data frame.

### SECTION 5
At this point, the remaining number of measure columns are 66 out of the original 561. They are still all of data type character, and by iterating over all of the columns from and including column nr 4 to and including the last column, the data type is changed from character to numeric.

### SECTION 6
This is regarding point 5 in the assignment instructions, where the large number of rows (10,299) will be reduced by calculating the average value for each measure column, grouped by subject and activity. This is done using the dplyr package, making use of piped syntax.

### SECTION 7
Finally, the data sets created, "traintest" and "traintest_avg", are writted to disk as csv files in the local Github repository to be included in the commit and push to Github.




## License information from the README.txt of the assignment zip file.
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.