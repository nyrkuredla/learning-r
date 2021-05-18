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
