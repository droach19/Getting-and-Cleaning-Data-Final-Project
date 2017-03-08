
The included R script - run_analysis.R - allows you to download provided data on wearable computing, manipulate and clean up the data, and perform helpful statistical measurements on the data.

The script renames column headers & merges together the training and test data sets for each subject into the Master_Combined table. Some columns include the mean and/or standard deviation of a body measurement for the designated subject.  It is my intent to extract just these measurements and they are loaded into the Master_Subset and Master_Subset_2 tables.

The Master_Subset_2 table contains 10,299 rows of data with 82 columns: one identifying the SubjectID (1-30), one identifying the Activity Id (1-6), one for Activity Name (walking, walking upstairs, etc.) and 79 measurements.

The Tidy Data Set table contains 180 rows of data - one row for each subject's specific activity, with average measurements in each column.