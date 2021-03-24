
###################################################
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    July 2019
###################################################

## load required packages
library(magrittr) ## for pipe operations
library(twitteR)
library(tm)
library(ggplot2)
library(graph)
library(Rgraphviz)
library(RColorBrewer)
library(wordcloud)
#library(fpc)
library(topicmodels)
library(data.table) # month(), asIDate()
library(sentiment)


## ## term weighting
## library(magrittr)
## library(tm) ## package for text mining
## a <- c("I like R", "I like Python")
## ## build corpus
## b <- a %>% VectorSource() %>% Corpus()
## ## build term document matrix
## m <- b %>% TermDocumentMatrix(control=list(wordLengths=c(1, Inf)))
## m %>% inspect()
## 
## ## various term weighting schemes
## m %>% weightBin() %>% inspect() ## binary weighting
## m %>% weightTf() %>% inspect() ## term frequency
## m %>% weightTfIdf(normalize=F) %>% inspect() ## TF-IDF
## m %>% weightTfIdf(normalize=T) %>% inspect() ## normalized TF-IDF
## 
## 
## ## Option 1: retrieve tweets from Twitter
## library(twitteR)
## library(ROAuth)
## ## Twitter authentication
## setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
## ## 3200 is the maximum to retrieve
## tweets <- "RDataMining" %>% userTimeline(n=3200)
## 
## 
## ## Option 2: download @RDataMining tweets from RDataMining.com
## library(twitteR)
## url <- "http://www.rdatamining.com/data/RDataMining-Tweets-20160212.rds"
## download.file(url, destfile="./data/RDataMining-Tweets-20160212.rds")
## ## load tweets into R
## tweets <- readRDS("./data/RDataMining-Tweets-20160212.rds")
## 
## 
library(twitteR)
## load tweets into R
tweets <- readRDS("../data/RDataMining-Tweets-20160212.rds")
(n.tweet <- tweets %>% length())
# convert tweets to a data frame
tweets.df <- tweets %>% twListToDF()
# tweet #1
tweets.df[1, c("id", "created", "screenName", "replyToSN",
  "favoriteCount", "retweetCount", "longitude", "latitude", "text")]
# print tweet #1 and make text fit for slide width
tweets.df$text[1] %>% strwrap(60) %>% writeLines()


## text cleaning
library(tm)
# function for removing URLs, i.e.,
#  "http" followed by any non-space letters
removeURL <- function(x) gsub("http[^[:space:]]*", "", x)
# function for removing anything other than English letters or space
removeNumPunct <- function(x) gsub("[^[:alpha:][:space:]]*", "", x)
# customize stop words
myStopwords <- c(setdiff(stopwords('english'), c("r", "big")),
                 "use", "see", "used", "via", "amp")


# build a corpus and specify the source to be character vectors
corpus.raw <- tweets.df$text %>% VectorSource() %>% Corpus()

# text cleaning
corpus.cleaned <- corpus.raw %>% 
  # convert to lower case
  tm_map(content_transformer(tolower)) %>% 
  # remove URLs
  tm_map(content_transformer(removeURL)) %>% 
  # remove numbers and punctuations
  tm_map(content_transformer(removeNumPunct)) %>% 
  # remove stopwords
  tm_map(removeWords, myStopwords) %>% 
  # remove extra whitespace
  tm_map(stripWhitespace) 


## stem words
corpus.stemmed <- corpus.cleaned %>% tm_map(stemDocument)

## stem completion
stemCompletion2 <- function(x, dictionary) {
  x <- unlist(strsplit(as.character(x), " "))
  x <- x[x != ""]
  x <- stemCompletion(x, dictionary=dictionary)
  x <- paste(x, sep="", collapse=" ")
  stripWhitespace(x)
}

corpus.completed <- corpus.stemmed %>% 
  lapply(stemCompletion2, dictionary=corpus.cleaned) %>% 
  VectorSource() %>% Corpus()


## compare text before/after cleaning
# original text
corpus.raw[[1]]$content %>% strwrap(60) %>% writeLines()
# after basic cleaning
corpus.cleaned[[1]]$content %>% strwrap(60) %>% writeLines()
# stemmed text
corpus.stemmed[[1]]$content %>% strwrap(60) %>% writeLines()
# after stem completion
corpus.completed[[1]]$content %>% strwrap(60) %>% writeLines()


# count word frequence
wordFreq <- function(corpus, word) {
  results <- lapply(corpus,
    function(x) grep(as.character(x), pattern=paste0("\\<",word)) )
  sum(unlist(results))
}
n.miner <- corpus.cleaned %>% wordFreq("miner")
n.mining <- corpus.cleaned %>% wordFreq("mining")
cat(n.miner, n.mining)


# replace old word with new word
replaceWord <- function(corpus, oldword, newword) {
  tm_map(corpus, content_transformer(gsub),
         pattern=oldword, replacement=newword)
}
corpus.completed <- corpus.completed %>% 
  replaceWord("miner", "mining") %>% 
  replaceWord("universidad", "university") %>% 
  replaceWord("scienc", "science")
## Build Term Document Matrix
tdm <- corpus.completed %>% 
  TermDocumentMatrix(control = list(wordLengths = c(1, Inf)))  %>% 
  print
