
# Coursera
# Getting and Cleaning Data - Final Course Assignment
# By: Theodor Stenevang Klemming

# SECTION 1

require(data.table)
require(dplyr)

# saving the currect working directory to set it back later
previous_wd <- getwd()

# Set the working directory to the location of the 
# <test> and <train> folders included in the assignment data zip
# available on https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
setwd("C:/Users/theod/Documents/Learning_R/03 Getting and Cleaning Data/final/UCI HAR Dataset")

# SECTION 2

col_nms <- read.csv("features.txt", header=F, colClasses=c("character", "character"), stringsAsFactors = F, sep=" ") # we want 2 column
col_nms <- col_nms[,2] # keeping column names without numbering

# SECTION 3

getthedata <- function(arg_maindata, arg_activitycodes, arg_subjects) {
        maindata <- fread(arg_maindata)
        colnames(maindata) <- col_nms
        activitycodes <- fread(arg_activitycodes, header=F, col.names="activitycode")
        subjects <- fread(arg_subjects, header=F, col.names="subject")
        completedata <- cbind(subjects, activitycodes, maindata)
        return(completedata)
        }

train <- getthedata("./train/X_train.txt", "./train/y_train.txt", "./train/subject_train.txt")
test  <- getthedata("./test/X_test.txt",   "./test/y_test.txt", "./test/subject_test.txt")


# SECTION 4
traintest <- rbind(train, test)
actlables <- read.csv("activity_labels.txt", header=F, sep=" ", stringsAsFactors = F, col.names=c("activitycode", "activity"))
traintest <- merge(actlables, traintest)

rm(col_nms)
rm(actlables)
rm(train)
rm(test)
rm(getthedata)

# SECTION 5

# finding mean() and std() columns
col_nms <- colnames(traintest)
keepers <- grep(".*mean\\(\\).*|.*std\\(\\).*",col_nms)
traintest <- traintest[,c(1:3,keepers)]

rm(col_nms)
rm(keepers)

# SECTION 6

# converting from char to numeric
for (i in 4:ncol(traintest)) {
        traintest[,i] <- as.numeric(traintest[,i])
}

rm(i)

# SECTION 7

# calculating the average (mean) for each measure grouped by subject and activity using dplyr
traintest_avg <- traintest %>% group_by(activitycode, activity, subject) %>% summarize_each(funs(mean))

# SECTION 8

# changing working directory to local Git repo directory
setwd("C:/Users/theod/Documents/Git/DataScienceSpecialization/03_Getting_and_Cleaning_Data/GettingAndCleaningDataCourseProject")

# saving column names separately, since loading the txt data files later into R will distort the column names
# thanks to this, the column names with dashes and brackets can be restored after loading data into R
traintest_column_names <-colnames(traintest)
write.table(traintest_column_names, file="traintest_column_names.txt", quote=F, row.names=F, col.names=F)

traintest_avg_column_names <-colnames(traintest_avg)
write.table(traintest_avg_column_names, file="traintest_avg_column_names.txt", quote=F, row.names=F, col.names=F)

write.table(traintest, file="traintest.txt", quote=F, row.names=F)
write.table(traintest_avg, file="traintest_avg.txt", quote=F, row.names=F)


rm(traintest)
rm(traintest_avg)
rm(traintest_column_names)
rm(traintest_avg_column_names)

setwd(previous_wd)

rm(previous_wd)
