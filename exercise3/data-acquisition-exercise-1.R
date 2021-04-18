# loading tidyverse - includes readr
library (tidyverse)

# looking at write_csv(); save a dataframe to a delimited file
? write_csv

# writing a csv file - recall pipe operator basics
# data: mpg, file: mpg.csv
mpg %>% write_csv("mpg.csv") #note quotation marks
# should be no visible output here - but how to confirm?

# get working directory
# ? getwd

getwd()

# how can we see the files that are in a given directory?
# ? dir

#getwd() %>% dir()
dir()
# should see mpg.csv in here

# same with tsv
mpg %>% write_tsv ("mpg.tsv")

# read_csv - creates a tibble
# remember naming convention to quickly identify dataframe objects/df
# for practive, pull back in the new csv file we just made from the mpg dataset prior
df_csv <- "mpg.csv" %>% read_csv()

# compare import to original dataframe
# explore df_csv - read-in
df_csv %>% glimpse()

# original dataset
mpg %>% glimpse() # pretty close, except note the different data types on certain columns - this is bc read_csv() function makes that determination when reading in - it's not included as part of the csv file

# more options for read_csv:
# trim_ws - on by default, trims whitespace on beginning/end of value
# guess_max - rows used to determine datatype, 1000 min
# col_names - specifies column names - i.e. when not provided in header
# skip - skip first n rows (summary info and whatnot)
# col_types - define column names on import

df_csv_no_col_names <- "mpg.csv" %>% read_csv( col_names = FALSE )
# column names get auto-assigned - X1, X2....
# columns are now character data type! - since first row had string value detected as a result - so data type converted to retain string data

# what if we were able to skip the first line, then, so can assign data type correctly?
df_skip_1st <- read_csv ("mpg.csv", col_names = FALSE, skip = 1)

# let's check against the original dataframe again, should see no column name, but non-string data types per column
df_skip_1st %>% glimpse()
mpg %>% glimpse()

# what if we want to specify our own column names?
# let's display the originals
mpg %>% names()

# now we can add the original column names back in if we wish: col_names
df_original_col_names <- read_csv("mpg.csv", col_names = (names (mpg)), skip = 1)
# comparing the original dataframe with new dataframe
df_original_col_names %>% glimpse()
mpg %>% glimpse()

# c or combine - combines comma-separated values into a vector (if we already know what column names we want, for example)
v_mpg_col_names <- c('vehicle', 'model', 'disp', 'year', 'cyl', 'trans', 'drv', 'cty', 'hwy', 'fl', 'class')
# can use single- or double-quotes

df_custom_col_names <- read_csv("mpg.csv", col_names = v_mpg_col_names, skip = 1)

# compare output to original mpg df - notice "vehicle" vs "manufacturer" and "disp" vs "displ"
df_custom_col_names %>% glimpse()
mpg %>% glimpse()

# changing data types manually with col_type
# c(haracter), i(nteger), n(umber), d(ouble), l(ogical), D(ate), T(datetime), t(ime), ? (guess), - or _ to skip the column
# One letter for each column:
v_mpg_col_type <- "ccdiicciicc"

# set the data types per the above
df_col_types <- read_csv("mpg.csv", col_names = v_mpg_col_names, col_types = v_mpg_col_type, skip = 1)

# compare output to original
df_col_types %>% glimpse()
mpg %>% glimpse()

# examine column specifications for a data frame with spec()
# cols_condense - take a spec option and condense definition by setting the default column type to the most frequent type and only listing columns with a different type

# ? readr::spec # remember to specify the package this function is in

df_col_types %>% spec()

# Parsing error handling
# let's try to create an error - take a string and ask for a double (d) on the first column and a date (D) on the last column
 v_mpg_col_names <- c('vehicle', 'model', 'disp', 'year', 'cyl', 'trans', 'drv', 'cty', 'hwy', 'fl', 'class')
 v_mpg_col_type <- "dcdiiccicD"
 
 # need to supply col_names and col_type params
df_problem <- read_csv ("mpg.csv", col_names = v_mpg_col_names, skip = 1, col_types = v_mpg_col_type)
 
 # checkin'
 df_problem %>% glimpse ()
 mpg %>% glimpse ()
# note the NA values for the first and last columns, as well as warning message - values in these columns can't be resolved for the requested data type
 
 # let's run problems()!! - view any parsing problems encountered
 df_problem %>% problems () %>% head (10)
 # provides column name, what was expected, and what was provided
 
 
