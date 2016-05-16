
# Coursera
# Getting and Cleaning Data - Final Course Assignment
# By: Theodor Stenevang Klemming

# SECTION 1

require(tidyr)
require(dplyr)

# Set the working directory to the location of the 
# <test> and <train> folders included in the assignment data zip
# available on https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
setwd("C:/Users/theod/Documents/Learning_R/03 Getting and Cleaning Data/final/UCI HAR Dataset")

# SECTION 2

col_nms <- read.csv("features.txt", header=F, colClasses=c("character", "character"), stringsAsFactors = F, sep=" ") # we want 2 column
col_nms <- col_nms[,2] # keeping column names without numbering
actlables <- read.csv("activity_labels.txt", header=F, sep=" ", stringsAsFactors = F, col.names=c("code", "activity"))

# SECTION 3

getthedata <- function(arg_maindata, arg_activitynames, arg_subjects) {
        maindata <- read.csv(arg_maindata, header=F, colClasses="character") # one wide column
        maindata$V1 <- trimws(maindata$V1, which="both") #trim left and right white space
        maindata$V1 <- gsub("  "," ",maindata$V1) #double-space to single space
        maindata <- tidyr::separate(maindata, V1, col_nms, sep=" ") #split on space into many columns
        activitycodes <- read.csv(arg_activitynames, header=F, col.names="activitycode")
        activitynames <- merge(activitycodes, actlables, by.x="activitycode", by.y="code")
        subjects <- read.csv(arg_subjects, header=F, col.names="subject")
        completedata <- cbind(subjects, activitynames, maindata)
        return(completedata)
        }

train <- getthedata("./train/X_train.txt", "./train/y_train.txt", "./train/subject_train.txt")
test  <- getthedata("./test/X_test.txt",   "./test/y_test.txt", "./test/subject_test.txt")

traintest <- rbind(train, test)

rm(col_nms)
rm(actlables)
rm(train)
rm(test)
rm(getthedata)

# SECTION 4

# finding mean() and std() columns
col_nms <- colnames(traintest)
keepers <- grep(".*mean\\(\\).*|.*std\\(\\).*",col_nms)
traintest <- traintest[,c(1:3,keepers)]

rm(col_nms)
rm(keepers)

# SECTION 5

# converting from char to numeric
for (i in 4:ncol(traintest)) {
        traintest[,i] <- as.numeric(traintest[,i])
}

rm(i)

# SECTION 6

# calculating the average (mean) for each measure grouped by subject and activity using dplyr
traintest_avg <- traintest %>% group_by(subject, activitycode, activity) %>% summarize_each(funs(mean))

# SECTION 7

# changin working directory to local hit repo directory
setwd("C:/Users/theod/Documents/Git/DataScienceSpecialization/03_Getting_and_Cleaning_Data/GettingAndCleaningDataCourseProject")

write.csv(traintest, file="traintest.csv", quote=F, row.names=F)
write.csv(traintest_avg, file="traintest_avg.csv", quote=F, row.names=F)

rm(traintest)
rm(traintest_avg)
