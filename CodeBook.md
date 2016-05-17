
# Code Book
## Final Assignment, Getting and Cleaning Data
Submitted by: Theodor Stenevang Klemming

## Data files in this repo
This repo contains my submission of the final assignment in the Coursera course Getting and Cleaning Data.
There are 4 data files in the repository:

1. traintest.txt
2. traintext_avg.txt
3. traintest_column_names.txt
4. traintest_avg_column_names.txt

All of these files were produced from files available in this zip file, by following the assignment instructions:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The zip file linked above contains descriptive info files that explain the content of the data files:
- activity_labels.txt
- features.txt
- features_info.txt
- README.txt


### traintest.txt
This file contains data from  
./train/subject_train.txt  
./train/X_train.txt  
./train/y_train.txt  
./test/subject_test.txt  
./test/X_test.txt  
./test/y_test.txt  

After reducing the the number of measure columns in accordance with the assignment instructions, the file contains the following columns:

####DIMENSIONS: 3
activitycode: integer 1:6, indicating type of activity
activity: character, describing activity, 6 different values
subject: integer 1:30, specifying 30 different persons used in the experiment to collect data from a smart phone

####MEASURES: 66
These measures are a selection of what in the original data is 561 measures (referred to as features).
Here, the mean and standard deviation columns have been kept, which were estimated from the collected data by the researchers in the project. The unit if the measures is standard gravity units 'g'


**This is how the features are descibed in the file features_info.txt:**

*"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.* 

*Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).* 

*Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).* 

*These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."*

tBodyAcc-mean()-X  
tBodyAcc-mean()-Y  
tBodyAcc-mean()-Z  
tBodyAcc-std()-X  
tBodyAcc-std()-Y  
tBodyAcc-std()-Z  
tGravityAcc-mean()-X  
tGravityAcc-mean()-Y  
tGravityAcc-mean()-Z  
tGravityAcc-std()-X  
tGravityAcc-std()-Y  
tGravityAcc-std()-Z  
tBodyAccJerk-mean()-X  
tBodyAccJerk-mean()-Y  
tBodyAccJerk-mean()-Z  
tBodyAccJerk-std()-X  
tBodyAccJerk-std()-Y  
tBodyAccJerk-std()-Z  
tBodyGyro-mean()-X  
tBodyGyro-mean()-Y  
tBodyGyro-mean()-Z  
tBodyGyro-std()-X  
tBodyGyro-std()-Y  
tBodyGyro-std()-Z  
tBodyGyroJerk-mean()-X  
tBodyGyroJerk-mean()-Y  
tBodyGyroJerk-mean()-Z  
tBodyGyroJerk-std()-X  
tBodyGyroJerk-std()-Y  
tBodyGyroJerk-std()-Z  
tBodyAccMag-mean()  
tBodyAccMag-std()  
tGravityAccMag-mean()  
tGravityAccMag-std()  
tBodyAccJerkMag-mean()  
tBodyAccJerkMag-std()  
tBodyGyroMag-mean()  
tBodyGyroMag-std()  
tBodyGyroJerkMag-mean()  
tBodyGyroJerkMag-std()  
fBodyAcc-mean()-X  
fBodyAcc-mean()-Y  
fBodyAcc-mean()-Z  
fBodyAcc-std()-X  
fBodyAcc-std()-Y  
fBodyAcc-std()-Z  
fBodyAccJerk-mean()-X  
fBodyAccJerk-mean()-Y  
fBodyAccJerk-mean()-Z  
fBodyAccJerk-std()-X  
fBodyAccJerk-std()-Y  
fBodyAccJerk-std()-Z  
fBodyGyro-mean()-X  
fBodyGyro-mean()-Y  
fBodyGyro-mean()-Z  
fBodyGyro-std()-X  
fBodyGyro-std()-Y  
fBodyGyro-std()-Z  
fBodyAccMag-mean()  
fBodyAccMag-std()  
fBodyBodyAccJerkMag-mean()  
fBodyBodyAccJerkMag-std()  
fBodyBodyGyroMag-mean()  
fBodyBodyGyroMag-std()  
fBodyBodyGyroJerkMag-mean()  
fBodyBodyGyroJerkMag-std()  


### traintest_avg.txt
This file is an aggregation of traintest.txt, where each measure column has been aggregated and grouped by the dimensions activitycode, activity and subject (there is a one-to-one value relationship between activitycode and activity in the data). The aggregation method for each column is mean.The columns in this file are the exact same as in traintext.txt, with the different that there is only 1 row of data per combination of activity and subject, meaning 30x6 = 180 rows of data, where each row contains a mean value from the original full data set.


### traintest_column_names.txt
This file documents the column titles as they are in the file traintest.txt, since the column titles will be distorted after loading the data back into R, due to dashes and bracktes getting replaced with dots.


### traintest_avg_column_names.txt
This file documents the column titles as they are in the file traintest_avg.txt, since the column titles will be distorted after loading the data back into R, due to dashes and bracktes getting replaced with dots.
