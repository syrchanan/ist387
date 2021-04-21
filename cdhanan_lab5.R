#1. Explain what you see if you type in the station_link URL into a browser (in a comment, write what you see)

#I see the entire JSON file printed out. This includes all the hierarchical information, meaning the commas, etc. Key/value pairs are also seen in the JSON (as it should be, I mean that is the data.)

#2. Provide a comment explaining each line of code.

library(jsonlite)
library(RCurl)

station_link <- 'https://gbfs.citibikenyc.com/gbfs/en/station_status.json' #sets the link as a variable
apiOutput <- getURL(station_link) #calls the API and stores the response as a variable
apiData <- fromJSON(apiOutput) #strips the JSON formatting of the API response as a list of dataframes
stationStatus <- apiData$data$stations #subsets the list to select the dataframe we want
cols <- c('num_bikes_disabled','num_docks_disabled', 'station_id',
          'num_ebikes_available', 'num_bikes_available', 'num_docks_available') #create vector of column names we want to save
stationStatus = stationStatus[,cols] #create dataframe saving the columns that we set aside in the previous vector

#3. Use str( ) to find out the structure of apiOutput and apiData. Report (via a comment) what you found and explain the difference between these two objects.

str(apiOutput) #this is a single character string (no structure recognized - could be literally anything)

str(apiData) #this is a list of dataframes and other raw data (recgonized as having structure)

#4. The apiOutput object can also be examined with a custom function from the jsonlite package called prettify( ). Run this command and explain what you found (in a comment).

prettify(apiOutput) #prints the JSOn in JSON formatting, essentially restructures the string in JSON format

#5. Explain stationStatus (what type of object, what information is available)

str(stationStatus) #dataframe containing 1387 observations of the 6 columns that we selected in line 14 (the subsetting)

#6. Generate a histogram of the number of docks available

library(tidyverse)
ggplot(stationStatus) + geom_histogram(aes(num_docks_available))

#7. Generate a histogram of the number of bikes available

ggplot(stationStatus) +geom_histogram(aes(num_bikes_available))

#8. How many stations have at least one ebike?

stationStatus %>% filter(num_ebikes_available >= 1) %>% nrow() #604 Stations have at least 1 bike

#9. Explore stations with at least one ebike by create a new dataframe, that only has stations with at least one eBike.

ebike_stations <- stationStatus %>% filter(num_ebikes_available >= 1)

#10. Calculate the mean of ‘num_docks_available’ for this new dataframe.

mean(ebike_stations$num_docks_available)

#11. Calculate the mean of ‘num_docks_available’ for for the full ‘stationStatus’ dataframe. In a comment, explain how different are the two means?

mean(stationStatus$num_docks_available) #the means are slightly different because the set of all the stations include larger stations than ones that have ebikes

#12. Create a new attribute, called ‘stationSize’, which is the total number of “slots” available for a bike (that might, or might not, have a bike in it now). Run a histogram on this variable and review the distribution.

stationStatus <- stationStatus %>% 
  mutate(station_size = num_bikes_available+num_docks_available+num_docks_disabled+num_bikes_disabled)

ggplot(stationStatus) + geom_histogram(aes(station_size))

#13. Use the plot( ) command to produce an X-Y scatter plot with the number of occupied docks on the X-axis and the number of available bikes on the Y-axis. Explain the results plot.

ggplot(stationStatus) + 
  geom_point(aes(station_size-num_docks_available,num_bikes_available)) +
  geom_abline(slope=1)+
  xlab('number of occupied docks') +
  ylab('number of available bikes')
#the stations in perfect condition are plotted along the y=x line; however, any discrepencies come from either disabled docks or disabled bikes
