# This script solves the course project Analysis and Data Cleaning Coursera. 
# Data were taken from the test and training of human physical activity records on a group of people. 
# Data were obtained from information provided by accelerometers in Galaxy S smartphones.
#
# IMPORTANT: this script uses the libraries:
# reshape2 
# stringr
#
# This script reads the files: 
# features.txt 
# X_train.txt 
# X_test 
# activity_labels.txt 
# y_train.txt 
# y_test.txt 
# subject_train.txt
# subject_test.txt 

#
# Located within the folder: UCI Dataset HAR
#
# features.txt presents the name of 561 features defined in this study.
# X_train.txt presents the results of measurements of 561 features for each subject in training.
# X_test.txt presents the results of measurements of 561 features for each subject in testing.
# activity_labels.txt describes the names or labels of 6 activities developed by each subject in this experiment.
# y_train.txt describes the names or labels of the activities of each of the subjects in training
# y_test.txt describes the names or labels of the activities of each of the subjects in testing
# subject_train.txt identifies the subject developing each training activity
# subject_test.txt identifies the subject developing each testing activity
# 
# The script creates datasets for training and testing and extracts only the measures for mean 
# and standard deviations for each measure of the original data
# Using gsub functions, the names of the activities are reassigned and the names of the features are redefined. 
# The new names of the features are more descriptive than the original.
# Example: the old name of the feature: "tBodyAcc-mean()-X" was
# redefined as : "Timedomain.BodyAcceleration.Average.X" 
# An independent tidy data set with the average of each feature of each activity is created and named
# "means_ttotal.txt". This file is created when the script is run as the Samsumg data is in the working directory
# 


# Read Samsumg data

file_features <- "UCI HAR Dataset/features.txt"
features <- read.table(file_features, header = F, sep=" ",colClasses="character")
file_train <- "UCI HAR Dataset/train/X_train.txt"
file_test <- "UCI HAR Dataset/test/X_test.txt"
file_activity_labels <- "UCI HAR Dataset/activity_labels.txt"
X_train <- read.table(file_train, header=F, dec=".", colClasses="character")
X_train <- as.data.frame(sapply(X_train, as.numeric))
X_test <- read.table(file_test, header=F, dec=".", colClasses="character")
X_test <- as.data.frame(sapply(X_test, as.numeric))
activity_labels <- read.table(file_activity_labels, header=F, colClasses="character")

#Assign features names

colnames(X_train) <- features$V2
colnames(X_test) <- features$V2

file_y_train <- "UCI HAR Dataset/train/y_train.txt"
yy_train <- read.table(file_y_train, header=F, colClasses="character")
file_y_test <- "UCI HAR Dataset/test/y_test.txt"
yy_test <- read.table(file_y_test, header=F, colClasses="character")
file_subject_test <- "UCI HAR Dataset/test/subject_test.txt"
subject_test <- read.table(file_subject_test, header=F, colClasses="character")
file_subject_train <- "UCI HAR Dataset/train/subject_train.txt"
subject_train <- read.table(file_subject_train, header=F, colClasses="character")

# Assign activity labels and subjects for each activity

X_train$activity <- factor(yy_train$V1, labels= activity_labels$V2)
X_train$subject <- subject_train$V1

X_test$activity <- factor(yy_test$V1, labels= activity_labels$V2)
X_test$subject <- subject_test$V1


library(reshape2)

# Consolidate test and train data for subject and activity with melt

dataMelt_test <- melt(X_test, id=c("subject", "activity"), measure.vars = features$V2)
dataMelt_train <- melt(X_train, id=c("subject", "activity"), measure.vars = features$V2)

# calculate mean of train and test data for each combination of activity and for each subject using dcast function

pryData_train_mean <- dcast(dataMelt_train, activity*subject ~ variable, mean) 
pryData_test_mean <- dcast(dataMelt_test, activity*subject ~ variable, mean) # calcula para cada combinacion de activity y subject el valor del promedio de la variable seleccionada antes

# Select the "mean" columns and rename the labels with more readable names in training data

df <- pryData_train_mean
library(stringr)
df1 <- df[,grep("mean", colnames(df))]
colnames(df1) <- gsub(pattern="tBody", replacement="Timedomain.Body", colnames(df1))
colnames(df1) <- gsub(pattern="tGravi", replacement="Timedomain.Gravi", colnames(df1))
colnames(df1) <- gsub(pattern="fBody", replacement="Frequencydomain.Body", colnames(df1))
colnames(df1) <- gsub(pattern="-", replacement=".", colnames(df1))
colnames(df1) <- gsub(pattern="mean", replacement="Average", colnames(df1))
colnames(df1) <- gsub(pattern="Acc", replacement="Acceleration", colnames(df1))
colnames(df1) <- str_replace_all(colnames(df1), "([()])","")