idx <- which(dimnames(tdm)$Terms %in% c("r", "data", "mining"))
tdm[idx, 21:30] %>% as.matrix()


# inspect frequent words
freq.terms <- tdm %>% findFreqTerms(lowfreq=20) %>% print
term.freq <- tdm %>% as.matrix() %>% rowSums()
term.freq <- term.freq %>% subset(term.freq>=20)
df <- data.frame(term=names(term.freq), freq=term.freq)


## plot frequent words
library(ggplot2)
ggplot(df, aes(x=term, y=freq)) + geom_bar(stat="identity") +
  xlab("Terms") + ylab("Count") + coord_flip() +
  theme(axis.text=element_text(size=7))


## word cloud
m <- tdm %>% as.matrix
# calculate the frequency of words and sort it by frequency
word.freq <- m %>% rowSums() %>% sort(decreasing=T)

# colors
library(RColorBrewer)
pal <- brewer.pal(9, "BuGn")[-(1:4)]
## # plot word cloud
## library(wordcloud)
## wordcloud(words=names(word.freq), freq=word.freq, min.freq=3, random.order=F, colors=pal)
# which words are associated with "r"?
tdm %>% findAssocs('r', 0.2)
# which words are associated with "data"?
tdm %>% findAssocs('data', 0.2)


## network of terms
library(graph)
library(Rgraphviz)
plot(tdm, term=freq.terms, corThreshold=0.1, weighting=T)


## clustering of terms
# remove sparse terms
m2 <- tdm %>% removeSparseTerms(sparse=0.95) %>% as.matrix()

# calculate distance matrix
dist.matrix <- m2 %>% scale() %>% dist()

# hierarchical clustering
fit <- dist.matrix %>% hclust(method="ward")
# save m2 for social network analysis later
term.doc.matrix <- m2
term.doc.matrix %>% save(file="../data/termDocMatrix.rdata")
plot(fit)
fit %>% rect.hclust(k=6) # cut tree into 6 clusters
groups <- fit %>% cutree(k=6)


## k-means clustering of documents
m3 <- m2 %>% t() # transpose the matrix to cluster documents (tweets)
set.seed(122) # set a fixed random seed to make the result reproducible
k <- 6 # number of clusters
kmeansResult <- kmeans(m3, k)
round(kmeansResult$centers, digits=3) # cluster centers
for (i in 1:k) {
  cat(paste("cluster ", i, ":  ", sep=""))
  s <- sort(kmeansResult$centers[i,], decreasing=T)
  cat(names(s)[1:5], "\n")
  # print the tweets of every cluster
  # print(tweets[which(kmeansResult$cluster==i)])
}


## topic modelling with LDA
set.seed(523)
dtm <- tdm %>% as.DocumentTermMatrix()
library(topicmodels)
lda <- LDA(dtm, k=8) # find 8 topics
term <- terms(lda, 7) # first 7 terms of every topic
term <- apply(term, MARGIN=2, paste, collapse=", ") %>% print
rdm.topics <- topics(lda) # 1st topic identified for every document (tweet)
rdm.topics <- data.frame(date=as.IDate(tweets.df$created), 
                         topic=rdm.topics)
ggplot(rdm.topics, aes(date, fill = term[topic])) +
  geom_density(position = "stack")


## ## sentiment analysis
## # install package sentiment140
## require(devtools)
## install_github('sentiment140', 'okugami79')
## # sentiment analysis
## library(sentiment)
## sentiments <- sentiment(tweets.df$text)
## table(sentiments$polarity)
## # sentiment plot
## sentiments$score <- 0
## sentiments$score[sentiments$polarity == "positive"] <- 1
## sentiments$score[sentiments$polarity == "negative"] <- -1
## sentiments$date <- as.IDate(tweets.df$created)
## result <- aggregate(score ~ date, data=sentiments, sum)
## 
## 
## ## follower analysis
## user <- getUser("RDataMining")
## user$toDataFrame()
## friends <- user$getFriends() # who this user follows
## followers <- user$getFollowers() # this user's followers
## followers2 <- followers[[1]]$getFollowers() # a follower's followers
# load("../data/RDataMining-followers-20160212.rdata")
load("../data/retweets.rdata")
t(user$toDataFrame())


## ## retweet analysis
## ## select top retweeted tweets
## table(tweets.df$retweetCount)
## selected <- which(tweets.df$retweetCount >= 9)
## 
## ## plot them
## dates <- strptime(tweets.df$created, format="%Y-%m-%d")
## plot(x=dates, y=tweets.df$retweetCount, type="l", col="grey",
##      xlab="Date", ylab="Times retweeted")
## colors <- rainbow(10)[1:length(selected)]
## points(dates[selected], tweets.df$retweetCount[selected],
##        pch=19, col=colors)
## text(dates[selected], tweets.df$retweetCount[selected],
##      tweets.df$text[selected], col=colors, cex=.9)
## 
## 
## tweets[[1]]
## retweeters(tweets[[1]]$id)
## retweets(tweets[[1]]$id)
load("../data/retweets.rdata")
tweets[[1]]
cat("\n")
retweeters
cat("\n")
head(retweets, 3)
