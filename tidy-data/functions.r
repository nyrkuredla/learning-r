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

