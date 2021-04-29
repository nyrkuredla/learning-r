# string manipulation

# load libraries
library (stringr)
library (tidyverse)

# for string functions, can pass in either a string literal (standalone) or a variable w/string data
# first let's practice storing string literals in variables

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
cat(str_multi_line)

# storing multiple strings in one variable - "character vector
# can store literals, variables, and NA
str_chr_vector <- c("string 1", str_print_ex, NA, str_three)

cat(str_chr_vector)
