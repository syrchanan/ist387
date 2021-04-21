library(tidyverse)
library(MASS)

ggplot(data=Boston) + aes(x=rm, y=medv) + geom_point() +
  geom_smooth(method="lm", se=FALSE)

#1. The graphic you just created fits a best line to a cloud of points. Copy and modify the code to produce a plot where “crim” is the x variable instead of “rm.”

ggplot(data=Boston) + 
  aes(x=crim, y=medv) + 
  geom_point() +
  geom_smooth(method="lm", se=FALSE)

#2. Produce a histogram and descriptive statistics for Boston$crim. Write a comment describing any anomalies or oddities.

ggplot(Boston)+
  geom_histogram(aes(x=crim))

summary(Boston$crim)

#Though the mean is 3.6, there are values which range up to 88.97, so there are definite outliers

#3. Produce a linear model, using the lm( ) function where crim predicts medv. Remember that in R’s formula language, the outcome variable comes first and is separated from the predictors by a tilde, like this: medv ~ crim Try to get in the habit of storing the output object that is produced by lm and other analysis procedures. For example, I often use lmOut <- lm( . . .

lmout <- lm(medv~crim,Boston)
summary(lmout)

#4. Run a multiple regression where you use rm, crim, and dis (distance to Boston employment centers). Use all three predictors in one model with this formula: medv ~ crim + rm + dis

lmoutmult <- lm(medv~crim+rm+dis,Boston)

#5. Interpret the results of your analysis in a comment. Make sure to mention the pvalue, the adjusted R-squared, the list of significant predictors and the coefficient for each significant predictor.
                                                                 
summary(lmoutmult)
#the adjusted R squared is about 53%, so that means these 3 factors account for about half of the components which impact the result
#the significant predictors are crim and rm, dis does not seem to have as large of an impact on medv as the others
#the coefficient of crim is -0.25405 and the coefficient of rm is 8.34257
#the statistical significance of crim and rm are very low, indicating that they are significant, yet the statistical significance of dis is relatively high, so it is not nearly as significant in the determination of medv

#6. Create a one-row data frame that contains some plausible values for the predictors. For example, this data frame contains the median values for each predictor: predDF <- data.frame(crim = 0.26, dis=3.2, rm=6.2)

predDF <- data.frame(crim=.2,dis=3,rm=5.8)
                                                                 
#7. Use the predict( ) command to predict a new value of medv from the onerow data frame. If you stored the output of your lm model in lmOut, the command would look like this: predict(lmOut, predDF)

predict(lmoutmult,predDF)


?Boston
