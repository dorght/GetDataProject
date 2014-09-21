GetDataProject Readme
---------------------

####Synopsis
run\_analysis.R creates a tidy data set file, tidy\_wearable\_data.txt, of
averaged means and averaged standard deviations for a variety of movement data
included in [Human Activity Recognition Using Smart Phone Data](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). See the README.txt
included with the data set for more information about the raw data used. Included 
with the run\_analysis.R script file and this README.md is the file Code\_Book.md 
which contains decriptions of the data and how it was manipulated.

####Data File Location
The Human Activity data set is assumed to be unzipped into the working directory.
This means the data set's top directory, UCI\_HAR\_Dataset, is in the working 
directory and all data is contained in the data set's sub-directories.

####Usage
The script file, run\_analysis.R, is run from the R Console or in RStudio. The 
working directory for the R environment must be correctly set prior to running, so 
the data file is located as noted above. The script file does not have to be in the 
working directory.

####Output
The final output file, tidy\_wearable\_data.txt, is written to the working directory.

#####Author notes
These files have been written by Sean Murphy as a project for the Coursera 
Getting and Cleaning Data course presented by Johns Hopkins. 20 Sept 2014