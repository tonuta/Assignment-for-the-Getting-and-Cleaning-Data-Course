# Assignment-for-the-Getting-and-Cleaning-Data-Course

## Getting and Cleaning Data: Course Project

## Introduction

This repository contains my work for the course project for the Coursera course 
"Getting and Cleaning data", part of the Data Science specialization.

The script called "run_analysis.R" merges the test and training sets together, 
selects the measurements marked with "mean" and "standard deviation", cleaning data 
names, and finally, creates a file with tidy data called "tidydataset.text".

Concisely, the script does the following:

1. Load the the training and test datasets, activity and feature information.
2. Keep the datasets containing the mean and standard deviation for measuremnts.
3. Merge the dataset from step #2 with the activity and subject data
4. Convert the activity and subject data into factors.
5. Create a set of tidy data.


More information about the data analysis, trnasformation, and cleaning can be found 
in the script "run_analysis.R".

## About the Code Book

The CodeBook.md file explains the transformations performed and the resulting data and variables.