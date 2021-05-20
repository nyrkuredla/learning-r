# creating functions to make code more readable, streamlined, and have to update in fewer places
# can then call the functions using for-loops

# the classic
f_hello_world <- function () {
  print ("Hello, world!")
}

f_hello_world # this prints the definition of the function
f_hello_world() # Hello, world!
# call functions with the () even when there are no params defined in the function

# speaking of params
f_print_msg <- function (msg) {
  print(msg)
}

f_print_msg("Hi, mom!")
f_print_msg("Yay")

# return 
help ("return") # use help since it's a keyword

f_adding <- function (x = 0, y = 0) { # setting default values
  return (x + y)
}

f_adding (2, 3) # 5
f_adding (6) # x = 6, y = 0, returns 6
f_adding (y = 7) # x = 0, y = 7, returns 7

# require, install.packages and library load add-on packages
? require
? install.packages

# using if for flow control

# write a function to load library, and if it fails, catch the failure and trigger installation of a package
f_load_library <- 