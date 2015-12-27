##Check for directory and create if not there. Set working directory.
  ##setwd("../Getting_and_Cleaning_Data/CourseProject")
  if (!file.exists("C:/Users/Brad/Documents/Coursera/Getting_and_Cleaning_Data/CourseProject")){
    dir.create("C:/Users/Brad/Documents/Coursera/Getting_and_Cleaning_Data/CourseProject")
  }
  setwd("C:/Users/Brad/Documents/Coursera/Getting_and_Cleaning_Data/CourseProject")

##Get the file
 download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="projectzip")

##Unzip file into the working directory
 unzip("projectzip.zip")

library(data.table)

##Read the files into frames

  ## 7,352 subject IDs to link to X_train data sets
    dsubjecttrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
  ## 2,947 subject IDs to link to X_test data sets
    dsubjecttest<-read.table("./UCI HAR Dataset/test/subject_test.txt")

  ## 7,352 data sets of 561 variables from train
    dXtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
  ## 2,947 data sets of 561 variables from test
    dXtest<-read.table("./UCI HAR Dataset/test/X_test.txt")

  ## 7,352 activity ID to link to X_train data sets
    dytrain<-read.table("./UCI HAR Dataset/train/y_train.txt")
  ## 2,947 activity ID to link to X_test data sets
    dytest<-read.table("./UCI HAR Dataset/test/y_test.txt")
  
  ## 561 features/column header names that link to y_test/y_train data
    dfeatures<-read.table("./UCI HAR Dataset/features.txt")

  ## 6 label names that link to y_train and y_test activity ids
    activityLabel<-read.table("./UCI HAR Dataset/activity_labels.txt")

## Build frame for test
    ##Bind columns of subject IDs and activity IDs for test
      initialtest<-cbind(dsubjecttest,dytest)

    ##Assign new columnames for test
      colnames(initialtest)<-c("Subject","Activity")

    ##Bind activities to subject ID and activity ID for test
      fulltest<-cbind(initialtest,dXtest)

##Build frame for train
  initialtrain<-cbind(dsubjecttrain,dytrain)
  colnames(initialtrain)<-c("Subject","Activity")
  fulltrain<-cbind(initialtrain,dXtrain)

##Merge test and train
  fullData<-rbind(fulltest, fulltrain)

## Replace the non descriptive terms in fullData columns with features.txt terms

    ##Create a character vector from features data frame
      cFeatures<-as.character(dfeatures[,("V2")])

    ## Append feature names to Subject, activity vector
      columnhead<-c("Subject","Activity", cFeatures)

    ## Create copy of the data
      independentData<-fullData

    ## Add column names to data
      colnames(independentData)<-columnhead

## Extracts only the measurements on the mean and standard deviation for each measurement.

    ## Create a vector for column names
      IDCols<-colnames(independentData)

    ## Creating a vector of means/std values, used for subset
      vMeanSTD<-IDCols[grep("mean\\(\\)|std",IDCols)]

      newColumns<-c("Subject","Activity", vMeanSTD)

      MeanStdData<-independentData[,newColumns]

## Replace activity IDs with full activity names
  ## Add a column that has the activity name merged with the activity Id
    mergedData<- merge(MeanStdData,activityLabel,by.x="Activity", by.y="V1")

  #Remove the Activity column
    mergedData$Activity<-NULL

  #Rename last column to Activity
    names(mergedData)[names(mergedData)=="V2"]<-"Activity"

  ##reorder columns to put Activity second
    reorderedData<-mergedData[,c(1,68,2:67)]

## Create a second, independent tidy data set with the average of each variable for each activity and each subject.
  ##Load dplyr library. Needed for group_by,summarize_each
      library(dplyr)

  ##Group Data by Subject and Activity
      subjectData<-group_by(reorderedData,Subject, Activity)

  ##Average the data for each subject by activity
      exportData<-summarize_each(subjectData,funs(mean))

##Export data to file
  write.table(exportData, "GACData_results.txt",row.names=FALSE)  

##ENDSCipt##









