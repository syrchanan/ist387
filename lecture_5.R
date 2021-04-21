##########
# Review #
##########

library(tidyverse)

pets <- c(replicate(13,0), replicate(11,1),replicate(7,2),3,4,4,11)
ggplot(data.frame(pets)) + geom_histogram(aes(x=pets))

mean(pets)
sample(pets,28,TRUE) -> spets

spets %>% mean()

###################
# Data Processing #
###################

library(tidyverse)
library(jsonlite)
library(RCurl)
library(stringr)

dataset <- getURL("https://ist387.s3.us-east-2.amazonaws.com/data/role.json")
readlines <- jsonlite::fromJSON(dataset)
df <- readlines$objects$person
View(df)

nrow(df[df$firstname=='Charles',])

nrow(df[df$gender=='male',])

nrow(df[is.na(df$twitterid),])
nrow(df[!is.na(df$twitterid),])

nrow(df[!is.na(df$twitterid) & df$gender=='male',])

?fromJSON

