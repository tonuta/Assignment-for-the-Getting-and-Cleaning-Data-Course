# install.packages("plyr")
# install.packages("stringr")
# install.packages("data.table")

# library(plyr)
# library(stringr)
# library(data.table)

## Check for the working directory:
# getwd()

## Set a new working directory for this assignment:
# setwd('I:/Coursera/Data Science Certificate/Course3_Getting and Cleaning Data/Assignment/UCI HAR Dataset')

## Script for the run_analysis.R (file saved in the working directory)

## To run the code use:
# source("run_analysis.R")

## Clean the environment

    rm(list = ls())

## Read all the files from "UCI HAR Dataset" directory:
   
    allfiles <- list.files(getwd(), all.files = TRUE, ignore.case = TRUE, recursive = TRUE)
    print(allfiles)

    
## Step 1: Merge the training and the test sets to create one data set:
    

## a) Read in R only the data files related to the purpose of this assigment:

     subject.test <- read.table("./test/subject_test.txt", header = FALSE, sep = "")
#  print(subject.test)
     feature.test <- read.table("./test/X_test.txt", header = FALSE, sep = "")
#  print(feature.test)
    activity.test <- read.table("./test/Y_test.txt", header = FALSE, sep = "")
#  print(activity.test)         
    subject.train <- read.table("./train/subject_train.txt", header = FALSE, sep = "")
#  print(subject.train)
    feature.train <- read.table("./train/X_train.txt", header = FALSE, sep = "")
#  print(feature.train)
   activity.train <- read.table("./train/Y_train.txt", header = FALSE, sep = "")
#  print(activity.train)
  features.labels <- read.table("./features.txt", header = FALSE, sep = "") 
#  print(features.names)
  activity.labels <- read.table("./activity_labels.txt", header = FALSE, sep = "")
#  print(activity.labels)

## b) Understand the properties and structures of the file's variables:

#   print('subject.test', quote = TRUE)
#   str(subject.test)

#   print('feature.test', quote = TRUE)
#   str(feature.test)

#   print('activity.test', quote = TRUE)
#   str(activity.test)
 
#   print('subject.train', quote = TRUE)
#   str(subject.train)

#   print('feature.train', quote = TRUE)
#   str(feature.train)

#   print('activity.train', quote = TRUE)
#   str(activity.train)

## c) Concatenate the data row-by-row:
  
       subject <- rbind(subject.test, subject.train)
       feature <- rbind(feature.test, feature.train)
      activity <- rbind(activity.test, activity.train)

## d) Name the variables in the fiels:
  
           names(subject) <- c("subject")
          names(activity) <- c("activity")
           names(feature) <- features.labels$V2

## e) Merge data columns from all files into a one data set:
           Data1 <- cbind(subject, activity)
           Data2 <- cbind(feature, Data1)
           
           rm(subject.test, activity.test, feature.test, subject.train, activity.train, feature.train, 
              subject, activity, feature) # cleaning the memory from some unneccesaty files for the rest of the program.
           
           
## Step 2: Extract only the measurements on the mean ans standard deviation for each measurement


## a) Extract the mean and standard deviation for each measurement andmake a unique set of data with them
           
           mean.str.data <- features.labels$V2 [grep("mean\\(\\)|Mean\\(\\)|std\\(\\)", features.labels$V2)]
           
           labels <- c(as.character(mean.str.data), "subject", "activity" )
           
           Data3 <- subset(Data2, select = labels)
           
## b) Understand the properties and structures of the variable Data3:

#           print('Data3', quote = TRUE)
           str(Data3)
 
          
## Step 3: Use descriptive activity names to name the activities in the data set

           
## a) Read the descriptive activity names                     
           
           # it was done in the first part of the program when used for reading files as follows:
           # activity.labels <- read.table("./activity_labels.txt", header = FALSE, sep = "")

## b) Check head and tail to see the data:
           
          Data3$activity <- factor(Data3$activity, levels = activity.labels[,1], labels = activity.labels[,2])
           Data3$subject <- as.factor(Data3$subject)
           
#           print(head(Data3$activity,40))
#           print(tail(Data3$activity,40))

           
## Step 4: Appropriately label the data set with descriptive variable names
           
           
           names(Data3) <- str_replace_all(names(Data3), "BodyBody", "Body")
           names(Data3) <- str_replace_all(names(Data3), "^t", "time")
           names(Data3) <- str_replace_all(names(Data3), "^f", "freq")
           names(Data3) <- str_replace_all(names(Data3), "Acc", "Acceler")
           names(Data3) <- str_replace_all(names(Data3), "Gyro", "AngularVelo")
           names(Data3) <- str_replace_all(names(Data3), "Mag", "Magnitude")
           names(Data3) <- str_replace_all(names(Data3), "mean()", "mean")
           names(Data3) <- str_replace_all(names(Data3), "std()", "std")
           
           str(Data3)
           

## Step 5: Create an independant tidy data set with the average of each variable for each activity and each subject
           
           
           
           Final.Data <- aggregate(.~subject + activity, Data3, mean)
           
           Final.Data2 <- Final.Data [order(Final.Data$subject, Final.Data$activity), ]
           
#           write.table(Final.Data2, file = "tidydataset.csv", row.name = FALSE)
          write.table(Final.Data2, file = "tidydataset.txt", row.name = FALSE)
           
           rm(Data3, Final.Data, Final.Data2)          # environment cleaning


## Checking the file at the console          
           
           Tidydata.File <- read.table(file = "tidydataset.txt", header = TRUE)
           head(Tidydata.File)
           print(head(Tidydata.File))
           
