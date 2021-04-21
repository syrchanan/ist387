library(tidyverse)
data <- read_csv("https://ist387.s3.us-east-2.amazonaws.com/data/testData.csv")

head(data)

#1

str(data)
summary(data$followers_count) #Mean is 727, median is 212, min is 3 max is 7241
summary(data$followed_count) #mean is 728.7, median is 413, min is 0, max is 3898

#2

ggplot(data)+ #right-skewed
  geom_histogram(aes(followers_count), bins=10)

ggplot(data)+ #right-skewed
  geom_histogram(aes(followed_count), bins=10)

#3

mean(data$followers_count) #727.0336
mean(data$followed_count)  #728.7311 - On average they follow more people than follow them

#4

data %>% 
  mutate(follow_diff = (followers_count-followed_count)) %>% 
ggplot()+
  geom_histogram(aes(follow_diff)) #the large majority of people follow more people than follow them, but the difference between the two is not typically all that large

#5

ggplot(data)+
  geom_point(aes(followers_count,followed_count))+
  xlab('Number of Twitter Followers')+
  ylab('Number of Twitter Users Followed')+
  geom_smooth(aes(x=followers_count,y=followed_count),se=F,method="lm")+
  geom_abline(intercept = lmout$coefficients[1], slope = lmout$coefficients[2])

lmout <- lm(followed_count ~ followers_count,data) #positive relationship between number follows and followed

#6

lm01 <- lm(followers_count~tweets_count+followed_count,data)
lm02 <- lm(followed_count~tweets_count+followers_count,data)

summary(lm01)
summary(lm02)

#lm01 is better because the r-squared value is higher than that of lm02, suggesting that the model is more accurate (statistically significant)

#7

predict.df <- data.frame(followers_count=541,tweets_count=1128)
predict(lm02, predict.df) #656.4743 %~~% 656 followed users

#8

predict.df <- data.frame(followers_count=0,tweets_count=0)
predict(lm02, predict.df) #452.5852 %~~% 452 followed users

#9

library(maps)
us <- map_data('state')

data %>% 
  mutate(state = tolower(state)) %>% 
  group_by(state) %>%
  summarize(tweets_count_avg = mean(tweets_count)) %>%
  right_join(.,us, by=c('state' = 'region')) %>% 
ggplot()+
  geom_polygon(aes(long,lat,group=group,fill=tweets_count_avg),color='grey')+
  scale_fill_viridis_c()+
  coord_map(projection = 'albers', parameters = c(25,50))