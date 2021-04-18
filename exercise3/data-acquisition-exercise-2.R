# Reading Excel files

# R has numerous ways to import Excel files, same as csv files - you can programmatically edit Excel worksheets using R.
# readxl library - developed by the same author as tidyverse, but separate package, so needs to be loaded separately

library ( tidyverse )
library ( readxl )
# only two functions in the readxl package: excel_sheets() and read_excel()

# set working directory - 
# setwd("whatever your working directory is")

# readxl contains sample data - copied as part of package installation. but where to? it'll be in a subfolder called "extdata"
system.file( "extdata", package = "readxl" ) # returns the path for the given library

# recall that we can display the contents of a folder using dir() - can set param full.names = TRUE to get full path
system.file( "extdata", package = "readxl" ) %>% dir( full.names = TRUE )
# should return a set of .xls and .xlsx files with paths - xls and xlsx files contain the same data, just different formats

# how about copying these files to our current directory? use file.copy()
file.copy( from = system.file ("extdata", package = "readxl") %>% dir ( full.names = TRUE ), to = getwd())
# note output: TRUE indicates that file was successfully copied

# let's confirm they copied ok
dir()

# now let's display just the excel files - string pattern = RegEx
dir ( pattern = "\\.xls?" ) # double backslash escapes the period

# now that files are confirmed in our working directory, look at sheets to figure out what to import
? excel_sheets

# display the sheet names of both "datasets" Excel files
excel_sheets( "datasets.xls" )
excel_sheets( "datasets.xlsx" )

# so now we know both the filename and sheet names, time to read some excel
? read_excel

# import datasets.xlsx and store dataframe in a variable
df_dsxlsx <- read_excel( "datasets.xlsx" )

glimpse( df_dsxlsx )

# now let's try importing the dataset xls, but just the mtcars sheet. use sheet param
df_mtcarsxls <- read_excel( "datasets.xls", sheet = "mtcars" )

glimpse( df_mtcarsxls )

#

