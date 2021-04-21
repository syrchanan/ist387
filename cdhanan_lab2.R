#1.Make a copy of the built-in iris data set like this:

myIris <- iris #store dataset in variable
  
#2.Get an explanation of the contents of the data set with the help function:

help("iris") #looks up documentation for the data set
  
#3.Summarize the variables in your copy of the data set, like this:

summary(myIris) #take an overview of the data frame
  
#4.The summary() command provided the mean of each numeric variable. 
  #Choose the variable with the highest mean and list its contents to the console. 
  #Any variable can be echoed to the console simply by typing its name. 
  #Here’s an example that echoes the variable with the lowest mean to the console: myIris$Petal.Width
  
myIris$Sepal.Length #echoes the column Sepal.Length as a vector from the data frame myIris

#5.Now repeat the previous command, but this time sort the variable by calling the
  #sort() function and supplying that variable. Remember to choose the variable with the highest mean. 

sort(myIris$Sepal.Length) #arranges the values of the vector Sepal.Length in ascending order
  
#6.Now repeat the previous command, but instead of sort(), use order(). 
  #Remember to choose the variable with the highest mean.  

order(myIris$Sepal.Length) #prints the indices of the vector Sepal.Length in order as if the values were sorted
  
#7.Write a comment in your R code explaining the difference between sort() and order(). 
  #Be prepared to explain this difference to the class.

#see above
  
#8.Now use the order command to reorder the whole data frame, store the new dataframe in a variable called ‘sortedDF’

SL.order <- order(myIris$Sepal.Length) #save the order as a variable
sortedDF <- myIris[SL.order,] #sort the dataframe by subsetting the order
  
#9.Finally, use View() to examine your reordered data frame and be prepared to report on the first few rows

View(sortedDF) #print the dataframe

#10.Get an explanation of the scale() command with the help function:

help("scale")

#11.Run scale(myIris$Sepal.Length, center=0, scale=T) and explain the result in a comment. 
   #Make sure that all of the members of your group understand what the comment is saying. I may call on anybody!

scale(myIris$Sepal.Length, center=0, scale=T) #scales the data of the vector Sepal.Length proportionately in order to standardize the data around a given point (0)

#12.Add a new variable to the myIris data set that contains a scaled version of Sepal.Length, called scaledSL

scaledSL <- scale(myIris$Sepal.Length, center=0, scale=T) #creates a scaled version of SL, around the point 0
myIris$scaledSL <- scaledSL #appends scaledSL as a column to myIris
View(myIris) #View the new dataframe

#13.Repeat the previous process to add a scaled version of each of the other 
   #three numeric variables to your data set. Check your results by running the View() command on the data set.

scaledSW <- scale(myIris$Sepal.Width, center=0, scale=T) #creates a scaled version of SW, around the point 0
scaledPL <- scale(myIris$Petal.Length, center=0, scale=T) #creates a scaled version of PL, around the point 0
scaledPW <- scale(myIris$Petal.Width, center=0, scale=T) #creates a scaled version of SW, around the point 0

myIris$scaledSW <- scaledSW #appends scaledSW as a column to myIris
myIris$scaledPL <- scaledPL #appends scaledPL as a column to myIris
myIris$scaledPW <- scaledPW #appends scaledPW as a column to myIris

View(myIris) #check that it worked

#14.Add together the four new scaled variables (use + and name each variable individually) 
   #and store the result in a new variable called myIris$scaledSum. 

scaledSum <- myIris$scaledSL + myIris$scaledSW + myIris$scaledPL + myIris$scaledPW #adds all the columns together to save in a new one
View(scaledSum) #checking that it worked
myIris$scaledSum <- scaledSum #append to data frame myIris
View(myIris) #checking the append worked

#15.Reorder the myIris data frame based on the values stored in myIris$scaledSum. 
   #Run View() on the result to check your work. 

sorted.scaled.sum <- myIris[order(myIris$scaledSum),] #save data frame as ordered by scaledSum
View(sorted.scaled.sum) #view the newly sorted data frame