# 1.	Use the command line in R-Studio to add together all of the numbers between 1 and 10 (inclusive). 
# Take note of the result. Remember, every student should type and run the code on their own copy of R-studio.

#The answer is 55

# 2.	Now create a vector of data that contains the numbers between 1 and 10 (inclusive). 
# Here is a line of code to do that:


myNumbers <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10) #creates a vector with the values 1-10 called myNumbers


# 3.	Now add together all of the numbers that are in the vector myNumbers. 
# There is a built-in function within R that can do this for you in one step: 
# Take a guess as to the name of that function and run it on myNumbers. 
# Check your result against the results of question 1.

sum(myNumbers) #totals all values in the vector myNumbers
#The answer matches the answer from number 1 (55)

# 4.	R can do a powerful operation called “vector math” in which a calculation runs on every element of a vector. 
# Try vector math on myNumbers by adding 10 to each element of myNumbers, and storing the result in myNewNumbers.  
# Print out myNewNumbers.

myNewNumbers <- myNumbers + 10 #adds 10 to every element in the vector myNumbers, stores as new variable myNewNumbers
myNewNumbers #prints myNewNumbers

# 5.	Efficiently calculate a sum of the numbers between 11 and 20 (inclusive), 
# using techniques from the problems above. Hint: use c(11:20)

x <- c(11:20) #stores all values between 11 and 20 (inclusive) to the vector x
sum(x) #adds all values of vector x together

# 6.	Calculate a sum of all of the numbers between 1 and 100 (inclusive), using techniques from the problems above.

sum(1:100) #adds all values from 1 - 100 together

# 7.	Make sure you have a variable myNumbers, that is a vector of 10 numbers (1,2,3,4,5,6,7,8,9,10)

myNumbers #prints myNumbers

# 8.	Add the following commands to the end of your code file and run each one:

mean(myNumbers) #Calculates the average of the values in the vector myNumbers
median(myNumbers) #Calculates the middle value of the values in the vector myNumbers
max(myNumbers) #Calculates the maximum value of the values in the vector myNumbers
min(myNumbers) #Calculates the minimum value of the values in the vector myNumbers
length(myNumbers) #Calcuates the number of values in the vector myNumbers

# 9.	Add a comment to each of the lines of code in your file explaining what it does. The comment character is “#”. 

#See other questions

# 10.	Explain the output of the following command:

myNumbers > 5 #passes every value of myNumbers individually through the logical test, outputting a logical vector as a response for each test

# 11.	Explain what in is bigNum after executing the following command:

bigNum <- myNumbers[myNumbers > 5] #bigNum is a vector which includes the subset of values of myNumbers which pass the logical test

# 12.	Whenever you need R to explain what a command does and how it works, use the ? command or the help() command. 
# Add and run these commands:

?mean #shows documentation about the "mean" function
help("mean") #shows documentation about the "mean" function


# 13.	The homework asks you to create a conditional statement with if and else. 
# A conditional statement is part of a larger group of specialized commands that control the 
# “flow” of a program – what command gets run and when. You can get help on if, else, and other control words. 
# Add and run these commands:

help("if") #shows documentation about the keyword "if"
help("Control") #shows documentation about "control flow"

# Now add and run your first conditional statement:

if (sum(myNumbers) > 40) print("The sum is greater than 40.") #if the test is true, print the string; otherwise do nothing
