# Reading Excel files

# R has numerous ways to import Excel files, same as csv files - you can programmatically edit Excel worksheets using R.
# readxl library - developed by the same author as tidyverse, but separate package, so needs to be loaded separately

library ( tidyverse )
library ( readxl )
# only two functions in the readxl package: excel_sheets() and read_excel()

# readxl contains sample data - copied as part of package installation. but where to? it'll be in a subfolder called "extdata"
system.file( "extdata", package = "readxl" ) # returns the path for the given library

# recall that we can display the contents of a folder using dir() - can set param full.names = TRUE to get full path
system.file( "extdata", package = "readxl" ) %>% dir( full.names = TRUE )
# should return a set of .xls and .xlsx files
