## A.- Preparar condiciones de entorno 

    ## se debe instalar el paquete y librerias dplyr
    ##install.packages("dplyr")
    
    library(dplyr)
    
      #Nombra el paquete de datos para descargar
    
      filename <- "entrega_final.zip"
    
      #Descarga del dataset
    
    if (!file.exists(filename)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(fileURL, filename, method="curl")
    } 
    
    # Checking if folder exists
    if (!file.exists("UCI HAR Dataset")) { 
      unzip(filename) 
    }

## B.- Asignar los Dataframes 
      
      features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
      
      activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code","activity"))
      
      subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
      
      x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
      
      y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
      
      subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
      
      x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
      
      y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Step 1: Merges the training and the test sets to create one data set. (Combinar los datos para generar un dataset)

    X <- rbind(x_train, x_test)
    Y <- rbind(y_train, y_test)
    Subject <- rbind(subject_train, subject_test)
    Merged_Data <- cbind(Subject, Y, X)

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. (Extraer las columnas de las variables de ínteres, mediante la coincidencia en el nombre de caracteres clave)    TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
    
## Step 3: Uses descriptive activity names to name the activities in the data set. Reemplazo los nombres de las actividades por los descriptores.
    
    TidyData$code <- activities[TidyData$code, 2]
    
## Step 4: Appropriately labels the data set with descriptive variable names.
    ## se nombrarán la columnas para uniformar los nombres de las variables
    
        names(TidyData)[2] = "activity"
        names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
        names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
        names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
        names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
        names(TidyData)<-gsub("^t", "Time", names(TidyData))
        names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
        names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
        names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
        names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
        names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
        names(TidyData)<-gsub("angle", "Angle", names(TidyData))
        names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
  
## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
    
        DataFinal <- TidyData %>%
          group_by(subject, activity) %>%
          summarise_all(funs(mean))
        write.table(DataFinal, "DataFinal.txt", row.name=FALSE)
        