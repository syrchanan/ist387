install.packages(c('arules', 'arulesViz'))
library(arules)
library(arulesViz)
library(tidyverse)
us <- map_data('state')

bank <- read.table("https://ist387.s3.us-east-2.amazonaws.com/data/bank-full.csv", sep=";", header = TRUE)

bank_new <- data.frame(job=bank$job,
                       marital=bank$marital,
                       housing_loan=bank$housing,
                       young=as.factor((bank$age<median(bank$age))),
                       contacted_more_than_once=as.factor((bank$campaign>1)),
                       contacted_before_this_campaign=as.factor((bank$previous<0)),
                       success=(bank$y))

table(bank_new$success)
prop.table(table(bank_new$success))

bankX <- as(bank_new,'transactions')

itemFrequency(bankX)
itemFrequencyPlot(bankX)

inspect(bankX[1:5])

rules <- apriori(bankX, parameter=list(support=0.006, confidence=0.32), appearance=list(rhs="success=yes"))

inspect(rules)

plot(rules,method="graph",shading="support")
