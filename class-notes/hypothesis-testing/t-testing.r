# T-TESTS
## First: Two-Sided T-Test

# ---------------   NOTES ----------------

# two-sided hypothesis test re: population means of two groups, based on samples from two groups - two-sided since null hypothesis can be rejected for two reasons
# one: the first sample mean is sufficiently larger than the second
# two: the first sample mean is sufficiently smaller than the second
# i.e. in either case rejecting the null hypothesis - there is some kind of significant difference between the two - but not specifying which is larger

# Assumptions:
# two normally distributed populations
# population variances are unknown and not assumed to be equal

# rejection regions are in both of the two tails of the normal distribution of the difference in group means
# extreme positive being upper
# extreme negative in lower
# typically "cutoff" values are set to make probability in each 0.25, so combo of 0.5

# so: if p-value for the test is less than 0.5, the null hypothesis is rejected (default hypothesis)
# if the p-value is greater than 0.5, the null hypothesis is not rejected (note: NOT accepted, this is different!)

# we can use t.test to perform hypothesis tests in R

library (tidyverse)

# loading the data
df_ames_housing <- "./AmesHousing.csv" %>% read_csv()

# let's look at Old Town and Somerst neighborhoods and sales prices

# first make a df with all the data we want
df_ames_housing <- df_ames_housing %>%
  mutate_if (is.character, as.factor) %>%
  select (Neighborhood, SalePrice)

# new df with just Somerst to explore that data
df_somerst <- df_ames_housing %>%
  filter (Neighborhood == "Somerst")

# ditto Old Town
df_old_town <- df_ames_housing %>%
  filter (Neighborhood == "OldTown")

# check em out: mean and standard deviation
somerst_mean <- df_somerst$SalePrice %>% mean () %>% round(1)
somerst_sd <- df_somerst$SalePrice %>% sd () %>% round(1)
# print results
cat(str_c("Somerst: mean = ", somerst_mean, " and standard deviation = ", somerst_sd))

# same with old town
old_town_mean <- df_old_town$SalePrice %>% mean () %>% round(1)
old_town_sd <- df_old_town$SalePrice %>% sd () %>% round(1)

# print results
cat(str_c("OldTown: mean = ", old_town_mean, " and standard deviation = ", old_town_sd))

# Somerst has a mean of 229707 and Old Town has 123991, just about half
# standard deviation is 57437 vs 44327 so much closer
# the difference in variance is a good general indicator of statistical significance

# time to find out
cat ("\n***** Somerset vs Old Town ****")
t.test (df_somerst$SalePrice, df_old_town$SalePrice, conf.level = 0.95, alternative = "two.sided")
# p-value is crazy low, so the null hypothesis is BOOM REJECTED
# note the confidence intervals - for the difference in population means


## Next: One-Sided T-Test
# ---------------- NOTES -----------------
# difference here between the one- and two-sided hypotheses is that the one-sided hypothesis presumes which mean should be larger
# i.e. whether the mean house price in Somerst is *larger* than that in Old Town

# null hypothesis is still: both mean prices are the same
# alternative one-sided hypothesis is now: Somerst prices > Old Town prices

# therefore the rejection region for this hypothesis is also one-sided (i.e. on one tail)
# IMPORTANT: the order of vectors in t.test is important! because it will use the order to interpret the alternative

# let's do this
# reuse the same dfs just for one-sided testing
# recall that the mean of Somerst was almost double the mean of Old Town while sd was not that different

t.test ( df_somerst$SalePrice, df_old_town$SalePrice, conf.level = 0.95, alternative = "greater") # left is greater than right

# t-statistic, p-value, and degrees of freedom are the same as for the two-sided test
# indicating that the null hypothesis has been rejected (i.e. statistically significantly different means)
# note that t is positive

# confidence interval is different. previously we got both.
# in this case, we get one for the *difference* in population means. for a significant result, the confidence interval does NOT contain 0
# the other side is shown as positive or negative infinity
# so in this case: the lower end of the CI is 97,249 and the upper end is +infinity. so does not contain zero, thus rejecting (again) the null hypothesis

