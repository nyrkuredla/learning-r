# tidy data: data organization principles to facilitate more agile analysis (Hadley Wickham)
# 1. each variable forms a column
# 2. each observation forms a row
# 3. each observational unit forms a table

# load libraries
library (stringr)
library (tidyverse)
library (lubridate)

# let's see some help about the tidyr package
# library (help = "tidyr")

# revisiting read_csv
# import sample data, store in df
df <- "weather.csv" %>% read_csv ()
glimpse (df)
# display
df # columns d1-d10 represent the first ten days of the month
# given that the "grain" of this table is daily, there should be one row per day, but currently we have three rows per month. hm

# gather() - gathers columns into key-value pairs
? gather
# let's turn columns d1-d10 into two columns - day, and value per day
# columns can be selected using col1:coln

df2 <- df %>%
  gather (day, value, d1:d10)
glimpse (df2)
# display first 12 rows
df2 %>% head(12)
# now we can see two new columns: day (d1...) and value, inserted from the former columns d1 through d10
# also means there are more rows than before

# next: convert day values from characters to integers
# can do this by parsing out a number from an atomic vector - there is a function for this!

? parse_number # drops any non-numeric characters before or after the first number.

df3 <- df2 %>% 
  mutate (day = parse_number(day) %>% as.integer(), month = as.integer(month), year = as.integer(year))
# let's also move the day column over so it's next to month and year
df3 <- df3 %>%
  select (id, year, month, day, everything())
glimpse(df3)

# now year/month/day are all integers and all next to each other. let's combine into a single column
? make_date

df4 <- df3 %>% 
  mutate (date = make_date (year, month, day)) %>% # new date column as combo of other columns
  select (-year, -month, -day) %>% # removing original columns
  select (id, date, everything()) # rearranging

df4 %>% glimpse ()
# however, there are still three rows per date (per measurement) - we want just one row with each metric in its own column

# make one column into multiple columns - spread a key-value pair across multiple columns

? spread
# so what we want to do is create a separate column for each unique value in a particular column (element)
# and then move the associated value in the value column to the newly created column
# so ultimately "element" and "value" columns will be replaced by "tmax", "tavg" and "tmin" columns containing the values

df5 <- df4 %>% 
  spread (element, value) %>% # element is the key, value is value
  select (id, date, tmax, tavg, tmin)

glimpse (df5) # now we have 5 columns including the new ones with the values

# NOW let's separate one column into multiple columns
? separate

# recall that the "id" column has a format like "seattle_wa"
df6 <- df5 %>%
  separate (id, c("city", "state"), sep = "_") %>%
  select (city, state, everything()) 
glimpse (df6)

# let's plot the result!
df6 %>% ggplot (aes (x = date, y = tavg)) + 
  geom_point () +
  geom_line () +
  labs (title = "Average temperatures in Seattle, WA, Oct-Nov")

# now let's plot with all temp metrics as y axis
# using gather()
df6 %>% 
  gather (element, value, tmax:tmin) %>%
  ggplot (aes (x = date, y = value, color = element)) + 
  geom_point() +
  geom_line() +
  labs (title = "Max, Min, and Average Temps in Seattle, WA, Oct-Nov")
# yikes, that peak max temp tho
