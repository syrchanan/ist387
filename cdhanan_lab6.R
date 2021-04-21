#Here is some starter code:

  library(tidyverse)
  myPlot <- ggplot(economics, aes(x=date))
  myPlot <- myPlot + geom_line(aes(y=psavert))

#1. Run those lines of code. What happens? How do you actually “invoke” the plot (i.e., how do you get it to draw in the plot window)?

myPlot
  
#You have to actually call the variable to plot it now. I prefer to not save each step of the ggplot in order to be able to run it in line. But, the code above incrementally adds data to the graph - calls data, sets the x-axis, then adds a line with the y axis set (inherits the data and x axis).  
  
#2. Run help("economics") to find out the meaning of the psavert variable.

?economics

#psavert is the personal savings rate
  
#3. Examine the plot to estimate when the personal savings rate reached itsmaximum value. Also examine the plot to estimate when the personal savingsrate reached its minimum value.

#likely reached its maximum around 1976 or so, and the mimum around late 2006.
  
#4. Use which.max( ) and which.min( ) to verify your guesses from problem 3.

myeconomics <- economics #save the data
myeconomics$date[which.max(myeconomics$psavert)] #May 1, 1975 - date is floored by month
myeconomics$date[which.min(myeconomics$psavert)] #July 1, 2005 - date is floored by month
  
#5. Change the color of the plot line to green. Hint: Changing a line to a constantcolor happens in the specification of the geometry.

myeconomics %>% 
  ggplot() + #initialize plot
  geom_line(aes(date, psavert), color = 'green') #add line with aesthetics
  
#6. Add a title to the plot with the ggtitle("Put title here") sub-command. The title"Personal Savings Rate: 1967-2014" would be a good choice.

myeconomics %>% #load data
  ggplot() + #initialize plot
  geom_line(aes(date, psavert), color = 'green')+ #add line with aesthetics
  ggtitle("Personal Savings Rate: 1967-2014") #title
  
#7. Add another data series to your plot to show the variable uempmed as a red line.

myeconomics %>% #load data
  ggplot() + #initialize plot
  geom_line(aes(date, psavert), color = 'green') + #add first line with aesthetics
  geom_line(aes(date, uempmed), color = 'red') + #add second line with aesthetics
  ggtitle("Personal Savings Rate: 1967-2014") #title
  
#8. Change the title of the plot to mention both variables.

?economics

myeconomics %>% #load data
  ggplot() + #initialize plot
  geom_line(aes(date, psavert), color = 'green') + #add first line with aesthetics
  geom_line(aes(date, uempmed), color = 'red') + #add second line with aesthetics
  ggtitle("Personal Savings Rate vs. Median Unemployment Time (Weeks): 1967-2014") + #title
  ylab('') #y lab none
  
#9. You can modify the axis labels in a ggplot with ylab( ) and xlab( ) subcommands. Change the axis labeling as needed to account for plotting both psavert and uempmed in the same window.

myeconomics %>% #load data
  ggplot() + #initialize plots
  geom_line(aes(date, psavert), color = 'green') + #add first line with aesthetics
  geom_line(aes(date, uempmed), color = 'red') + #add second line with aesthetics
  ggtitle("Personal Savings Rate vs. Median Unemployment Time (Weeks): 1967-2014") + #title
  xlab('Date') + #x label
  ylab('Rate, Weeks') #y label
  
#10. Create one last plot, creating a scatter plot, having the unemploy on the x-axis,psavert on the yaxis. Color each point based on the uempmed.

myeconomics %>% #load data
  ggplot() + #initialize the plot
  geom_point(aes(uempmed, psavert,color = uempmed)) + #give aesthetics
  ggtitle("Personal Savings Rate vs. Median Unemployment Time (Weeks)") + #give title
  scale_color_viridis_c() #add color scheme
  
#11. Interpret what you see in this last graph

#the longer that the median unemployment is, the psavert trends lower
#also, the average uempmed seems to be 8 or 9 weeks, the super long ones are rarities
  
#12. Make sure your code has nice comments! 