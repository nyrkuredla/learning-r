# Data Transformation
as soon as we import data into R, have to make decisions about how to organize it

topics include:
* how best to organize data across multiple data frames? database normalization?
* creating complete and consistent data for analysis
* joining data frames together (like SQL joins)
* string manipulation techniques, RegEx
* managing dates and looking at time series data

## Relational data
- Rare that data analysis involves only one table of data; you must typically combine multiple to get the answers you want
- Multiple tables of data = _relational data_ because it's the relations, not just the individual data sets, that are important
- Relations always defined between a pair of tables - three or more is a property of relations between each individual pair

### Working with relational data
Need verbs that work with pairs of tables, like:
* Mutating joins - add new variables to one from data frame, using matching observations in the other
* Filtering joins - filter observations from one data frame based on whether they match observations in the other
* Set operations - treat observations as if they were set elements

Looking at database diagrams and etc., key to remember that you just need to focus on individual relationships between pairs of tables, and chain those together to get the info you need

### Keys

* Variables to connect each pair of tables
* 2 types of keys: primary and foreign
** Primary = unique observation in its own table
** Foreign = unique observation in another table
** A key can be both types at once

Good practice to make sure that your primary keys are in fact unique:
```
planes %>%
  count (tailnum) %>%
  filter (n > 1) # anything returned with count more than 1 has dupes
```

What if a table lacks a private key? This can happen - for example with the *nycflights13* data, you'd think the flightnum column would have tailnum or something as its PK, but it doesn't. A PK can be added with _mutate()_ and _row_number()_. Adding a key like this is called a *surrogate key*.

The primary key and the corresponding foreign key in another table are what form a relation (typically one-to-many, e.g. each flight has one plane, but one plane might have many flights).
