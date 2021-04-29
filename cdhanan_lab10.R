library(tidyverse)
library(kernlab)
library(caret)

data("GermanCredit")
subcredit <- GermanCredit[,1:10]
str(subcredit)

# 1. Examine the data structure that str() reveals. Also use the help() command to
# learn more about the GermanCredit data set. Summarize what you see in a
# comment.

#the main indicator of each row is credit worthines (good or bad) - otherwise, there are many other attributes recorded, such as checking account status, duration, credit history, loan information, etc.

# 2. Use the createDataPartition() command to generate a list of cases to
# include in the training data. This command is conveniently provided by caret and
# allows one to directly control the number of training cases. It also ensures that
# the training cases are balanced with respect to the outcome variable. Try this:

trainlist <- createDataPartition(y=subcredit$Class,p=.40,list=FALSE)

# 3. Examine the contents of trainList to make sure that it is a list of case numbers.
# With p=0.40, it should have 400 case numbers in it.

str(trainlist) #400 observations in a list

# 4. What is trainList? What do the elements in trainList represent? Which attribute
# is balanced in the trainList dataset?

#trainlist is 40% of the subcredit dataframe - essentially, it is a list of 400 indices that can be referenced back in the subcredit dataframe to get the complete set

#   5. Use trainList and the square brackets notation to create a training data set called
# “trainSet” from the subCredit data frame. Look at the structure of trainSet to
# make sure it has all of the same variables as subCredit. The trainSet structure
# should be a data frame with 400 rows and 10 columns.

trainset <- subcredit[trainlist,]

# 6. Use trainList and the square brackets notation to create a testing data set called
# “testSet” from the subCredit data frame. The testSet structure should be a data
# frame with 600 rows and 10 columns and should be a completely different set of
# cases than trainSet.

testset <- subcredit[-trainlist,]

# 7. Create and interpret boxplots of the predictor variables in relation to the
# outcome variable (Class).

ggplot(subcredit)+geom_boxplot(aes(Duration,Class))+coord_flip()
ggplot(subcredit)+geom_boxplot(aes(Amount,Class))+coord_flip()
ggplot(subcredit)+geom_boxplot(aes(InstallmentRatePercentage,Class))+coord_flip()
ggplot(subcredit)+geom_boxplot(aes(ResidenceDuration,Class))+coord_flip()
ggplot(subcredit)+geom_boxplot(aes(Age,Class))+coord_flip()
ggplot(subcredit)+geom_boxplot(aes(NumberExistingCredits,Class))+coord_flip()
ggplot(subcredit)+geom_boxplot(aes(NumberPeopleMaintenance,Class))+coord_flip()
ggplot(subcredit)+geom_boxplot(aes(Telephone,Class))+coord_flip()
ggplot(subcredit)+geom_boxplot(aes(ForeignWorker,Class))+coord_flip()

# 8. Train a support vector machine with the ksvm() function from the kernlab
# package. Make sure that you have installed and libraried kernlab! Have the cost
# be 5, and have ksvm do 3 cross validations (hint: try prob.model = TRUE)

svmout <- ksvm(Class ~ ., data=trainset, kernel= "rbfdot", kpar = "automatic", 
               C = 5, cross = 3, prob.model = TRUE)

# 9. Examine the ksvm output object. In particular, look at the cross-validation error
# for an initial indication of model quality. Add a comment that gives your opinion
# on whether this is a good model.

View(svmout) #this is a decent model, as it has a cross-validation error of about 30% - as mentioned in class, this is not optimal, but it gets the job done for us

# 10. Predict the training cases using the predict command

svmpred <- predict(svmout,testset,type="response")

# 11. Examine the predicted out object with str( ). Then, calculate a confusion matrix
# using the table function.

str(svmpred)
table(testset$Class,svmpred)

# 12. Interpret the confusion matrix and in particular calculate the overall accuracy of
# the model. The diag( ) command can be applied to the results of the table
# command you ran in the previous step. You can also use sum( ) to get the total of
# all four cells.

sum(diag(table(testset$Class,svmpred)))/sum(table(testset$Class,svmpred))

# 13. Check you calculation with confusionMatrix() function in the caret package.

confusionMatrix(testset$Class,svmpred)