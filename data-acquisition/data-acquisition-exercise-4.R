# data type conversion

# data conversion is an ongoing, iterative process - from import through data wrangling
# what data is important? how should it be transformed?

# load libraries
library ( forcats )
library ( tidyverse )

# load data from csv file into a frame
df_auto <- read_csv ("auto.csv")
# check it out
glimpse (df_auto)
# what are we interested in and what can we ignore?
# what are the most appropriate data types for what we are interested in?
# to change data type, is any data cleaning needed per column?
# are there missing values? how best to handle them?

# in this case we want to analyze fuel economy vs. vehicle/engine size
# create a df with just the columns of interest

df_auto_data <- df_auto %>%
  select ( fuel_type,
           drive_wheels,
           curb_weight,
           engine_type,
           num_of_cylinders,
           engine_size,
           fuel_system,
           horsepower,
           city_mpg,
           highway_mpg)
# checkin
glimpse ( df_auto_data )

# summary() gives some stats and ideas of missing values. let's just take a peek for now
summary (df_auto_data)

# factors normalize chr strings by referencing them by number
# use as.factor to play with conversion, see what's in there / what needs to be addressed
# num_of_cylinders and horsepower columns have potential to be integer data type...

# combine as.factor and summary to see more
df_auto_data$num_of_cylinders %>% as.factor () %>% summary ()
# returns the columns and number of rows in each. what do we want to focus on? 

df_auto_data_46cyl <- df_auto %>%
  filter (num_of_cylinders %in% c("four", "six"))

# check
glimpse (df_auto_data_46cyl)

# mutate - change existing and create new columns
# convert cylinders to a factor
df_auto_data <- df_auto_data %>% 
  mutate (num_of_cylinders = as.factor (num_of_cylinders))

# view with levels
levels (df_auto_data$num_of_cylinders)
glimpse (df_auto_data)
# note the data type changed on the column

# let's change some more data types to factors
df_auto_data <- df_auto_data %>%
  mutate (fuel_type = as.factor (fuel_type),
          drive_wheels = as.factor (drive_wheels),
          engine_type = as.factor (engine_type),
          fuel_system = as.factor (fuel_system))
# confirm - these should be fct type now
glimpse (df_auto_data)
# summary
summary (df_auto_data)

# from the summary we can see that 4 wheel drive is a tiny amount of data - let's remove it
df_auto_data <- df_auto_data %>%
  filter (drive_wheels != "4wd")

glimpse (df_auto_data)
summary (df_auto_data)
