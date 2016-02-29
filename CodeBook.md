

In partial fulfillment of the Coursera Data Science Specialisation: Getting and Cleaning Data course, this CodeBook accompanies the run_analysis.R script and the TidyData.txt file found in the GitHub Repository for user:PamlaM

# Contents
1. Course Project Instructions
2. run_analysis methodology: A description of how the analysis fulfills the project objectives as codified in the script
3. Readme.txt that accompnied original data

***

## 1. Course Project Instructions
One of the most exciting areas in all of data science right now is wearable computing.   
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.  
* A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
* Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* You should create one R script called run_analysis.R that does the following:  
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

***
## 2. run_analysis methodology

The run_analysis.R script will execute five transformations of the HAR dataset:  
1. Merge the training and test sets to create one data set  
2. Extract the mean and standard deviation for each measurement  
3. Rename activities in data set using descriptive names  
4. Appropriately label data set with descriptive variable names  
5. From dataset in Step 4, create a second, independent tidy dataset with the average of each variable for each activity and each subject  

    
Prior to accomplishing the data manipulation, the following prep work was done:  
* defined a variable to keep track of all the environment variables created so they can be removed before the code exits.  
* defined the location of the zipped data and loaded libraries dplyr and reshape2  
* captured user's working directory so we can return there at the end  
* made sure there was local directory for us to work in  
* downloaded the zipped dataset to the new directory  
* unpacked the zip file  
* read in all the data we need  

The data from 30 participants executing 6 activities was split 70/30 into pairs of tables called train and test.  

Now we get to the real work! Items 1-5 were accomplished in the following order:   
1. For each category: subject id, activity id and data, the test and train datasets were read and then merged.  
4. The column names Student_id, Activity_id and the list provided in features.txt were added to the datasets.  
2. Then the student, activity and data sets were combined into one table and only value columns for mean() and std() were retained.  
5. Next the measurements were averaged by student and by activity yielding one average for each participant in each of 6 activities across 68 measures.  (180 rows by 68 columns).  
3. Finally, with this small dataset, descriptive names were added to the activities from the activity_labels.txt file.  

Then some light housekeeping of the environment variables and the working directory
and the TidyData.txt file was written and the tabled viewed.  

***

## 3. Original HAR Data readme.txt
```
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
```

