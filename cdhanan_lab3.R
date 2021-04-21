#1.	Get an explanation of the contents of the state.x77 data set: help("state.x77")

help('state.x77') #displays info about state.x77 - various stats about 50 US States

#2.	Create a dataframe from the built-in state.x77 data set, store in a variable named ‘dfStates77’

dfstates77 <- as.data.frame(state.x77) #coerce data into a dataframe
str(dfstates77) #check that it worked

#3.	Summarize the variables in your dfStates77 data set - using the summary() function

summary(dfstates77) #view rundown and common stats functions on dataframe

#4.	Calculate the total population of the U.S. by adding together the populations of each of the individual states in dfStates77.   Store the result in a new variable called totalPop77.

totalPop77 <- sum(dfstates77$Population)*1000 #sum all the pops in the states column of dfstates77, multiply to make it make sense

#5.	Use R code to read a CSV data file directly from the web. Store the dataset into a new dataframe, called dfStates17. The URL is: 
#"https://ist387.s3.us-east-2.amazonaws.com/lab/states.csv"
#Note: Use the function read_csv( ) to read in the data. 
#You will need to run library(readr) or library(tidyverse) before you can run read_csv( ).  If that generates an error, then you first need to do 
#install.packages("readr") or install.packages("tidyverse")

library(tidyverse) #import library
dfstates17 <- read_csv('https://ist387.s3.us-east-2.amazonaws.com/lab/states.csv') #read csv into dfstates17

#6.	Summarize the variables in your new data set, using the summary command.

summary(dfstates17) #view rundown and common stats functions on dataframe

#7.	The data you now have stored in dfStates17 were collected in 2017. As such, about 40 years passed between the two data collections. Calculate the total 2017 population of the U.S. in dfStates17 by adding together the populations of each of the individual states. Store the result in a new variable called totalPop17.  

totalPop17 <- sum(dfstates17$population) #sum all the pops in the pops column of dfstates17

#8.	Create and interpret a ratio of totalPop77 to totalPop17. Check to ensure that the result makes sense!

total.pop.ratio <- totalPop17/totalPop77 #Divides totalPop17 by totalPop77 and stores as a ratio
total.pop.ratio #results in 1.485875, which means there was about 1.5x the population in 2017 than in 2077 (adjusted earlier)

#Create a function that, given population and area, calculates population density by dividing a population value by an area value. Here is the core of the function:
  
popDensity <- function (pop, area) { #initialize function with parameters
    pop.dens <- pop/area #divide pop by area, store as pop.dens
    return(pop.dens) # This provides the function’s output
}

#9.	After you finish your function, make sure to run all of the lines of code in it so that the function becomes known to R.

#complete

#10.	Make a fresh copy of state.x77 into dfStates77 

dfstates77 <- as.data.frame(state.x77) #reloaded into variable coerced into a data frame type

#11.	Store the population vector in a variable called tempPop. 
#Adjust the tempPop as needed (based on your analysis at the end of the first breakout)

tempPop <- dfstates77$Population #stores vector as new variable
tempPop <- tempPop*1000 #adjust for scale of data

#12.	Store the area vector in a variable, called tempArea 

tempArea <- dfstates77$Area #stores vector as new variable

#13.	Now use tempPop and tempArea to call your function:
#popDensity(tempPop, tempArea)

dfstates77$popDensity <-  popDensity(tempPop, tempArea) #call and execute function with given parameters, store as new column

#14.	Store the results from  the previous task in a column of the dfStates77 dataframe, called popDensity.

#complete

#15.	Use which.max( ) and which.min( ) to reveal which is the most densely populated and which is the least densely populated state. Make sure that you understand the number that is revealed as well as the name of the state

rownames(dfstates77[which.max(dfstates77$popDensity),]) #state with the highest population

rownames(dfstates77[which.min(dfstates77$popDensity),]) #state with the lowest population
