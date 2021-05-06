# 1. Read	in	the	following	data	set	with	readr::read_csv():
# https://ist387.s3.us-east-2.amazonaws.com/lab/ClimatePosts.csv
# Store	the	data	in	a	data	frame	called	tweetDF.	Use	str(tweetDF)	to	summarize	
# the	data.	Add	a	comment	describing	what	you	see.	Make	sure	to	explain	what	
# each	of	the	three	variables	contains.

library(tidyverse)
library(quanteda)
library(quanteda.textplots)

tweetdf <- read_csv("https://ist387.s3.us-east-2.amazonaws.com/lab/ClimatePosts.csv")

str(tweetdf) #18 observations of 3 variables
#ID is the twitter handle it seems
#skeptic is a boolean indicator of whether or not the person is a climate change skeptic
#tweet is the actual tweet text

# 2. Use	the	corpus	commands	to	turn	the	text	variable	into	a	quanteda	corpus.	You	
# can	use	the	IDs	as	the	document	titles	with	the	following	command:

tweetCorpus	<- corpus(tweetdf$Tweet,	docnames=tweetdf$ID)

# 3. Next,	convert	the	corpus	into	a	document-feature	matrix	(DFM).	Here’s	a	
# command	that	will	create	the	DFM:

tweetDFM	<- dfm(tweetCorpus,	remove_punct=TRUE,remove=stopwords("english"))

# 4. Type	tweetDFM	at	the	console	to	find	out	the	basic	characteristic of	the	DFM	(the number	of	terms,	the	number	of	documents,	and	the	sparsity	of	the	matrix).	
# Write	a	comment	describing	what	you	observe.

#18 documents, 223 terms, 93% sparse (this is the proportion of cells with a '0')
#this means that across the 18 documents and 223 terms, there is not a lot of overlap in usage of words

# 5. Create	a	wordcloud	from	the	DFM	using	the	following	command.	Write	a	
# comment	describing	notable	features	of	the	wordcloud:

textplot_wordcloud(tweetDFM,	min_count	=	1)
#the main features of the wordcloud includes a central focus on the words 'climate', 'global', 'change', and 'people'

# 6. Count	the	number	of	words	per	posting	and	plot	the	results	for	each	group	with	
# the	following	commands:

m	<- as.matrix(tweetDFM)
postCounts	<- rowSums(m)
tweetdf$postCounts	<- postCounts
boxplot(postCounts	~	Skeptic,	data=tweetdf)

# 7. Next,	we	will	read	in	dictionaries	of	positive	and	negative	words	to	see	what	we	
# can	match	up	to	the	text	in	our	DFM.	Here’s	a	line	of	code	for	reading	in	the	list	of	
# positive	words:
  
posWords	<- scan("https://ist387.s3.us-east-2.amazonaws.com/data/positive-words.txt",	character(0),	sep	=	"\n")
posWords <- posWords[-1:-34]
str(posWords)

# Create	a	similar	line	of	code	to	read	in	the	negative	words,	with	the	following	
# URL:	https://ist387.s3.us-east-2.amazonaws.com/data/negative-words.txt
# There	should	be	2006	positive	words	and	4783	negative	words.

negWords	<- scan("https://ist387.s3.us-east-2.amazonaws.com/data/negative-words.txt",	character(0),	sep	=	"\n")
negWords <- negWords[-1:-34]
str(negWords)

# 8. Flatten	the	matrix	from	step	6	into	a	word	list	with	a	count	of	each	word:

wordCounts	<- colSums(m)
wordCounts	<- sort(wordCounts,	decreasing=TRUE)

# 9. Examine	the	start	of	wordCounts	with	str()	and	head()	and	comment	on	what	
# you	see.	In	particular,	you	should	see	some	correspondence	between	this	list	and	
# the	wordcloud	you	generated	earlier.

str(wordCounts)
head(wordCounts) #the four or five words I mentioned earlier are featured at the top of the list (since it is sorted in a decr manner) - these have a higher frequency of use so they appear bigger in the wordcloud

# 10. Match	the	words	from	the	wordCounts	vector	with	the	positive	dictionary	like	
# this:

matchedP	<- match(names(wordCounts),	posWords,	nomatch	=	0)

# 11. Examine	the	contents	of	matchedP	to	see	what	it	contains.	What	are	the	nonzero	numbers	stored	in	this	list?	Count	how	many	non-zero	numbers	there	are.	
# Can	you	create	a	line	of	code	that	will	count	the	non-zero	numbers	for	you?

str(matchedP) #the non-zero numbers stored in this vector are indices which correlate to positions on the posWords vector
head(matchedP, 50) #each match is essentially another positive word used in the corpus

sum(wordCounts[matchedP != 0])
wordCounts[matchedP != 0]

#   12. Repeat	steps	10	and	11	for	the	negative	words.

matchedN	<- match(names(wordCounts),	negWords,	nomatch	=	0)

sum(wordCounts[matchedN != 0])
wordCounts[matchedN != 0]

#overall the corpus is more negative than positive, which is interesting, as the number of skeptics and non-skeptics are even
#table(tweetdf$Skeptic)