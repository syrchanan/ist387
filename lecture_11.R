#install.packages(c('kernlab','caret'))
#install.packages('e1071')
library(e1071)
library(kernlab)
library(caret)
library(tidyverse)

url="https://ist387.s3.us-east-2.amazonaws.com/data/GermanCredit.csv"
credit <- read_csv(url)

View(credit)

cred <- data.frame(duration=credit$duration, 
                   amount=credit$amount, 
                   installment_rate=credit$installment_rate, 
                   present_residence=credit$present_residence, 
                   age=credit$age, 
                   credit_history=credit$number_credits, 
                   people_liable=credit$people_liable, 
                   credit_risk=as.factor(credit$credit_risk))

View(cred)

trainList <- createDataPartition(y=cred$credit_risk, p=.70, list=FALSE)
trainSet <- cred[trainList,]
testSet <- cred[-trainList,]

dim(trainSet)
dim(testSet)

svmout <- ksvm(credit_risk ~ ., data=trainSet, kernel= "rbfdot", kpar = "automatic", 
     C = 5, cross = 3, prob.model = TRUE)

svmPred <- predict(svmout, # use the built model "svmOutput" to predict 
                   testSet, # use testData to generate predictions
                   type = "response" # request "votes" from the prediction process
)

View(svmPred)

table(svmPred,testSet$credit_risk)

confusionMatrix(testSet$credit_risk, svmPred)
