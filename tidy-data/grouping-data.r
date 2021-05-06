# grouping and summarizing data using dplyr

# load libraries
library (forcats)
library (stringr)
library (tidyverse)

# help
library (help = "dplyr")

# take alook at the data
mpg %>% glimpse()
mpg %>% head(12)

# let's look at distinct rows - we can look by column in a table
mpg %>% distinct (class) # lookin at the class column

# group a tbl by one or more variables
# this lets us do data operations "per group"
? group_by

# summarise - summarize multiple values to a single value
? summarize # works the same as summarise()

# n() - the number of observations in the current group - can only be used from *within* summarise, mutate, and filter
?n

# arrange: arrange rows by variables - desc, etc.
# generally will not automatically order by grouping variables
# desc() - group by descending order 

# trying it out - display the distinct values of mpg$class and row count
# sort by largest class first
# using group_by, summarize, arrange, n
mpg %>% 
  group_by (class) %>% # grouping the class values together
  summarize (n = n()) %>% # providing a single value/summary, using the number of rows contained in the group (n())
  arrange (n %>% desc()) # sorting the summary values in descending order
# once we have these counts, we can do other stat operations on them, etc.

# but if all we want to do is get this kind of group count, there's a more convenient function: tally
? tally

# trying the same thing again
mpg %>% 
  group_by (class) %>% # still have to designate what is being...tallied
  tally (sort = TRUE) # default is false - true will show the largest groups at the top
# same thing

# count is even easier cause it's a wrapper for tally that does the group by for you
? count # note that add_count and add_tally also do the same thing, except they add another column with group-wise counts

# display the distinct values of mpg$class and row count, using count
# sort results, largest first
mpg %>%
  count (class, sort = TRUE)

# sort hwy data to have min, max, and mean hwy miles per gallon by class
df <- mpg %>% 
  group_by (class) %>% # first group by class
  summarize (hwy_max = hwy %>% max(), # calculating, e.g., the max hwy mpg per class
             hwy_avg = hwy %>% mean(), 
             hwy_min = hwy %>% min())  
glimpse(df)
df
# one row per unique class - also note that max and min are int while avg is dbl
# let's get hwy_min, hwy_max, hwy_avg into key-value pair columns hwy_metric and hwy_value (gather)
df2 <- df %>%
  gather (hwy_metric, hwy_value, hwy_max:hwy_min) 

glimpse (df2)
df2

# remove the "hwy_" prefix from the hwy_metric column and store result in df3
df3 <- df2 %>%
  mutate (hwy_metric = hwy_metric %>% str_replace ("hwy_", ""))

glimpse (df3) # prefix has been removed from the values in the column

# plotting the values using geom_col
df3 %>% ggplot (aes (x = hwy_metric, y = hwy_value)) +
  geom_col()

# rearranging the column order so it's min, avg, max
# let's also convert hwy_metric to a factor and order the levels

df4 <- df3 %>%
  mutate (hwy_metric = hwy_metric %>% as.factor())
# display levels and row count
df4$hwy_metric %>% fct_count() # 7 each, still avg - max - min
# let's reorder
df4 <- df4 %>%
  mutate (hwy_metric = hwy_metric %>% fct_relevel (c ("min", "avg", "max")))

# look again
df4 %>% ggplot (aes (x = hwy_metric, y = hwy_value)) +
  geom_col() # right order now

# fill by class
df4 %>% ggplot (aes (hwy_metric, hwy_value, fill = class)) +
  geom_col (position = "dodge")
             
# now facet by class too to group them together
df4 %>% ggplot (aes (hwy_metric, hwy_value, fill = class)) +
  geom_col (position = "dodge") +
  facet_grid ( ~ class)

# finally - boxplot to further explore deltas
mpg %>% 
  ggplot (aes (class, hwy, fill = class)) +
  geom_boxplot()

# varwidth changes the width of each box in proportion to the number of rows of that class
mpg %>% 
  ggplot (aes (class, hwy, fill = class)) +
  geom_boxplot (varwidth = TRUE)
# can see that e.g. SUV class has a higher number of rows (since the box is wider), but most of the values still fall in the same range
