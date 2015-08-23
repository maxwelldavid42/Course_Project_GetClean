##Course Project 1

###Load data into R Studio
	*Read the X files
	*Read Y files
	*Read the Subject files


###1. Merge training sets to create one data set
	*Use rbind to merge individual pieces of X, Y, and Subject files
	*Add names to X, Y and Subject files, then use cbind to merge the three data sets

###2. Extract only the measurements on the mean and stdev for each measurement
	*Create subdata using grep to extract only feature names that begin with 'mean' or 'std'
	*Create set of desired feature names, with their respective subjects and activities
	*Subset the master data set with desired features


###3 Uses descriptive activity names to name the activities in the data set
	*Set respective activity numbers to their names


###4. Appropriately labels the data set with descriptive variable names. 
	*Set respective labels to their descriptive names


###5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	*Create tidy data set of avg of each variable dependent on subject and data
	*Order this tidy set by subject then by activity
