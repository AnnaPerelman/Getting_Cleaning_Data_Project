#Code book for course project Getting and Cleaning Data

##List of variables
trainig_set - the result of reading training set into R from "X_train.txt"
test_set - the result of reading test set into R from "X_test.txt"
ttl_set - merging of two above
features - the result of reading "features.txt" into R
mean_std_variables - a vector containing numbers of columns with mean or std in
their names, extracted from features
mean_std_data - subset of these columns from the ttl_set
training_labels - the result fo reading "y_train.txt" into R
test_labels - the result fo reading "y_test.txt" into R
ttl_labels - merging of two above
mean_std_data$act_codes - new column with the labels
act_lbls - the result of reading "activity_labels.txt" into R
act_names - a vector with the names of the activities
mean_std_data$act_names - new column with the names of the activities
mean_std_var_names - a vector of all variables' names from features
var_names - the above + new columns "act_codes" and "act_names"
train_subject - the result of reading "subject_train.txt" into R
test_subject - the result of reading "subject_test.txt" into R
ttl_subjects - merging of two above
mean_std_data$subjects - new column to our data set
grouped_mean_data - the data set grouped by the activity and the subject
mean_calc_grouped_mean_data - data set with the means calculated (tbl)
final_data_set - tidy data set as data.frame

##The analysis - step by step
The analysis is performed by one script named "run.analysis.R"

Step 1: the script merges the training and the test sets to create one data set.
This data set is called "ttl_set" .
For this purpose the script does the following:
1.Reads training and test sets into R (training to "trainig_set", test to "test_set")
2.Merges the training and the test sets to create one data set "ttl_set"

Step 2: the script extracts only the measurements on the mean and standard deviation for each measurement.
Assumption: all the variables listed in "features.txt" containing "mean"
or "std" in their names are the measurements on the mean and standard deviation
For this purpose the script does the following:
1.Reads features.txt into R to "features"
2.Builds a vector containing numbers of columns,which refelct the measurements on the mean and standard deviation. This vector is called "mean_std_variables"
3.Subsets these columns from the merged data set to mean_std_data

Step 3: the script uses descriptive activity names to name the activities in the data set. For this purpose the script does the following:
1.Reads labels info into R (training to training_labels, test to test_lables)
2.Merges these two vectors into one called ttl_labels
3.Adds this as a new column to the extracted data set as mean_std_data$act_codes
4.Reads activity labels info into R - act_lbls
5.Creats a vector with the names of the activities - act_names
6.Adds descriptive activity names to name the activities in the data set as 
mean_std_data$act_names

Step 4: the script appropriately labels the data set with descriptive variable names
For this purpose the script does the following:
1.Creats a vector of all variables' names from features (mean_std_var_names)
and added columns ("act_codes","act_names"). This vector is called "var_names"
2.Labels appropriately the data set with descriptive variable names

Step 5: from the data set in step 4, the script creates a second, independent tidy data set named "final_data_set" with the average of each variable for each activity and each subject. For this purpose the script does the following:
1.Reads the subjects into R (train to train_subject, test to test_subject)
2.Adds subject column to our extracted data set (from ttl_subjects vector, the result of merging train and test subjects to mean_std_data$subjects)
3.Groupps data by subjects and activities to "grouped_mean_data"
4.Calculates mean by subject and activity for each variable 
to "mean_calc_grouped_mean_data" and creats new data set "final_data_set"
5.Creates txt file for submission "Tidy data set.txt"