# just for chuckles let's run it the other way
t.test ( df_old_town$SalePrice, df_somerst$SalePrice, conf.level = 0.95, alternative = "greater")

# yikes
# t is now negative
# p-value has changed to 1 - we fail to reject the null hypothesis
# confidence interval has changed from infinity to -114,182; this range contains 0 so is not a significant result

## Third: T-Test with Factors
# let's use Central Air as a third factor this time

# t.test wants only two factor levels - a column with two factor levels will work

# make a new dataframe inc. central air
df_ames_housing <- "AmesHousing.csv" %>% 
  read_csv () %>%
  mutate_if (is.character, as.factor) %>%
  select (Neighborhood, 'Central Air', SalePrice)

# glimpse(df_ames_housing)
# now create a new df with just Old Town and Somerst neighborhoods

df_neighborhoods <- df_ames_housing %>%
  filter (Neighborhood %in% c ("Somerst", "OldTown"))

summary (df_neighborhoods)
# note that the summary still includes zero values for the neighborhoods we didn't choose. not a dealbreaker in this case but can drop them if desired using fct_drop()

# let's perform the t.test on SalePrice and Neighborhood
t.test ( SalePrice ~ Neighborhood, data = df_neighborhoods)
# recall that only for one-sided tests does the order matter; in this case it does not
# recall also: t negative, p-value < 0.05, confidence interval does not encompass 0
# null hypothesis is rejected

# trying another one - does central air drive sale price?
t.test ( SalePrice ~ `Central Air`, data = df_neighborhoods)
# negative t, p < 0.05, confidence interval does not encompass 0
# null hypothesis rejected

# ----- part 4: Data Distribution -----------
# exploring uniform vs. normal vs. t distributions

# uniform distribution: like trying to simulate random numbers in a range from 1 to 100
# i.e., equal probability for any and all values across the range
# contrast with the other distributions we've seen earlier - normal and T indicate that there are some values which are more common than others (mean vs. nearer tail)
# use runif() to sample from uniform (stands for Random UNIForm, I guess)
# other [x]unif() functions include dunif (density), punif (probability), qunif (quantile)...

v <- runif (n = 100)
head (v)
summary (v)
# note the values here are pretty darn close to what we'd expect for a uniform distribution of #s from 0 to 1
# let's change from 0 to 100 instead
v_unif <- runif(n = 100, min = 1, max = 100)
head (v_unif)
summary (v_unif)

# now let's make a data frame out of it so we can plot it
df_unif <- data_frame (v=v_unif, dist = "Uniform")
glimpse(df_unif)

# plottin
df_unif %>%
  ggplot (aes (x = seq_along (v), y = v)) +
  geom_point () +
  labs (title = "100 random points", subtitle = "Distribution: Uniform")
# yup, pretty scattered

# now compare with normal distribution
# same basic idea but with r_norm 
v_norm <- rnorm (n = 100, mean = 50, sd = 10)
v_norm %>% head()
v_norm %>% summary()

# plotting and comparing the plot with the uniform distribution will make the difference more clear
df_norm <- data_frame (v = v_norm, dist = "Normal")
glimpse (df_norm)

df_norm %>% 
  ggplot (aes (x = seq_along(v), y = v)) +
  geom_point () +
  labs (title = "100 random points", subtitle = "Distribution: Normal")
# points are clustered more tightly around the middle

# now let's do both in one df so it doesn't auto-adjust each
df_both <- df_norm %>% bind_rows (df_unif) # combine the data frames
glimpse (df_both)

df_both %>%
  ggplot (aes (x = seq_along(v), y = v, color = dist)) +
  geom_point() +
  facet_wrap ( ~ dist, scales = "free_x") +
  labs (title = "100 random points", subtitle = "Distribution: Normal and Uniform")
# dang

# let's compare using a density plot now
bw <- 20
df_both %>% ggplot (aes (x = v, fill = dist)) +
  geom_density (alpha = 0.8) +
  theme_dark() 
# yowza. big ol peak with Normal, gentle hump with Uniform 



