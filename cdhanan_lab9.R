library(arules)
library(arulesViz)
library(tidyverse)

data (Groceries) # Load data into memory
myGroc <- Groceries # Make a copy for safety
summary(myGroc) # What is the structure?

#1.Examine the data structure that summary() reveals. This is called a sparse matrix and it efficiently stores a set of market baskets along with meta-data. Report in a comment about some of the item labels.

#gives overall structure of the matrix
#tabulates the most frequent items (whole milk, other vegetables, etc.)
#gives how many times a given itemset occurs in the transactions
#basic stat infor (mean, min, max, etc.)

#2.Use the itemFrequency(myGroc) command to generate a list of item frequencies. Save that list in a new data object. Run str( ) on the data object and write a comment describing what it is. Run sort( ) on the data object and save the results. Run head( ) and tail( ) on the sorted object to show the most and least frequently occurring items. What’s the most frequently purchased item?

grocfreq <- itemFrequency(myGroc)
str(grocfreq) #this is a named numeric vector object
grocfreq <- sort(grocfreq)
head(grocfreq) #least frequently purchased item is baby food and sound storage medium, followed by preservation products
tail(grocfreq) #most frequently purchased item is whoe milk, followed my other vegetables and rolls/buns

#3.Create a frequency plot with itemFrequencyPlot(myGroc, topN=20) and confirm that the plot shows the most frequently purchased item with the left-most bar. Write a comment describing the meaning of the Y-axis.

itemFrequencyPlot(myGroc, topN=20) #the y-axis shows the frequency that the given item shows up in a given transaction

#4.Create a cross table with ct <- crossTable(myGroc, sort=TRUE). Examine the first few rows and columns of ct by using the square brackets subsetting technique. For example, the first two rows and first three columns would be ct[1:2, 1:3]. Write a comment describing one of values. Write a comment describing what is on the diagonal of the matrix.

ct <- crossTable(myGroc, sort=TRUE)
ct[1:3,1:3] #it shows how many transactions features both the given items being bought
#the diagonal is the identity of the cross table, so it shows the total number of transactions that item was purchased in

#5.Run the following analysis: 
   rules1 <- apriori(myGroc, 
                     parameter=list(supp=0.0008, conf=0.55), 
                     control=list(verbose=F),
                     appearance=list(default="lhs",rhs=("bottled beer")))

#6.Examine the resulting rule set with inspect( ) and make sense of the results. There should be four rules in total. 

inspect(rules1)
   
#7.Adjust the support parameter to a new value so that you get more rules. Anywhere between 10 and 30 rules would be fine. Examine the new rule set with inspect( ). Does your interpretation of the situation still make sense?

rules2 <- apriori(myGroc, 
                  parameter=list(supp=0.0004, conf=0.55), 
                  control=list(verbose=F),
                  appearance=list(default="lhs",rhs=("bottled beer")))

inspect(rules2)

#8.Power User: use mtcars to create a new dataframe with factors (e.g., cyl attribute). Then create an mpg column with “good” or “bad” (good MPG is above 25). Convert the dataframe to a transactions dataset and then predict rules for having bad MPG.

cars <- mtcars
cars %>% 
  mutate(mpg_scale = ifelse(mpg>25,'good','bad')) %>% 
  mutate_all(as.factor) -> cars_scaled

str(cars_scaled)

trans_cars <- as(cars_scaled,'transactions')

itemLabels(trans_cars)

rules_cars <- apriori(trans_cars,
                      parameter=list(supp=0.4, conf=0.5),
                      control=list(verbose=F),
                      appearance=list(default = 'lhs', rhs='mpg_scale=bad'))

inspect(rules_cars)
