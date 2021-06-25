# Creating Regression Prediction Models - Intro

## Objectives
* Describe basic methods of machine learning;
* Define ML and why it's useful;
* Explore basics of linear single and multiple regression models to predict numeric values;
* Identify performance metrics and fit evaluation methods used to evaluate regression models

## Reading notes - R for Data Science - https://r4ds.had.co.nz/model-intro.html
### Intro
* More focused at this point on exploration rather than confirmation or formal inference
* Goal of a model is to provide a simple summary of a dataset - capture "signals" and ignore "noise"
* Predictive models - generate predictions based on sample. As opposed to "data discovery", which looks for interesting relationships within dataset
** Also known as supervised vs. unsupervised

## Hypothesis generation vs. hypothesis confirmation
* Modelling for _inference_ - validating whether a hypothesis is true - can be hard. Two crucial principles for doing this right:
** Each observation can be used either for exploration or confirmation. You cannot use the same observation to do both.
** You can use an observation repeatedly for exploration, but for confirmation only once. You need to use data for confirmation that is different than from what was used to generate the hypothesis.

* Confirmation might look like this, then (data breakdown):
** 60% of data goes into training/exploration dataset
** 20% into query set - to compare models or visualizations by hand, but NOT for automated crunching
** 20% for a test set to test the final model, to be used _once and only once_.

## Model basics
* Can use (and in this case will use) models to particion data into patterns and residuals. "Peel back layers" to identify subtler trends in a dataset
* Two parts to a model:
** Define a family of models to capture a precise yet generic pattern, expressed as an equation (i.e. quadratic equation, etc.)
** Generate a fitted model - find the model from your established family which best describes the dataset in question
** Important to recall here that this is just the best fit *from the established family*. It still might be a bad model! George Box: "All models are wrong, but some are useful."
** In other words, all models are approximations and therefore will never be exactly true to a dataset. We just hope for a model that is useful in some way.

## Trying it out
I'll do exercises in a separate R worksheet, starting with the first assigned lab - _L08-E1-Linear Regression-RyanKelley_.

## Other notes I'm finding useful so far:
I'll flesh this out later, but in my reading/research for future reference:
* https://statisticsbyjim.com/regression/overfitting-regression-models/#:~:text=Overfitting%20a%20model%20is%20a,than%20the%20relationships%20between%20variables.&text=In%20regression%20analysis%2C%20overfitting%20can,coefficients%2C%20and%20p%2Dvalues - Overfitting
