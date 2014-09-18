dataDir <- getwd()
dataDir <- paste0(dataDir, "/UCI_HAR_Dataset/")

headings <- read.table(paste0(dataDir, "features.txt"), sep = " ",
                       header = FALSE, stringsAsFactors = FALSE,
                       colClasses = c("integer", "character"))
headings <- as.vector(headings[, 2])

traindata <- read.table(paste0(dataDir, "train/X_train.txt"),
                        header = FALSE, col.names = headings,
                        colClasses = "numeric")
trainsubject <- read.table(paste0(dataDir, "train/subject_train.txt"),
                           header = FALSE, col.names = "subject",
                           colClasses = "integer")
trainactivity <- read.table(paste0(dataDir, "train/y_train.txt"),
                            header = FALSE, col.names = "activity",
                            colClasses = "integer")
traindata <- cbind(trainsubject, trainactivity, traindata)
rm(trainsubject, trainactivity)

testdata <- read.table(paste0(dataDir, "test/X_test.txt"),
                       header = FALSE, col.names = headings,
                       colClasses = "numeric")
testsubject <- read.table(paste0(dataDir, "test/subject_test.txt"),
                           header = FALSE, col.names = "subject",
                           colClasses = "integer")
testactivity <- read.table(paste0(dataDir, "test/y_test.txt"),
                            header = FALSE, col.names = "activity",
                            colClasses = "integer")
testdata <- cbind(testsubject, testactivity, testdata)
rm(testsubject, testactivity)

data <- rbind(traindata, testdata)
rm(traindata, testdata)

data <- data[, grep("mean|std", headings)]

activity <- read.table(paste0(dataDir, "activity_labels.txt"),
                             header = FALSE, colClasses = "character",
                             col.names = c("level", "label"))
data$activity <- factor(data$activity, levels = activity$level,
                        labels = activity$label)
