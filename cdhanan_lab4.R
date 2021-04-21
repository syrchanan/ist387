# The problem is this: You receive a sample containing the ages of 30 students. You are wondering whether this sample is a group of undergraduates (mean age = 20 years) or graduates (mean age = 25 years). To answer this question, you must compare the mean of the sample you receive to a distribution of means from the population. The following fragment of R code begins the solution:


 set.seed(2) #set the seed for random number generation (keep it consistent)
 sampleSize <- 30 #sets the sample size to 30 and saves it to a variable
 studentPop <- rnorm(20000,mean=20,sd=3) #randomly generate a random normal distribution of 20,000 observations with mean of 20 and standard deviation of 3 
 undergrads <- sample(studentPop,size=sampleSize,replace=TRUE) #take a 30 observation sample of studentPop, replacing the values as they go
 grads <- rnorm(sampleSize,mean=25,sd=3) #randomly generate a random normal distribution of 30 observations with mean of 25 and standard deviation of 3
 if (runif(1)>0.5) { testSample <- grads } else { testSample <- undergrads } #randomly select one observation between 0 and 1, if it is higher than 0.5 then `grads` is saved as the testSample, if its less than 0.5 then `undergrads` is saved as the testSample
 mean(testSample) #calculate the average of the testSample

 
# After you run this code, the variable “testSample” will contain either a sample of undergrads or a sample of grads. The line before last “flips a coin” by generating one value from a uniform distribution (by default the distribution covers 0 to 1) and comparing it to 0.5. The question you must answer with additional code is: Which is it, grad or undergrad?
 
# Here are the steps that will help you finish the job:
 
 # 1. Annotate the code above with line-by-line commentary. In other words, you must explain what each of the six lines of code above actually do! You will have to lookup the meaning of some commands.

?set.seed
?rnorm
?sample
?runif
 
 # 2. Generate 10 samples from the “undergrads” dataset.
 
 sample(undergrads,size=10,replace=TRUE)
 
 # 3. Generate 10 new samples and take the mean of that sample

 mean(sample(undergrads,size=10,replace=TRUE))
 
 # 4. Repeat this process 3 times (i.e., generate a sample and take the mean 3 times, using the replicate function).

 ?replicate
 replicate(3,mean(sample(undergrads,size=10,replace=TRUE)))

 # Break

 # 5. Generate a list of sample means from the population called “undergrads”
 
 sample_undergrad <- replicate(100,mean(sample(undergrads,size=10,replace=TRUE)))
 sample_undergrad
 
# How many sample means should you generate? Really you can create any number that you want – hundreds, thousands, whatever – but I suggest for ease of inspection that you generate just 100 means. That is a pretty small number, but it makes it easy to think about percentiles and ranks.
 
# 6. Once you have your list of sample means generated from undergrads, the trick is to compare mean(testSample) to that list of sample means and see where it falls. Is it in the middle of the pack? Far out toward one end? Here is one hint that will help you: In chapter 7, the quantile() command is used to generate percentiles based on thresholds of 2.5% and 97.5%. Those are the thresholds we want, and the quantile() command will help you create them.
 
 ?quantile
 
 quantile(sample_undergrad,probs=c(0.025,0.975))
 if (mean(testSample)<quantile(sample_undergrad,probs=c(0.025,0.975))[1] | 
     mean(testSample)>quantile(sample_undergrad,probs=c(0.025,0.975))[2]) "Sample mean is extreme" else "Sample mean is not extreme"
 
# 7. Your code should have a print() statement that should say either, “Sample mean is extreme,” or, “Sample mean is not extreme.”\
 
      #see above
 
# 8. Add a comment stating if you think the testSample are undergrad students. Explain why or why not.
 
      #I think testSample are not undergrad students because the mean of the testSample is outside of the outer quantiles (2.5% and 97.5%) of the sample_undergrad mean. I combined the two tests into one test using an OR `|` operator and an if/else statement.
 
# 9. Repeat the same analysis to see if the testSample are grad students.
 
 sample_grad <- replicate(100,mean(sample(grads,size=10,replace=TRUE)))
 quantile(sample_grad,probs=c(0.025,0.975))
 if (mean(testSample)<quantile(sample_grad,probs=c(0.025,0.975))[1] | 
     mean(testSample)>quantile(sample_grad,probs=c(0.025,0.975))[2]) "Sample mean is extreme" else "Sample mean is not extreme"
 
      #I think testSample are grad students because the mean of the testSample is inside of the outer quantiles (2.5% and 97.5%) of        the sample_grad mean. I combined the two tests into one test using an OR `|` operator and an if/else statement.
 
 