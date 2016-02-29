## Coursera: Data Science Specialisation // Getting and Cleaning Data
## Course Project completed by Pamela L. Monaghan 28 Feb 2016

## This script will execute five steps on the UCI dataset
## 1) Merge the training and test sets to create one data set
## 2) Extract the mean and standard deviation for each measurement
## 3) Rename activities in data set using descriptive names
## 4) Appropriately label data set with descriptive variable names
## 5) From dataset in Step 4, create a second, independent tidy dataset
##    with the average of each variable for each activity and each subject

## Acknowledgements - from README.txt
acknowledge <- "Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012"
cat("\nThis project is based on the data set provided by:\n")
cat(acknowledge, "\n\n")

## building list of environment variables to cleanup at end
trash <- c("trash", "acknowledge") 

## Url of data file
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
trash <- c(trash, "fileUrl")

## load libraries we will use
library("dplyr"); library("reshape2")

## Capture user's working directory
my_wd <- getwd()
cat("User's Working Directory is:", my_wd, "\n\n")  # delete after testing
trash <- c(trash, "my_wd")

## Make sure there is local directory for us to work in
if(!file.exists("./UCIdata")) {dir.create("./UCIdata")}
setwd("./UCIdata")
cat("Just changed working directory to UCIData\n\n") #delete when done
cat("Current directory is now:", getwd(), "\n\n") #delete when done

## downloading zipped dataset
if(!file.exists("./Dataset.zip")) {
    cat("Downloading file now...\n\n") ##User friendly
    
    download.file(fileUrl, destfile = "./Dataset.zip")
    cat("Download done.\n\n")
    cat("current directory is:", getwd(), "\n\n") #delete when done
    
    download_date <- format(Sys.Date(), format("%B %d %Y")) ## for reproducibility
    cat("Zip file was downloaded on", download_date, "\n\n") ##User friendly
    trash <- c(trash, "download_date")
} else {
    cat("Zip file already exists. Yay!\n\n")
}

## unpacking the zip file
if(!file.exists("./X_test.txt")) {
    unzip("Dataset.zip", junkpaths = TRUE)
    cat("Just unzipped the data file. \n\n")
} else {
    cat("The data files are already unzipped. \n\n")
}

## read in all the data we need
cat("Running the analysis! This may take a moment. \n\n")

test_subject_id <- read.table("subject_test.txt")
train_subject_id <- read.table("subject_train.txt")
trash <- c(trash, "test_subject_id", "train_subject_id")

test_activity_id <- read.table("y_test.txt")
train_activity_id <- read.table("y_train.txt")
trash <- c(trash, "test_activity_id", "train_activity_id")

activity_names <- read.table("activity_labels.txt")
data_colnames <- read.table("features.txt")
trash <- c(trash, "activity_names", "data_colnames")

test_data <-read.table("X_test.txt")
train_data <-read.table("X_train.txt")
trash <- c(trash, "test_data", "train_data")


## Item 1) bind tables, test first, then train for subject_id, activity_id, and data
all_subject_id <- rbind(test_subject_id, train_subject_id)
all_activity_id <- rbind(test_activity_id, train_activity_id)
all_data <- rbind(test_data, train_data)
trash <- c(trash, "all_subject_id", "all_activity_id", "all_data")

## Item 4) provide column names
names(all_subject_id) <- "subject_id"
names(all_activity_id) <- "activity_id"
names(all_data) <- data_colnames[,2]

## bind Subject, activity, and data into one table
combined_data <- cbind(all_subject_id, all_activity_id, all_data)
trash <- c(trash, "combined_data")

## Item 2) remove duplicate data
## select only mean() and std() measurements yields 68 variables
combined_data <- combined_data[ !duplicated(names(combined_data))]
combined_data <- combined_data %>% 
    select(subject_id, activity_id, matches("(mean|std)\\(.*\\)"))

## Item 5) Average each measurement by student and by activity
## there are 30 participants and 6 activities so this data set will have
## 30 X 6 rows or 68 variables
TidyData <- recast(combined_data, subject_id + activity_id ~ variable, 
                    mean, id.var = c("subject_id", "activity_id"))
trash <- c(trash, "TidyData")

## Item 3) Now that the dataset is smaller, 
## we will rename the Activities
TidyData$activity_id <- sapply(TidyData$activity_id, function(x) activity_names[x, 2])

## housekeeping
setwd("..")

## output all that lovely data
cat("OK.  Data has been tidied.  \n\nCurrent directory is reset to:", getwd(), "\n\n")

write.table(TidyData, file = "TidyData.txt", row.names = FALSE)
cat("The output has been written to the file TidyData.txt. \n\n")

tidydata <- read.table("TidyData.txt")
cat("Here's a look at it... \n\n")
View(tidydata)


## housekeeping - detach libraries
cat("Cleaning up Environment variables and detaching libraries...\n\n")
detach("package:dplyr", unload=TRUE)
detach("package:reshape2", unload=TRUE)
rm(list=trash)

##housekeeping - cleanup the environment and the folder of data
cat("Removing the UCIdata folder and its contents...\n\n")
cat("All you have to do is delete TidyData.txt when you're done looking it over!\n\nBye!\n\n")
unlink("./UCIdata", recursive = TRUE) ## clean up UCIDirectory and subdirectories
