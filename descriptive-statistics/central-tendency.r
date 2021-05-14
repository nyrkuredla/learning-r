# central tendency: descriptive statistics to describe and quantify the "center" of the dataset
# naturally, lots of ways to define "center" depending on the goal and the data being described

# using the mpg dataset and modeest package to find the....mode

library (tidyverse)
install.packages ("modeest")

# halp
# library (help = "modeest")

# creating some sample data
three_numbers <- c (1, 2, 3)
four_numbers <- c (10, 20, 30, 40)
five_numbers <- c (6, 7, 8, 12, 8)
na_numbers <- c (NA, 7, NA, 100, 8)
outlier_numbers <- c (9, 10, 11, 12, 1000)

# also grabbing a sample data frame with some mpg data
df <- mpg %>% select (cyl, displ, hwy)
df %>% glimpse ()