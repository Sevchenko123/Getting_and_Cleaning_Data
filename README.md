# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the file and subsequently unzip the file.
2. Load the activity labels and features.
3. Loads both the training and test datasets, with only mean and standard deviation
   columns.
4. Loads the activity and subject data for each dataset, and merge those
   columns with the dataset.
5. Merge the two datasets.
6. Converts the `activity` and `subject` columns into factors.
7. Creates a tidy dataset that consists of the mean value of each
   variable for each subject and activity pair.