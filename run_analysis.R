## run_analysis.R creates tidy data set file of averaged means and averaged
## standard deviations for a variety of movement data included in the Human
## Activity Recognition Using Smart Phone Data
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## see codebook.md and readme.md included with this script file for more information

library(plyr)
library(reshape2)

# assumes that the data is stored intact as a subdirectory of the working directory
dataDir <- paste0(getwd(), "/UCI_HAR_Dataset/")

# get descriptive headings names to be used for the data from features.txt file,
# then convert to a character vector of just the names
headings <- read.table(paste0(dataDir, "features.txt"), sep = " ",
                       header = FALSE, stringsAsFactors = FALSE,
                       colClasses = c("integer", "character"), comment.char = "")
headings <- as.vector(headings[, 2])


## Training subject data files handling ##

# read in file containing the subject's number corresponding to each row of the data
# the single column is named "subject", read as an integer
trainsubject <- read.table(paste0(dataDir, "train/subject_train.txt"),
                           header = FALSE, col.names = "subject",
                           colClasses = "integer", comment.char = "")

#read in file containing the activity number corresponding to each row of the data
# the single column is named "activity", read as an integer for now
trainactivity <- read.table(paste0(dataDir, "train/y_train.txt"),
                            header = FALSE, col.names = "activity",
                            colClasses = "integer", comment.char = "")

# read in the movement data file
# descriptive column names are taken from the headings vector created earlier
# the check.names = FALSE option is required to keep heading names intact
traindata <- read.table(paste0(dataDir, "train/X_train.txt"),
                        header = FALSE, colClasses = "numeric", comment.char = "",
                        col.names = headings, check.names = FALSE)

# combine the training subject/activity/data into a single data.frame
traindata <- cbind(trainsubject, trainactivity, traindata)
rm(trainsubject, trainactivity)                            # housekeeping


## Test subject data files handling ##

# read in file containing the subject's number corresponding to each row of the data
# the single column is named "subject", read as an integer
testsubject <- read.table(paste0(dataDir, "test/subject_test.txt"),
                          header = FALSE, col.names = "subject",
                          colClasses = "integer", comment.char = "")

# read in file containing the activity number corresponding to each row of the data
# the single column is named "activity", read as an integer for now
testactivity <- read.table(paste0(dataDir, "test/y_test.txt"),
                           header = FALSE, col.names = "activity",
                           colClasses = "integer", comment.char = "")

# read in the movement data file
# descriptive column names are again taken from the headings vector created earlier
# the check.names = FALSE option is required to keep heading names intact
testdata <- read.table(paste0(dataDir, "test/X_test.txt"),
                       header = FALSE, colClasses = "numeric", comment.char = "",
                       col.names = headings, check.names = FALSE)

# combine the test subject/activity/data into a single data.frame
testdata <- cbind(testsubject, testactivity, testdata)
rm(testsubject, testactivity, headings)                    # housekeeping


## Create one large data.frame from training and test data ##

data <- rbind(traindata, testdata)
rm(traindata, testdata)                                    # housekeeping

# keep just subject, activity columns and any columns names that
# include the sub-strings "mean()" or "std()"
data <- data[, c(1, 2, grep("mean\\(\\)|std\\(\\)", names(data)))]

# read in file containing the activity number and it's corresponding descriptive label
activity <- read.table(paste0(dataDir, "activity_labels.txt"),
                             header = FALSE, colClasses = "character",
                             col.names = c("level", "label"), comment.char = "")

# convert the activity column entries to descriptive factors based on the number
data$activity <- factor(data$activity, levels = activity$level,
                        labels = activity$label)
rm(activity)                                               # housekeeping

## Create tidy data set from data with the average of each variable ##
## for each activity and each subject.                              ##

# make data tall and skinny
meltdata <- melt(data, id.vars = c("subject", "activity"),
                 variable_name = "measurement")
# average data
meltdata <- ddply(meltdata, .(subject, activity, measurement),
                  summarize, avgmeasure=mean(value))

# create text file containing tidy average data
write.table(meltdata, file = "tidy_wearable_data.txt", row.names = FALSE)
