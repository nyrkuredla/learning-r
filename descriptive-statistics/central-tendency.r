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

# working with the mean
# ? mean

mean (three_numbers) # 2
mean (four_numbers) # 25
mean (five_numbers) # 8.2
mean (na_numbers) # NA - so note that just one NA value in a set will make the mean return NA
mean (outlier_numbers) # 208.4

df$cyl %>% mean () # 5.888889
df$displ %>% mean () # 3.471795
df$hwy %>% mean () # 23.44017

# how to handle NA values? there's an argument for that
na_numbers %>% mean (na.rm = TRUE) # removes NA values and returns the mean of the remainder

# outliers can be an issue with mean - skewing the "center"
# trimming can assist by removing the "outermost" - highest and lowest - values so only the "center" is used to determine the mean
outlier_numbers %>% mean (trim = 0.1) # 10% trim - returns 208.4
outlier_numbers %>% mean (trim = 0.3) # 30% trim - returns 11
# so just removing 10% of the values didn't affect the mean - we need to ensure we're removing enough to actually impact the sample set

# median
median (three_numbers) #2
median (four_numbers) #25
median (five_numbers) # 8
median (na_numbers, na.rm = TRUE) # 8 
median (outlier_numbers) # 11

median (df$cyl) # 6
median (df$displ) # 3.3
median (df$hwy) # 24
# note that for the mpg columns, mean and median are similar but not exactly the same

# median holds up against outliers since there is no potential for "skewing" - just finding the center regardless of value
# testing this - replace the last value of the outlier_numbers vector with something else
outlier_numbers [5] <- 3^20
print (outlier_numbers)
outlier_numbers %>% median () # still 11 - larger number has no bearing on median
# but mean on the other hand:
outlier_numbers %>% mean () # 697356889, holy cow. big diff

# mode, aka mlv (most likely value)
mlv <- modeest::mlv()
mlv(df$cyl)
mlv (four_numbers)
mlv (na_numbers, na.rm = TRUE)

# quantile - sample quantiles corresponding to probability
quantile (df$displ) # defaults to quartiles

# summary - gives all these values in a handy block
df$displ %>% summary ()
# can also do the whole df
df %>% summary ()

# rank - sample ranks of values in a *vector* (so need to break out columns from a data frame)
df$hwy %>% rank () %>% head ()
df$cyl %>% rank () %>% head ()
# note that when lots of values are repeated, the rank can skip a lot of numbers to accommodate
# other functions available with different "flavors" of rank