##Overview
###The purose of this file is to supplement the comments in the run_analysis.R script

* Rows 7:24 - The script begins by importing the train data and applying identity columns to the data before merging to avoid issues with column re-ordering during joins.
* Rows 26:42 - Use same logic for test data

* Row 46 - I used rbind() to merge the two data sets because all the column names were the same
* Rows 52:61 - I used the features data file to select the columns I wanted in the main data before joining as this is to do with a quick subset. I removed the identity column to line up the columns to be subset.

* Rows 65:71 - After joining the actual activity names to the main data set I subset the table to remove the ID column as it was no longer needed.
* Rows 80:91 - Doing a seperate on the "-" character provided an easy split for all but 1 variable, however this caused an NA for the magnitude observations of the data set, so I went and manually applied "XYZ" as the axis column values to replace the NAs since those observations are the magnitude or the three-dimensional signals
  To get the final column 'domain', I used seperate to give me the 't' and 'f' values with the use of a dummy column which I subset out immediately after.
  

