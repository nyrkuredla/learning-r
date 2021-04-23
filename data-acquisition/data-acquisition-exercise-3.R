# importing from the Internet
# read_csv can be used also to import from a URL (why not) - just replace the local filename with a URL string
# let's practice Internet imports and practice data basic data cleaning/filtering/piping
# using the automotive dataset from UCI

# load libraries
library ( tidyverse )
library ( readxl )

# first let's store the URL for the dataset we want to import, in a variable for easier use
auto_url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/autos/imports-85.data"

# note that the column names are NOT in the first row of the data file - they are in a second description file
# luckily the instructor has copied the data into Excel for us and provided the list of column names in an Excel sheet
# also note the change from dashes "-" to underscores - to avoid R interpreting the dashes as subtraction operators

# import the column names from the Excel spreadsheet
df_auto_cols <- read_excel ("auto_column_names.xlsx", col_names = FALSE)

# check it out
glimpse (df_auto_cols)
# notice the name of the one column - "X__1"

# now we'll use the URL and column names to import the data
# slight issue in that the column names are in a dataframe format and the read_excel function is expecting it as a vector/single column
# EVEN THOUGH the df_auto_cols is just one column, it is still CLASSED as a dataframe. lovely
# so we need to still reference the single column and pass that to the read_csv function

# can use $ to refer to a column in a data frame, in this case df_auto_cols$X__1
df_auto_data <- read_csv ( auto_url, col_names = df_auto_cols$X__1)
glimpse (df_auto_data)

# let's save a snapshot of the source data to a file called auto.csv
write_csv ( df_auto_data, "auto.csv" )

# what if we want to save the column names directly as a vector (instead of calling them as the first column of a dataframe)?
# c() function ("combine") will let us build a new vector
col_names_r <- c(
  "symboling",
  "normalized_losses",
  "make",
  "fuel_type",
  "aspiration",
  "num_of_doors",
  "body_style",
  "drive_wheels",
  "engine_location",
  "wheel_base",
  "length",
  "width",
  "height",
  "curb_weight",
  "engine_type",
  "num_of_cylinders",
  "engine_size",
  "fuel_system",
  "bore",
  "stroke",
  "compression_ratio",
  "horsepower",
  "peak_rpm",
  "city_mpg",
  "highway_mpg",
  "price"
)

glimpse (col_names_r)

# wonder if we can also just use the same column-name-pull as before, and just assign it to a new variable?
col_names_r_testing <- df_auto_cols$X__1
glimpse (col_names_r_testing)
# looks like it

# you can use print command to print the values of a vector, to make things more explicit
print(col_names_r)
print (col_names_r_testing)
# yep, still appears to be the same output - good to know
# note that the print moves from left to right, top to bottom - index numbers are the vector index position of the value just to the right

# our overall goal is to see hwy miles per hour (y axis) vs. engine size (x axis) - let's get plotting ASAP and come back to data cleanup later
# want to look at trends based on # of doors, # of cylinders, and # of drive wheels

# all this at once is really confusing and crap to do from scratch so let's start simple
# how bout just a simple scatterplot to start

glimpse(df_auto_data)

# uhh
? ggplot

# REALLY simple, then
df_auto_data %>% ggplot (
  aes ( x = engine_size, y = highway_mpg)) +
  geom_point()

# jitterbug, just a little
df_auto_data %>% ggplot (
  aes ( x = engine_size, y = highway_mpg)) +
  geom_jitter( alpha = 0.2 ) # looks good

# adding a trendline 
df_auto_data %>% ggplot (
  aes ( x = engine_size, y = highway_mpg)) +
  geom_jitter( alpha = 0.2 ) + 
  geom_smooth( method = lm, se = FALSE )

# how bout color by cylinder
df_auto_data %>% ggplot (
  aes ( x = engine_size, y = highway_mpg, color = num_of_cylinders)) +
  geom_jitter( alpha = 0.2 ) + 
  geom_smooth( method = lm, se = FALSE ) # ooh

# facet by number of doors
# uhmmmm
? facet_wrap

df_auto_data %>% ggplot (
  aes ( x = engine_size, y = highway_mpg, color = num_of_cylinders)) +
  geom_jitter( alpha = 0.2) +
  geom_smooth( method = lm, se = FALSE) + 
  facet_wrap( ~ num_of_doors)

# now for two variables, aw jeez. add drive wheels
? facet_grid

df_auto_data %>% ggplot (
  aes ( x = engine_size, y = highway_mpg, color = num_of_cylinders)) +
  geom_jitter( alpha = 0.2) +
  geom_smooth( method = lm, se = FALSE) + 
  facet_grid( drive_wheels ~ num_of_doors )
# nice

# filter out outliers - i.e. ? doors
df_auto_data %>% filter (num_of_doors != "?") %>%
  ggplot (
    aes ( x = engine_size, y = highway_mpg, color = num_of_cylinders)) +
  geom_jitter( alpha = 0.2) +
  geom_smooth( method = lm, se = FALSE) +
  facet_grid( drive_wheels ~ num_of_doors )
