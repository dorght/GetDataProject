GetDataProject Code Book
------------------------

####Data Source Information
The raw data for this project is described and can be obtained from: [Human Activity Recognition Using Smart Phone Data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

####Directory and File Structure
The Human Activity data is separated into two directories, train and test.
The basic layout of the file structure are the same between the directories. The 
files themselves are formatted identically between the train and test directories, 
except for the data itself and the number of observations (rows) in each. Within 
both the train and test directories is a sub-directory, Inertial Signals, that 
contains the raw acceleration and velocity data from the smart phones. This raw 
data was processed to generate the X_test.txt files that are used in this analysis. 
The Inertial Signals directories and files are therefore not used, just the 
processed data.

####Data Description
The main source of information on the data is the included file README.txt in the /UCI\_HAR\_Dataset/ directory. Additional summary information about the data is at 
the originating web site listed under Data Source Information. This information 
won't be repeated here accept as needed.

Both the Training and Test data in their respective X\_train.txt, X\_test.txt files 
are 561 columns wide. Each of these 561 columns is a "feature" of calculated data. 
Each row of the data constitutes a single observation of a time frame that the 
features were calculated for. The data set files features\_info.txt and 
features.txt contain more information about that calculated data.

For each row of the data there is an associated human subject that caused that data
to be generated. There are 30 subjects. The subjects were split 70% into the 
training data and 30% into the test data. The type of data is identical between
the subjects. Each human subject is identified by an integer. The subjects were
split between training and test, and so the numerical identifier integer are also
split.

####Assembling the data.frame
The data set file feature.txt contains descriptive names for each of the 561 columns
in both the X\_train.txt and X\_test.txt files. As a precursor to reading in the
actual data, the feature.txt file is used to generate a vector of descriptive column 
heading names.

The process for generating a complete training data.frame is described, the process
is then repeated for the test data.frame

The file subject\_train.txt contains a single column of integer data that 
corresponds to the human subject that generated the data for each row of the 
X\_train.txt data file. The subject\_train.txt file is read in as a integer 
data.frame of a single column.

Similiarly the file y\_train.txt contains a single column of integer data that
corresponds to the type of activity that the human subject was doing when the
data for each row in the X\_train.txt data file was generated. The y\_train.txt
file is read in as a integer data.frame of a single column.

The big data file X\_train.txt is read in as a numeric data.frame of 561 columns and 
many rows. The descriptive heading names created earlier are associated to the 
columns when the data.frame is created while the file is read.

The subject and activity columns are then combined onto left side of the training 
data data.frame.

At this point a large data.frame of the training data with descriptive
variable names and integer values for the human subject and their activity has been
generated.

The process is then repeated for the test data in the test sub-directory.

Both the test and train data data.frames have 563 columns and common column 
names. A single large data data.frame is created by binding the test data.frame rows to the bottom of the train data.frame rows.

####Subsetting the data
The project description requires data that is in columns that are described as
the mean and standard deviation. I have interpreted this to mean just columns 
who's labels contain "mean()" or "std()" in the string. Some column names appear 
to refer to measuring the angle to the mean of the gravity vector. Which seems 
to justify their exclusion. Additionally some other column names have the word 
mean but no associated standard deviation. Plus it was a challange trying to figure 
out the regular expression that worked with the parentheses 
(escape them with \\\\).

Subsetting the required columns gets the data down to 68 columns.

####Making it Descriptive
Finally descriptive activity names are added by reading the activity\_labels file.
The file associates the activity integer to a descriptive string. The integer 
activity column of the data data.frame is converted by substituting each integer 
for its associated descriptive factor.

Descriptive names for each column were added as the data.frames were created.

####Is It Tidy? part 1
A single large data set with descriptive measurement names and activity names has
been achieved. Since each observation is on a single row, and each measurement 
variable is a seperate column, I will say that this is tidy data.

As a further test for tidyness, if you were to try to make this data tall and 
skinny an identifier would have to be added so that individual measurements of an 
observations could be associated with each other. e.g. To get the vector sum of
an acceleration you would need the X, Y, and Z components of that observation.

###Creating Averages of mean() and std() Column Data
A new data.frame is created by melting all the measurements columns into a factor 
column and its value on the same row, next column. The subject and activity column 
data is kept with each measurement. This creates a tall skinny data.frame, but 
loses information in the process (see Is It Tidy? parts 1 and 2).

The melted data is then summarized by averaging each type of measurement (factor 
level) for each subject and activity. So if human subject 1 was engaged in the 
activity "WALKING" then the tBodyAcc\-mean()\-X measurements would be averaged, 
and so forth for each type of measurement. Then the next activity for subject 1 
is has it measurements averaged. Finally the whole process is repeated for each 
subject.

####Is it Tidy? part 2
The resulting tidy data data.frame is tall and skinny. Each observation of an 
average is on its own row, each variable is in its own column.
As mentioned above some information was lost in making it tall and skinny but 
because averages where being taken next that information is lost anyhow.

####Units
This is just confusing and I'm usually good at this type of information. 
However, as noted in data set's README.txt file "Features are normalized 
and bounded within [-1,1]". so there are **no units on the data**. To get units the
data item would have to be multiplied by whatever it was normalized with originally. I could not discern these normalizing factors.

#####Author notes
These files have been written by Sean Murphy as a project for the Coursera 
Getting and Cleaning Data course presented by Johns Hopkins. 21 Sept 2014