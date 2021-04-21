name <- c("beth", 'raj', 'ken', 'jordyn')
age <- c(46,51,13,2)

testframe <- data.frame(name,age)

View(testframe)

mean(testframe$age)

age<-age+2

min.age <- min(testframe$age)

min(age)
min.age

max.age <- max(testframe$age)
max.age

youngDF <- testframe[testframe$age < 20,]
View(youngDF)

testframe[2,2]
testframe$name[2]

data()

?mtcars

my.cars <- mtcars

View(my.cars)

summary(my.cars)
str(my.cars)

mean(my.cars$mpg)
maxmpg <- max(my.cars$mpg)

cars.sorted.mpg <- my.cars[order(-my.cars$mpg),]
cars.sorted.mpg

my.cars[which.max(my.cars$mpg),]

if (maxmpg>34) "Yes!!!" else "No ... :("