# Select the "std" columns and rename the labels with more readable names in training data

df2 <- df[,grep("std", colnames(df))]
colnames(df2) <- gsub(pattern="tBody", replacement="Timedomain.Body", colnames(df2))
colnames(df2) <- gsub(pattern="tGravi", replacement="Timedomain.Gravi", colnames(df2))
colnames(df2) <- gsub(pattern="fBody", replacement="Frequencydomain.Body", colnames(df2))
colnames(df2) <- gsub(pattern="-", replacement=".", colnames(df2))
colnames(df2) <- gsub(pattern="mean", replacement="Average", colnames(df2))
colnames(df2) <- gsub(pattern="Acc", replacement="Acceleration", colnames(df2))
colnames(df2) <- str_replace_all(colnames(df2), "([()])","")

df_train_mean <-cbind(df1,df2)

# NA columns in data frame are eliminated

df_train_mean <- df_train_mean[,apply(df_train_mean,2, function(x){!all(is.na(x))})]

df_train_mean$subject <- pryData_train_mean$subject
df_train_mean$activity <- pryData_train_mean$activity


df <- pryData_test_mean

# Select the "mean" columns and rename the labels with more readable names in testing data

df1 <- df[,grep("mean", colnames(df))]
colnames(df1) <- gsub(pattern="tBody", replacement="Timedomain.Body", colnames(df1))
colnames(df1) <- gsub(pattern="tGravi", replacement="Timedomain.Gravi", colnames(df1))
colnames(df1) <- gsub(pattern="fBody", replacement="Frequencydomain.Body", colnames(df1))
colnames(df1) <- gsub(pattern="-", replacement=".", colnames(df1))
colnames(df1) <- gsub(pattern="mean", replacement="Average", colnames(df1))
colnames(df1) <- gsub(pattern="Acc", replacement="Acceleration", colnames(df1))
colnames(df1) <- str_replace_all(colnames(df1), "([()])","")

# Select the "std" columns and rename the labels with more readable names in testing data

df2 <- df[,grep("std", colnames(df))]
colnames(df2) <- gsub(pattern="tBody", replacement="Timedomain.Body", colnames(df2))
colnames(df2) <- gsub(pattern="tGravi", replacement="Timedomain.Gravi", colnames(df2))
colnames(df2) <- gsub(pattern="fBody", replacement="Frequencydomain.Body", colnames(df2))
colnames(df2) <- gsub(pattern="-", replacement=".", colnames(df2))
colnames(df2) <- gsub(pattern="mean", replacement="Average", colnames(df2))
colnames(df2) <- gsub(pattern="Acc", replacement="Acceleration", colnames(df2))
colnames(df2) <- str_replace_all(colnames(df2), "([()])","")

df_test_mean <-cbind(df1,df2)

# NA columns in data frame are eliminated

df_test_mean <- df_test_mean[,apply(df_test_mean,2, function(x){!all(is.na(x))})]


df_test_mean$subject <- pryData_test_mean$subject
df_test_mean$activity <- pryData_test_mean$activity

#Some test values as references

#df_train_mean[df_train_mean$subject=="25" & df_train_mean$activity=="WALKING_UPSTAIRS","Frequencydomain.BodyAcceleration.std.Y"]
#df_train_mean[df_train_mean$subject=="25" & df_train_mean$activity=="WALKING","Frequencydomain.BodyAcceleration.Average.Y"]
#df_train_mean[df_train_mean$subject=="22" & df_train_mean$activity=="WALKING","Frequencydomain.BodyAcceleration.std.X"]
#df_train_mean[df_train_mean$subject=="1" & df_train_mean$activity=="WALKING","Timedomain.BodyAcceleration.Average.X"]

#
# Creates the independent tidy data set with average of each of each feature(variable) for each activity and 
# for each subject consolidating training and testing data
# 
# Labels names are redefined in the consolidated Merged data with the extensions .Train and . Test 
# for training and testing features
#
# The file "means_ttotal.txt" in the main directory stores the tidy data set with the averages of each variable 
# for each activiyy and each subject
#

mergedData <- merge(df_test_mean, df_train_mean, by.x=c("subject", "activity"), by.y=c("subject", "activity"), all =T) #pega 
colnames(mergedData) <- gsub(pattern=".x", replacement=".Train", colnames(mergedData))
colnames(mergedData) <- gsub(pattern=".y", replacement=".Test", fixed=TRUE, colnames(mergedData))
write.table(mergedData, "means_ttotal.txt")





