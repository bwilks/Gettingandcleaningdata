# Gettingandcleaningdata

When The run_analysis.R file is run it will create a the GACData_results.txt file. 

It takes raw data from a study (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) that used smart phones to measure movement of subject doing various activities.

Details on how the data was manipulated are documented in withing the code itself and are also summarized below.

1. Data was downloaded from the website and stored locally.
2. The individual data files were read into data frames.
3. The separate files for activity, subject and feature measurements were combined into a file for test data then training data.
4. Test and train data were combined into one data frame set.
5. All measurements were removed that were not mean or standard deviation.
6. The Activity IDs were replaced with words instead of numbers.
7. A final data set was created that averaged all the remaining measures for each subject by activity.
8. Finally the data was exported to the GACData_results.txt file.

