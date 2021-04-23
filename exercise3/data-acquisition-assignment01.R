# weekly assignment - analyse the sale of houses using the house_listings dataset
# criteria: runs without error, create 3 ggplot charts, write brief analysis, include given R features
# features: as.factor, as.integer, as.double, labs, pipe, map data to color, chart includes categorial variable

# first load library
library (tidyverse)

# explore data structure
load (file = "./house_listings.RData")
house_listings %>% glimpse ()
# observations 1000, variables 8, all chr type

# create a new data type with appropriate data types and data cleaning
df_house_data <- house_listings %>%
  mutate (city = as.factor(city),
          sales = as.integer(sales),
          year = as.factor(year),
          month = as.factor(month),
          volume = as.integer(volume),
          median = as.factor(median),
          listings = as.integer(listings),
          inventory = as.double(inventory))

# creating a new Season column based off of month number
df_house_data <- df_house_data %>% mutate (season = case_when (month %in% c('12', '1', '2') ~ "Winter", 
                                                               month %in% c('3', '4', '5') ~ "Spring", 
                                                               month %in% c('6', '7', '8') ~ "Summer", 
                                                               month %in% c('9', '10', '11') ~ "Autumn")) %>%
  mutate (season = as.factor(season))

glimpse(df_house_data)

# looking at sales per city first, with jitter
df_house_data %>% ggplot (aes (x = sales, y = city)) +
  geom_jitter (alpha = 0.3) + 
  labs (title="House Sales per City, Texas")

# does the time of year make an impact on home sales per city? let's map by color
df_house_data %>% ggplot (aes (x = sales, y = city, color = season)) +
  geom_jitter (alpha = 0.3) + 
  labs (title="House Sales per City and Price, Texas")

# appears to be pretty randomly scattered per season, but wonder if this changes looking at the cities which had the highest number of sales
df_house_data %>% 
  filter (city %in% c("Austin", "San Antonio", "Houston", "Dallas", "Corpus Christi")) %>%
  ggplot (aes (x = sales, y = city, color = season)) +
  geom_jitter (alpha = 0.3) + 
  labs (title="House Sales per City and Price, Texas", subtitle="Inc. Top 5 Highest-Selling Cities") 



