run_analysis <- function(){
        
        library(dplyr)
        library(data.table)
        library(tidyr)
        
## 1. Merging training and test sets to create one data set
####Train Files
        ##Import data files 
        x_train <- fread("./train/X_train.txt", select = c(1:561), nrows = 7352)
        y_train <- fread("./train/y_train.txt", select = 1, nrows = 7352)
        subject_train <- fread("./train/subject_train.txt", select = 1, nrows = 7352)
        ##Assign column names
        colnames(y_train)<-"activityNameID"
        colnames(subject_train)<-"subject"
        ##Set identity columns
        x_train <- mutate(x_train, identity = as.numeric(rownames(x_train)))
        y_train <- mutate(y_train, identity = as.numeric(rownames(y_train)))
        subject_train <- mutate(subject_train, identity = as.numeric(rownames(subject_train)))
        ##Merge activity and subject column into main data set
        x_train <- merge(x_train, y_train, by.x = "identity", by.y = "identity")
        x_train <- merge(x_train, subject_train, by.x = "identity", by.y = "identity")
        ##Cleanup
        rm(subject_train, y_train)
        
####Test Files
        ##Import data files 
        x_test <- fread("./test/X_test.txt", select = c(1:561), nrows = 2947)
        y_test <- fread("./test/y_test.txt", select = 1, nrows = 2947)
        subject_test <- fread("./test/subject_test.txt", select = 1, nrows = 2947)
        ##Assign column names
        colnames(y_test)<-"activityNameID"
        colnames(subject_test)<-"subject"
        ##Set identity columns
        x_test <- mutate(x_test, identity = as.numeric(rownames(x_test)))
        y_test<- mutate(y_test, identity = as.numeric(rownames(y_test)))
        subject_test <- mutate(subject_test, identity = as.numeric(rownames(subject_test)))
        ##Merge activity and subject column into main data set
        x_test <- merge(x_test, y_test, by.x = "identity", by.y = "identity")
        x_test <- merge(x_test, subject_test, by.x = "identity", by.y = "identity")
        ##Cleanup
        rm(subject_test, y_test)
        
##All Data
        ##combine train and test data together
        main_data <- rbind(x_test, x_train)
        ##Cleanup
        rm(x_test, x_train)
        
## 2. Extract only the measurements on the mean and standard deviation for each measurement.
        ##Identify columns we want
        columnHeaders <- fread("features.txt", select = c(1,2), nrows = 561)
        colsToGet <- grep("\\bmean()\\b|\\bstd()\\b", columnHeaders$V2)
        columnHeaders <- columnHeaders[colsToGet,]
        colsToGet <- c(colsToGet, 562, 563)
        ##Remove identity column 
        main_data <- subset(main_data, select = c(2:564))
        ##Subset column we want
        main_data <- subset(main_data, select = colsToGet)
        ##Reorder table
        main_data <- subset(main_data, select = c(68, 67, 1:66))
        
## 3. Uses descriptive activity names to name the activities in the data set
        ##Load Activity Labels
        activity_labels <- fread("activity_labels.txt", select = c(1, 2), nrows = 6)
        ##rename columns to merge
        colnames(activity_labels)<- c("activityNameID", "activityName")
        ##merge to main data
        main_data <- merge(main_data, activity_labels, by.x = "activityNameID", by.y = "activityNameID")
        ##replace id column with names
        main_data <- subset(main_data, select = c(2, 69, 3:68))
 ## 4. Appropriately label the data set with descriptive variable names       
        ##Replace column names with variable names
        colnames(main_data) [3:68]<-columnHeaders$V2
        
        ##Gather all the column variables into 1 column and a sum value column
        main_data <- gather(main_data, variables, sum, -subject, -activityName)
        
        ##Seperate out the individual perspectives into their own columns
        main_data <- separate(main_data, variables, sep = "-", into = c("signal", "calculation", "axis"))
        main_data <- separate(main_data, signal, sep = "^?", into = c("dummy", "domain"), remove = FALSE)
        main_data <- subset(main_data, select = c(1:3, 5:8))
        main_data <- mutate(main_data, signal = substring(main_data$signal, 2, length(main_data$signal)-1))
        
        ##Assign time and frequency to the domain column values
        main_data <- within(main_data, domain[domain == "t"] <- "time")
        main_data <- within(main_data, domain[domain == "f"] <- "frequency")
        
        ##Since the only NAs in the axis column are for the magniture of the three-dimensional 
        ##signals, we assign XYZ to the NAs
        main_data <- within(main_data, axis[is.na(axis)] <- "XYZ")
        
## 5. From the data set in step 4, creates a second, independent tidy data set with the 
##    average of each variable for each activity and each subject
        ##Since we only want the average for activity and subject, we select the relevent columns
        averages_data <- aggregate(main_data$sum, by = 
        main_data[c("subject","activityName", "signal", "domain", "calculation", "axis")],mean)
        colnames(averages_data) [7] <- "average"
        
        ##Order the columns to clean up the data
        averages_data <-arrange(averages_data, subject, activityName, signal, domain, calculation, axis)
        
        ##Write the dataset to txt file
        write.table(averages_data, "averages_data.txt", row.name=FALSE)
}