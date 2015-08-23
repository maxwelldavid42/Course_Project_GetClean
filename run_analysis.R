##Load data into R Studio

setwd("C:/Max/R/Coursera/Getting and Cleaning Data")
path <- file.path("./CourseProject1" , "UCI HAR Dataset")

##Read the Activity files

dataYTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
dataYTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)


##Read the Subject files

dataSubject_Train <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
dataSubject_Test  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)

##Read Features files

dataXTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
dataXTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)


##1. Merge training sets to create one data set

dataSubject <- rbind(dataSubject_Train, dataSubject_Test)
dataY<- rbind(dataYTrain, dataYTest)
dataX<- rbind(dataXTrain, dataXTest)


names(dataSubject)<-c("subject")
dataFeaturesNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(dataY)<- dataFeaturesNames$V2
names(dataX)<- c("activity")
dataSubject_and_X <- cbind(dataSubject, dataX)

Data <- cbind(dataY, dataSubject_and_X)


##2. Extract only the measurements on the mean and stdev for each measurement


subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)


##3 Uses descriptive activity names to name the activities in the data set


Data$activity <- as.character(Data$activity)
Data$activity[Data$activity == 6] <- "Laying"
Data$activity[Data$activity == 5] <- "Standing"
Data$activity[Data$activity == 4] <- "Sitting"
Data$activity[Data$activity == 3] <- "Walking Downstairs"
Data$activity[Data$activity == 2] <- "Walking Upstairs"
Data$activity[Data$activity == 1] <- "Walking"


Data$activity <- as.factor(Data$activity)

##4. Appropriately labels the data set with descriptive variable names. 

names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Acc", "Acceleration", names(Data))
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))


##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr);
Tidy<-aggregate(. ~subject + activity, Data, mean)
Tidy<-Tidy[order(Tidy$subject,Tidy$activity),]
write.table(Tidy, file = "Tidy.txt", row.names = FALSE)

library(knitr)
knit2html("codebook.txt");