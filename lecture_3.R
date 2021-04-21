##########
# Review #
##########

names <- c('Alex','Shu','Tanya')
ages <-  c(28,17,35)
users <- c('alp@syr.edu','sh67@syr.edu','tans@syr.edu')

students <- tibble(names, ages, users)
View(students)

summary(students)
str(students)

#display Tanya's age
students$ages[3]

min(students$ages)

students[which.min(students$ages),]

students[order(students$ages),]

students.young <- students[students$ages<30,]
students.young

students.old <- students[students$ages>30,]
students.old

students[students$ages==35,]


#################
# Data Cleaning #
#################

students$usernames <- gsub('@syr.edu','',students$users)
view(students)

sentence <- "I am 29 years old, and weigh 130 pounds"
gsub("29", 'X', sentence)

#RegEx
gsub('\\d+','X',sentence)
gsub('\\d','X',sentence)
gsub('\\w+','X',sentence)
gsub('\\w','X',sentence)
gsub('\\s+','',sentence)
gsub('\\s','',sentence)

students$gpa <- c('gpa_4.3','gpa_3.6','gpa_2.9')
students$gpa <- as.numeric(gsub('gpa_','',students$gpa))
mean(students$gpa)


#############
# Functions #
#############

v <- c(1,2,3)

myfunction <- function(vector) {
  mymean <- sum(vector)/length(vector)
  return(mymean)
}

myfunction(v)


library(tidyverse)
#all downloaded and set to go

url <- "https://ist387.s3.us-east-2.amazonaws.com/data/Companies.csv"
dfComps <- read_csv(url)

?is.na
