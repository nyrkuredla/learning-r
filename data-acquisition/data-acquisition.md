# Data Acquisition
## General thoughts 
- Is the source data set static or dynamic? 
- Snapshots - capture and transform data into a Unicode .csv file for later consumption if possible; benefits:
  * Saves time - don't have to write or maintain code to automate getting source data
  * Easy to import into almost any analysis tool in .csv format
  * Great deal of control over the data set, as opposed to dynamic changes that can be unpredictable
  * Provides traceability and reproducibility - you can run the same analysis and get the same result
- In Excel - refresh the data from its source each time you import a data set, and use version control of some kind for traceability
- The best form is balance, depending on the context of the request - there are benefits to automation as well. consider the cost-benefit analysis of automation

## Importing data:
* Break down large/long data transfers into smaller chunks
* Do incremental restores each time you refresh
* Keep multiple copies or rolling versions of snapshot data
* Write a "reasonable" amount of code for error-handling
* Best idea is to complete an initial stage of data handling/wrangling before trying to automate anything - increment mindfully on this


# Exercise notes:

## Flat File importation - lots of ways to do this in R:
  * read_csv(): tidyverse version - filename is a required parameter
  * read_tsv(): for tab-separated values - there is also read_delim() for specifying your own column delimiter
  * skip, col_names, col_types
  * If issue with converting data types during import, just import as a string to be handled later in R - various packages specializing in, e.g., date conversion
  
## Features for this lesson:
* library()
* write_csv() / write_tsv()
* getwd()
* dir()
* read_csv / read_tsv()
* glimpse()
* names()
* print()
* c()
* head()
* spec()
* problems()

## Dataset
* mpg


  
