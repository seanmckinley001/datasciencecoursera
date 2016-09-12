[link to Google!](http://google.com)
##Source Data
Decription of raw data used can be found at this [link] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
Raw data can be found at this [link] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

##Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
 

 ## DATA DICTIONARY - AVERAGES DATA

### subject
	integer
	1:30
	
### activityName
	factor
	1. LAYING
	2. SITTING
	3. STANDING
	4. WALKING
	5. WALKING_DOWNSTAIRS
	6. WALKING_UPSTAIRS
	
##signal
	factor
	1. BodyAcc
	2. BodyAccJerk
	3. BodyAccJerkMag
	4. BodyAccMag
	5. BodyBodyAccJerkMag
	6. BodyBodyGyroJerkMag
	7. BodyBodyGyroMag
	8. BodyGyro
	9. BodyGyroJerk
	10. BodyGyroJerkMag
	11. BodyGyroMag
	12. GravityAcc
	13. GravityAccMag
	
##domain
	factor
	1. frequency
	2. time
	
##calculation
	factor
	1. mean()
	2. std()
	
##axis
	factor
	1. X
	2. Y
	3. Z
	4. XYZ
	
##average
	numeric