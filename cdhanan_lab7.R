library(ggplot2)
library(maps)
library(ggmap)
library(mapproj)
library(tidyverse)

us <- map_data("state") #load data into varible `us` with a focus on the state polygon points
us$state_name <- tolower(us$region) #make all state names lowercase
map <- ggplot(us, aes(map_id= state_name)) #initialize ggplot with data and map id
map <- map + aes(x=long, y=lat, group=group) + #add on x/y axes, and group by group
  geom_polygon(color = 'black', fill = 'white') #actually draw the shapes
map <- map + expand_limits(x=us$long, y=us$lat) #ensures that all of the points can be seen
map <- map + coord_map() + ggtitle("USA Map") #add title and earth projection
map #display

#1. Add a comment for each line of code, explaining what that line of code does.

#see above

#2. The map you just created fills in the area of each county in black while outlining it with a thin white line. Use the fill= and color= commands inside the call to geom_polygon( ) to reverse the color scheme. Now run the following code:
  
ny_counties <- map_data("county","new york")
ggplot(ny_counties) + aes(long,lat, group=group) + geom_polygon(color = 'black', fill = 'white')

#3. Just as in step 2, the map you just created fills in the area of each county in black while outlining it with a thin white line. Use the fill= and color= commands inside the call to geom_polygon( ) to reverse the color scheme.

#done see above

#4. Run head(ny_counties) to verify how the county outline data looks.

head(ny_counties)

#5. Make a copy of your code from step 3 and add the following subcommand to your ggplot( ) call (don’t forget to put a plus sign after the geom_polygon( ) statement to tell R that you are continuing to build the command): coord_map(projection = "mercator") In what way is the map different from the previous map. Be prepared to explain what a Mercator projection is.

ggplot(ny_counties) + 
  aes(long,lat, group=group) + 
  geom_polygon(color = 'black', fill = 'white') + 
  coord_map(projection = 'mercator')

#mercator projection is one which tries to map the curvature of the earth on a 2D plane using a cylindrical plane

#6. Grab a copy of the nyData.csv data set from: https://ist387.s3.us-east-2.amazonaws.com/lab/nyData.csv Read that data set into R with read_csv(). The next step assumes that you have named the resulting data frame “nyData.”

nyData <- read_csv('https://ist387.s3.us-east-2.amazonaws.com/lab/nyData.csv')

#7. Next, merge your ny_counties data from the first breakout group with your new nyData data frame, with this code:

  mergeNY <- merge(ny_counties,nyData,
                   all.x=TRUE,by.x="subregion",by.y="county")

#8. Run head(mergeNY) to verify how the merged data looks.
  
head(mergeNY)
  
#9. Now drive the fill color inside each county by adding the fill aesthetic inside of your geom_polygon( ) subcommand (fill based on the pop2000)

ggplot(mergeNY) + 
  aes(long,lat, group=group) + 
  geom_polygon(color = 'black', aes(fill = `pop2000`)) + 
  coord_map(projection = 'mercator') +
  scale_fill_viridis_c()

#10. Extra (not required):
#a. Read in the following JSON datasets:
library(jsonlite)
  
station_info <- jsonlite::fromJSON('https://gbfs.citibikenyc.com/gbfs/en/station_information.json')
station_info <- station_info$data$stations

station_status <- jsonlite::fromJSON('https://gbfs.citibikenyc.com/gbfs/en/station_status.json')
station_status <- station_status$data$stations

#b. Merge the datasets, based on ‘station_id’

station_info %>% 
  inner_join(.,station_status, by = c('station_id' = 'station_id')) -> merged_station

#c. Clean the merged dataset to only include useful information. For this work, you only need lat, lon and the number of bikes available

merged_station %>% 
  select('lat', 'lon', 'num_bikes_available') -> merged_useful

#d. Create a stamen map using ‘get_stamenmap()’. Have the limits of the map be defined by the lat and lot of the stations

qmplot(x = lon, y = lat, data = merged_useful, maptype = "watercolor", 
       geom = "point", color = num_bikes_available)+
  scale_color_viridis_c()

#e. Show the stations, as points on the map.

#see part `d`

#f. Show the number of bikes available as a color

#see part `d`