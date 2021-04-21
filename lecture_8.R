#install.packages(c('ggmap', 'maps', 'mapproj'))
library(tidyverse)
library(ggmap)
library(maps)
library(mapproj)
library(jsonlite)

pop <- fromJSON("https://ist387.s3.us-east-2.amazonaws.com/data/cities.json")
head(pop)

pop$population <- as.numeric(pop$population)
mean(pop$population)

pop$rank <- as.numeric(pop$rank)
pop$state[which.max(pop$rank)]

abbr <- read_csv("https://ist387.s3.us-east-2.amazonaws.com/data/states.csv")
head(abbr)

us <- map_data("state")
head(us)

pop %>% 
  left_join(.,abbr, by = c('state' = 'State')) %>% 
  mutate(state = tolower(state)) %>% 
  filter(Abbreviation != "AK") %>% 
  filter(Abbreviation != "HI") -> newpop

ggplot(newpop,aes(map_id=state))+
  geom_map(map=us, fill = 'white', color = 'black')+
  expand_limits(x=us$long,y=us$lat)+
  coord_map()+
  geom_point(aes(longitude, latitude, color=rank))+
  scale_color_viridis_c()

pop %>%
  left_join(.,abbr, by = c('state' = 'State')) %>% 
  mutate(state = tolower(state), abbreviation = Abbreviation) %>% 
  group_by(state) %>% 
  summarise(totalpop = sum(population)) -> statepopulation_lookup

ggplot(statepopulation_lookup,aes(map_id=state))+
  geom_map(map = us, aes(fill = totalpop))+
  expand_limits(x=us$long,y=us$lat)+
  coord_map()+
  scale_fill_viridis_c(direction = -1)
  
  
  
  