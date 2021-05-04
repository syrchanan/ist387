install.packages("quanteda")
install.packages("quanteda.textplots")
library(quanteda)
library(quanteda.textplots)
library(tidyverse)

df <- read_csv("https://ist387.s3.us-east-2.amazonaws.com/data/snowplownamesSmall.csv")

corp <- corpus(df$meaning)

dfm <- dfm(corp, remove_punct=TRUE, remove=stopwords("english"))

textplot_wordcloud(dfm, min_count = 1)

m <- as.matrix(dfm)
wordCounts <- colSums(m)
wordCounts <- sort(wordCounts, decreasing=TRUE)

posWords <- scan("https://ist387.s3.us-east-2.amazonaws.com/data/positive-words.txt", character(0), sep = "\n")
posWords <- posWords[-1:-34]
negWords <- scan("https://ist387.s3.us-east-2.amazonaws.com/data/negative-words.txt", character(0), sep = "\n")
negWords <- negWords[-1:-34]

matchedP <- match(names(wordCounts), posWords, nomatch = 0)
posWords[matchedP[matchedP != 0]]
sum(wordCounts[matchedP != 0])
wordCounts[matchedP != 0]

matchedN <- match(names(wordCounts), negWords, nomatch = 0)
negWords[matchedN[matchedN != 0]]
wordCounts[matchedN != 0]
sum(wordCounts[matchedN != 0])