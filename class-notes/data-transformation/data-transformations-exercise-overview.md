# Data Transformation
as soon as we import data into R, have to make decisions about how to organize it

topics include:
* how best to organize data across multiple data frames?
* database normalization - combine data to avoid repeating itself in the same table; the data is stored once in a different table which refers back to the first
* creating complete and consistent data for analysis
* joining data frames together (like SQL joins)
* string manipulation techniques, RegEx
* managing dates and looking at time series data

## Relational data
- Rare that data analysis involves only one table of data; you must typically combine multiple to get the answers you want
- Multiple tables of data = _relational data_ because it's the relations, not just the individual data sets, that are important (as well as relational integrity)
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

# Joins
## Inner Joins
Matches pair of values whenever the keys are equal. Any unmatched rows are dropped.
Outputs a data frame which contains the key, x-value, and y-value per row.

Generally not useful for analysis, then, because there's too much data loss from unmatched values being dropped.

## Outer Joins
Keeps observations that appear in at least one of the tables. 3 types of outer joins.
### Left join
Keeps all the values in _x_.
* Should be default join; preserves the original observations even when there isn't a match.
### Right join
Keeps all the values in _y_.
### Full join
Keeps all the observations in both _x_ and _y_.

All outer joins work by adding a "virtual" observation which has a key that always matches (if no other keys do), and a value filled with NA.

# Duplicate keys
Two possibilities:
* One table has duplicate keys
* Both tables have duplicate keys (something has usually gone wrong somewhere at this stage, since neither stage can give a unique identification of an observation)

Be aware of when there are keys that _look_ the same but are not - "year" in one table may not truly match the other

# Data Warehouse Design Principles
How do we know how many data frames are ideal for storing data? One, many? Just a matter of preference?
* a key decision for data wrangling - ideally we'd just have one frame, but there are reasons for having more than one.
** Star schema vs. snowflake schema
* a data frame for each level of data _granularity_ is a good default notion - each grain/frame optimized to answer different levels of questions
** data traceability is also easier this way - worth the effort to have a tidy set to work with that is consistent

## Traceability
* Source system table and column names, for easy reference back to original
* Source system natural (primary) keys, ditto
* Choose a single natural key, or generate a surrogate, and use that throughout
* Add lookup tables back to natural keys
* Keep snapshot copy of data
