familyages <- c(43,43,12,8,5)

mean(familyages)
median(familyages)
std(familyages)

user.stats <- function(numeric_vector) {
  a <- c(mean(numeric_vector), median(numeric_vector), sd(numeric_vector), min(numeric_vector))
  return(a)
}

user.stats(familyages)

user.stats(1:100)

hist(familyages)

hist(mtcars$mpg)

user.stats(mtcars$mpg)

dim(mtcars)

hist(rnorm(32,20.09,6.02))
