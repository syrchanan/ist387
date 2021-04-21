#install.packages("imputeTS")
library(imputeTS)
library(tidyverse)

tb <- read_csv("https://ist387.s3.us-east-2.amazonaws.com/data/who.csv")
dim(tb)

tb %>% 
  filter(iso2 == 'NZ') %>% 
  filter(!is.na(new_sp_f2534)) %>%
  mutate(new_sp_f2534 = na_interpolation(new_sp_f2534)) %>% 
ggplot() +
  geom_histogram(bins = 10, aes(new_sp_f2534)) +
  ggtitle('TB cases over time in NZ', subtitle = 'Measured in cases')
