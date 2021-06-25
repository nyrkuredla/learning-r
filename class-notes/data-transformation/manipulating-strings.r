## string manipulation

# load libraries
library (stringr)
library (tidyverse)

# for string functions, can pass in either a string literal (standalone) or a variable w/string data
## first let's practice storing string literals in variables

# string literal
"abc"
# assigning it to a variable
str_three <- "abc"
# can use either single or double quotes

# assign to variable and print in one line
(str_print_ex <- "Assigning and printing using parentheses")

# multi-line:
(str_multi_line <- "whoa, it's one line
and another
one more")

# use cat() to display actual newline
cat (str_multi_line)

# storing multiple strings in one variable - "character vector
# can store literals, variables, and NA
str_chr_vector <- c ("string 1", str_print_ex, NA, str_three)

cat (str_chr_vector)

## str_length gives the length of a string, usually 1-to-1 per character but there are exceptions
str_length (str_three)
str_length (str_chr_vector)
# so when you pass it a vector, it will count each value separately

## str_c - join multiple strings into a single string
? str_c()

str_combine_literals <- str_c ("one", "two") %>% print () 
# onetwo
str_length (str_combine_literals) 
# 6

str_chr_vector <- c ("five", "six", NA)
str_combine_mixed <- str_c (str_combine_literals, "three", str_chr_vector)
print (str_combine_mixed)
str_length (str_combine_mixed)

## recycling: replication of data in one vector to match the length of data in another
print (letters)
str_combine_letters <- str_c ("Letter: ", letters) 
print (str_combine_letters)
str_length (str_combine_letters)
# when the length of both character vectors is the same, they just match up
# when one vector is smaller than the other, but the larger one is a multiple of the second, it will multiply
# when one is smaller than the other and there is no whole multiple, it will recycle anyway but throw a warning
str_123 <- c ("1", "2", "3")
str_c (str_123, letters) %>% print()

## collapsing and separating strings - sep and collapse arguments on str_c
str_c (letters, collapse = "")
str_c (letters, collapse = ",")

# str_sub: extract and replace substrings from a character vector
str_fox_dog <- "The crazy brown fox jumped over the lazy dog."
# first 9 characters, using positional arguments
str_fox_dog %>% str_sub (1, 9)
# last 9
str_fox_dog %>% str_sub (start = -9)
# just 'dog'
str_fox_dog %>% str_sub (start = -4, end = -2)
# replace "dog" with "cats"
# note: piping doesn't work for this
str_sub (str_fox_dog, start = -4, end = -2) <- "cats"
print (str_fox_dog)

## str_detect - use regex to search strings
# Define strings
str_apple <- c(" apple pie", "apple", "Apple pie cake", 
               "banana apple pie", "blueberry pie", "apple apple", "apricot applesause cake")

# Return true false vector for strings containing 'apple'
# Assign to match_index
print("strings containing 'apple'")
match_index <- str_detect(str_apple, "apple")

# print match_index
print(match_index)

# Print strings associated with
# TRUE in match_index
# Hint: Use the index inside [] for the string variable
str_apple[match_index] %>% 
  print()

# print strings containing "pie"
match_index <- str_detect (str_apple, "pie")

str_apple[match_index] %>%
  print()

# print strings ENDING in "-pie"
match_index <- str_detect (str_apple, "pie$")

str_apple[match_index] %>%
  print()

# print strings STARTING with "apple"
match_index <- str_detect (str_apple, "^apple")
str_apple [match_index] %>%
  print ()

# print strings starting with EITHER Apple OR apple
match_index <- str_detect (str_apple, "^[Aa]pple")
str_apple [match_index] %>%
  print ()

