#1

library(tidyverse)

bookings <- read_csv("https://ist387.s3.us-east-2.amazonaws.com/data/Resort.csv")
str(bookings) #7 of the 20 columns (variables) are character columns, so there are no descriptive stats available
summary(bookings) #take `LeadTime` for instance: it has a min of 0, max of 737, median of 57, and mean of 92.68


#2

any(is.na(bookings)) #scan whole tibble for na
sum(is.na(bookings)) #count total na in tibble to be sure

table(is.na(bookings$IsCanceled)) #spot check
table(is.na(bookings$LeadTime)) #spot check
table(is.na(bookings$StaysInWeekendNights)) #spot check
table(is.na(bookings$StaysInWeekNights)) #spot check


#3

par(mfrow = c(1,3))
hist(bookings$LeadTime,main="Hist of Lead Time") #distribution is skewed to the right, in a decreasingly exponential pattern, indicating that the great majority of bookings were made with little time before arrival
hist(bookings$StaysInWeekendNights,main="Hist of Stays in Weekend Nights") #also exponentially decreasing, as well as skewed to the right, meaning that most guests stayed for one weekend only (either one or two days)
hist(bookings$StaysInWeekNights,main="Hist of Stays in Week Nights") #again, exponentially decreasing, since shorter stays are more popular with guests
dev.off()

table(bookings$Meal) #Bed and Breakfast is by far the most common, whereas no meal package is the least common
sort(table(bookings$Country),decreasing=TRUE) #Portugal is the most common country of origin, followed by Great Britain and Spain
table(bookings$MarketSegment) #Online Travel Agents is the most common way guests made their booking, while complementary bookings are the least common 


#4

bookings %>% 
  ggplot()+
  geom_boxplot(aes(IsCanceled,LeadTime,group=IsCanceled))
# the median lead time for cancelled bookings is higher than that of the uncancelled bookings; however, Uncancelled bookings have many more outliers to the high end of lead time (longer)

bookings %>% 
  ggplot()+
  geom_boxplot(aes(IsCanceled,StaysInWeekNights,group=IsCanceled))
# these boxplots are fairly comparable, with medians (and the quartiles) generally in the same range - THis means that there is hardly a correlation between cancelled bookings and number of week nights the guest stayed or booked for [if I had to differentiate, the median for cancelled bookings is slightly higher than uncancelled]

bookings %>% 
  ggplot()+
  geom_boxplot(aes(IsCanceled,PreviousCancellations,group=IsCanceled))
#there is not much data here, so the plots are somewhat underwhelming - that being said, cancelled bookings tend to have cancelled other bookings in the past, so it can be a useful indicator


#5

bookings %>% 
  select(Country, IsCanceled) %>% 
  group_by(Country) %>% 
  summarise(sumcancel = sum(IsCanceled)) -> cancel.count

cancel.count[which.max(cancel.count$sumcancel),]


#6

#install.packages("rworldmap")
library(rworldmap)
sPDF <- joinCountryData2Map(cancel.count, joinCode = "ISO3", nameJoinColumn = "Country")
map<-mapCountryData(sPDF, nameColumnToPlot='sumcancel', catMethod="logFixedWidth")
#generally, more developed (read: western world) countries have higher cancellation rates, with nations such as spain and portugal leading the group. However, Russia and the US are not far behind the number of cancellations of western europe 


#7

bookcat <- data.frame(meal=as.factor(bookings$Meal),             
                      marketSegment=as.factor(bookings$MarketSegment),       
                      isRepeatedGuest=as.factor(bookings$IsRepeatedGuest),       
                      assignedRoom=as.factor(bookings$AssignedRoomType), 
                      customerType=as.factor(bookings$CustomerType),
                      bookingChanges=as.factor(bookings$BookingChanges>0),
                      canceled=as.factor(bookings$IsCanceled))

library(arules)
library(arulesViz)

bookcat <- as(bookcat,'transactions')
itemFrequencyPlot(bookcat)
#the highest relative frequency condition is isRepeatedGuest=0, which means that if they are a new customer, they are more likely to cancel a booking than a returning customer. Other notable high scores are meal=BB, customerType=Transient, and bookingChanges=FALSE; however, some scores are very low frequency, such as meal=SC and assignedRoom=L

inspect(bookcat)


#8

rules <- apriori(bookcat,
                 parameter=list(supp=0.03,conf=0.9),
                 control=list(verbose=F),
                 appearance=list(default='lhs',rhs=("canceled=1")))

inspect(rules)

#1st rule: marketSegment=Groups, assignedRoom=A, customerType=Transient - support = 0.03, confidence = 0.93, lift = 3.35 - this means that when the market segment is a group, with room type A, and the customer booking is a stand-alone one (transient, not part of a group) then the booking is 93% likely to be cancelled. This specific combination only appears about 3% of the time; additionally, the lift value is greater than 1, meaning that this rule does have an impact on the outcome

#2nd rule: marketSegment=Groups, customerType=Transient, bookingChanges=FALSE - support = 0.035, confidence = 0.916, lift = 3.3 - this means that when the market segment is a group, the customer booking is a stand-alone one (transient, not part of a group), and there are no changes made to the booking pre-arrival, the booking is ~91% likely to be cancelled. This combination appears almost 4% of the time, and again, the lift is greater than 1, indicating this correlation does cause the outcome


#9

library(kernlab)
library(caret)
library(e1071)

book <- data.frame(leadTime=bookings$LeadTime, 
                   staysWeekend=bookings$StaysInWeekendNights, 
                   staysWeek=bookings$StaysInWeekNights, 
                   adults=bookings$Adults, 
                   children=bookings$Children, 
                   babies=bookings$Babies, 
                   prevCancellations=bookings$PreviousCancellations,
                   specialRequests=bookings$TotalOfSpecialRequests,
                   canceled=as.factor(bookings$IsCanceled))

trainlist <- createDataPartition(y=book$canceled, p=.70, list=FALSE)
trainset <- book[trainlist,]
testset <- book[-trainlist,]


#10

svmout <- ksvm(canceled ~ ., data=trainset, kernel= "rbfdot", kpar = "automatic", 
               C = 5, cross = 3, prob.model = TRUE)

svmout

svmpred <- predict(svmout,testset,type='response')

confusionMatrix(testset$canceled,svmpred)
