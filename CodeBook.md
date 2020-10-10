The run_analysis.R script is the code write in R for the preparation of data requiered in 5 steps in the course final assigment definition.

The first consideration is that the script requires the dplyr package and the library to work. So the first part is to configure these libraries.
Then the script  following sequence of steps:

1. Data Download

The dataset is downloaded and extracted in the folder called "UCI HAR Dataset"

2. Assign data to a variable:
  
      features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
            str(features) =    data.frame':	561 obs. of  2 variables.      
            
            This is the database come from the accelerometer and gyroscope 3- axial raw signals tAcc-XYZ and tGyro-XYZ from downloaded dataset.
   
      activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code","activity"))
            str(activities) = 'data.frame':	6 obs. of  2 variables.
         
            Wich is the list of activities recogniced and that used to label "code" column.  
            
      subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
            str(subject_test)= 'data.frame':	2947 obs. of  1 variable:
      
            That contans the data from 9/30 test-subject observations.
      
      x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
          str(x_test)= 'data.frame':	2947 obs. of  561 variables.
          
            Contains recorded features test data.
      
      y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
          str(y_test)= 'data.frame':	2947 obs. of  1 variable:
           
           Contains test data of activities’code labels
           
      subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
       str(subject_train)= 'data.frame':	7352 obs. of  1 variable
          
          That contans the data from 21/30 test-subject observations.
          
      x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
      str(x_train)0'data.frame':	7352 obs. of  561 variables
      
        Contains recorded features train data
        
      y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
      str(y_train)='data.frame':	7352 obs. of  1 variable 
      
       Contains train data of activities’code labels
       
3. Assigment Step 1: Merges the training and the test sets to create one data set. 

  Create a variable X using rbind() function over merging x_train and x_test
  Create a variable Y, using rbind() functin over merging x_test and y_test 
  Then crate Subject variable merging subject_train and subject_test again using rbind() function.
  Finnaly Merged_Data (10299 rows, 563 column) is created by merging Subject , Y and X using cbind() function

4. Assigment Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

  TidyData is the table created by subsetting Merged_Data  and selectng columns: subject, code and the measurements, 
  Selected measurement are just the mean and standar deviation ( std) for each one.

  The resulting table is a data.frame object with 10299 obs. of  88 variables.

5. Assigment Step 3: Uses descriptive activity names to name the activities in the data set.
    
   Replace the entire number in second column of TidyData with activities neme from the activities variable.

6. Assigment Step 4: Appropriately labels the data set with descriptive variable names.   
  First set de second column of TidyData as "activities"
  Then gsub() are used to:
      Replaced all "Acc" in column’s name by Accelerometer
      Replace all "Gyro" in column’s name by Gyroscope
      Replace all "BodyBody" in column’s name by Body
      Replace all "Mag" in column’s name by Magnitude
      All start with character f in column’s name replaced by Frequency All start with character t in column’s name replaced by Time  
      
7. Assigment Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
    
  Finally a new table named DataFinal is created, by summarizing TidyData by mean after grouping measurement by activitie and subject.
  Final table is exporting using  "write.table(DataFinal, "DataFinal.txt", row.name=FALSE)" wich create a new text archive in the job directory. 
  
