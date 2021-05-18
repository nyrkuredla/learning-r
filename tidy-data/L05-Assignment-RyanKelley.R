
# Load libraries
library(lubridate)
library(tidyverse)

# Explore data structure
# Data: storms

# Display help on data
# ? storms
storms %>% head(5)



# first rearrange and group data to make a month/year column
df_months <- storms %>%
  mutate (year = as.integer(year), 
          month = as.integer(month), 
          hour = as.integer(hour),
          category = as.integer(category)) %>%
  mutate (month_year = make_date (year, month)) %>% 
  select (-year, -month, -day) %>%
  select (month_year, hour, everything()) # we have the new column now but still on hourly granularity

# group by month and calculate interesting values for other stats
df_months_plots <- df_months %>%
  group_by (month_year) %>%
  summarise ( max_wind = max(wind),
             min_wind = min(wind),
             max_pressure = max(pressure),
             min_pressure = min(pressure),
              avg_category = mean(category))

# avg category should be rounded and should be changed back to factor. 
df_months_plots <- df_months_plots %>%
  mutate (month_num = month_year %>% lubridate::month(label = TRUE)) %>%
  mutate (avg_category = avg_category %>% round ()) %>%
  mutate (avg_category = avg_category %>% factor (levels = c("1", "2", "3", "4"))) %>%
  select (month_num, everything())


df_months_plots %>% head(5)
# storms %>% head(5)

# let's also group by storm
df_names_plots <- storms %>%
  group_by (name) %>%
  summarise (max_wind = max(wind),
             min_wind = min(wind),
             max_pressure = max(pressure),
             min_pressure = min(pressure),
             avg_category = round(mean(as.integer(category))),
             avg_lat = mean(lat),
             avg_long = mean(long))  # same as before just in-line
  

df_names_coord <- df_names_plots %>%
    gather (lat_long, coordinates, avg_lat:avg_long)  

df_names_plots %>% head(5)
df_names_coord




# looking at maximum wind, minimum pressure, and average category per month to see which months had the most powerful storms

df_months_plots %>% head(5)
class(df_months_plots$avg_category)

gg_storm <- function (data, x_col, y_col) {
    # plot generation
    plt <- data %>% ggplot (mapping = aes_string(x = x_col, y = y_col)) +
    geom_point () +
    ggtitle (str_c(y_col, " vs. ", x_col))
    
    plt %>% print()
}

# want to iterate over to call each variable against month using the plot function above
y_cols <- c("max_wind", "min_pressure", "avg_category")

for (y_col in y_cols) {
    df_months_plots %>% gg_storm ("month_num", y_col)
}



# for the top 10 windiest storms, which had the lowest pressure? tracking average category by color
df_min_pressure <- df_names_plots %>% 
    arrange (desc (max_wind)) %>%
    head (10)

df_min_pressure %>% ggplot (aes (name, min_pressure, color = as.factor(avg_category))) +
    geom_point() +
    labs (title = "Minimum pressure measured for top 10 windiest storms")

# ---- ANALYSIS------
# My first goal with this assignment was to create a data frame to capture and graph various measurements calculated over the course of each month for which there was data. I wanted to see which months of the year are most likely to experience stronger storms, using average category, minimum pressure, and maximum sustained wind speed. I was also wondering if there is a significant variance in months that experienced minimum pressure vs. maximum wind speed, for example - while both measurements are indicators of a strong storm, there are any number of reasons why a storm with low pressure may not translate into high winds and high category, for example. The first graph does show a general correlation between high winds and low pressure, which makes sense, and largely aligns to the average category of storm encountered in that month. These graphs indicate that August, September, and October, in addition to being the most active hurricane months, also experience the strongest storms across all three variables. However, the graphs indicate there may be some variance when looking at the very strongest storms. My next chart therefore looked at the top ten windiest named storms, and plotted their minimum pressures. Unsurprisingly, category 4 storms (which indicate the highest winds) also generally had the lowest air pressure - but there are some exceptions. Hurricane Katrina had a very high maximum wind speed, which qualified it for inclusion on this list, but a middling average sustained wind speed, which explains its cat 2 status. However, Katrina has one of the lowest minimum pressures on the list, beating out all of the category 3 storms and even surpassing David (a category 4). This makes sense when considering that Katrina went through several weakening and re-strengthening cycles after it gained hurricane status - it initially achieved hurricane status while nearing Florida, and subsequently weakened as it made initial landfall. Only after Katrina entered the warm Gulf of Mexico did it restrengthen into the catastrophic category 5 as it is best known. Its "special" plot on this chart is an indicator of its astonishingly rapid reintensification.




