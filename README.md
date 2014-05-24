Getting-and-Cleaning-data-Final-Project-Repo
============================================
This script solves the course project Analysis and Data Cleaning Coursera. 
Data were taken from the test and training of human physical activity records on a group of people. 
Data were obtained from information provided by accelerometers in Galaxy S smartphones.

IMPORTANT: this script uses the libraries:
* reshape2 
* stringr

This script reads the files: 
* features.txt 
* X_train.txt 
* X_test 
* activity_labels.txt 
* y_train.txt 
y_test.txt 
* subject_train.txt
* subject_test.txt 


Located within the folder: UCI Dataset HAR

* features.txt presents the name of 561 features defined in this study.
* X_train.txt presents the results of measurements of 561 features for each subject in training.
* X_test.txt presents the results of measurements of 561 features for each subject in testing.
* activity_labels.txt describes the names or labels of 6 activities developed by each subject in this experiment.
* y_train.txt describes the names or labels of the activities of each of the subjects in training
* y_test.txt describes the names or labels of the activities of each of the subjects in testing
* subject_train.txt identifies the subject developing each training activity
* subject_test.txt identifies the subject developing each testing activity
 
The script creates datasets for training and testing and extracts only the measures for mean 
and standard deviations for each measure of the original data
Using gsub functions, the names of the activities are reassigned and the names of the features are redefined. 
The new names of the features are more descriptive than the original.
Example: the old name of the feature: "tBodyAcc-mean()-X" was
redefined as : "Timedomain.BodyAcceleration.Average.X" 
An independent tidy data set with the average of each feature of each activity is created and named
"means_ttotal.txt". This file is created when the script is run as the Samsumg data is in the working directory
 
First, the script reads Samsumg data. After, assigns features names and activity labels and subjects for each activity.
After, consolidate test and train data for subject and activity with the function melt from reshape2 library and 
calculate mean of train and test data for each combination of activity and for each subject using dcast function.

After, the script selects the "mean" and "std" columns and rename the labels with more readable names in training and 
testing data.

Finally, it creates the independent tidy data set with average of each of each feature(variable) for each activity and 
for each subject consolidating training and testing data. Labels names are redefined in the consolidated Merged data 
with the extensions .Train and . Test for training and testing features.

The file "means_ttotal.txt" in the main directory stores the tidy data set with the averages of each variable 
for each activiyy and each subject






 
 
 
 
 
 
 
 
 
 
 
 
 
 
