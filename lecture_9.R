install.packages('MASS')
library(tidyverse)
library(MASS)
library(imputeTS)


air <- airquality


air %>% 
  filter(is.na(Solar.R)) %>% 
  View()
air %>% 
  filter(is.na(Wind)) %>% 
  View()
air %>% 
  filter(is.na(Temp)) %>% 
  View()


air %>% 
  mutate(Solar.R = na_interpolation(Solar.R)) -> air
air %>% 
  filter(is.na(Solar.R)) %>% 
  View()


air %>% 
  ggplot()+
  geom_point(aes(Wind, Temp))+
  geom_abline(slope=-1.2305,intercept=90.1349)

lmout <- lm(Temp~Wind,air)
summary(lmout)

lmout_v2 <- lm(Temp~Wind+Solar.R,air)
summary(lmout_v2)


predict.df <- data.frame(Wind=9.7,Solar.R=205)
predict(lmout_v2,predict.df)


predict.df <- data.frame(Wind=10.7,Solar.R=205)
predict(lmout_v2,predict.df)
