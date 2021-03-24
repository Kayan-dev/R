getwd()
setwd("/home/hefe/R/R-Beginner")

stats <- read.csv("P2-Demographic-Data.csv")
#----------- Basic Operations with a Data Frame (DF)
stats[1:10,] #subsetting
stats[3:9,2]
stats[c(4:100),]
#Remember how the [] brackets work:
stats[1,]
is.data.frame(stats[1,]) #no need for drop=F such as with Matrices
stats[,2]
is.data.frame(stats[,2])
stats[,2,drop=F]
is.data.frame(stats[,2,drop=F])

#Multiple columns
head(stats)
stats$Birth.rate
stats$Birth.rate * stats$Internet.users
stats$Birth.rate + stats$Internet.users

#add column
head(stats)
stats$MyCalc <-stats$Birth.rate * stats$Internet.users
stats$MyCalc
head(stats)

#Recycling of vectors
stats$xyz <- 1:5
head(stats, n=12)
# 1:4 does not work for n=195
stats$abc <- 1:4
head(stats, n=12)
#Remove a column
head(stats)
stats$yxz <- NULL
stats$MyCalc <- NULL
head(stats)
#-------------- Filtering Data Frames
head(stats)
stats$Internet.users < 2
# you can put 'stats$Internet.users < 2' into an object:
filter <- stats$Internet.users < 2
stats[filter,]

#Same method but more efficient
stats[stats$Birth.rate > 40,]
#Adding another condition
stats[stats$Birth.rate > 40 & stats$Internet.users <2,]

stats[stats$Income.Group == "High income",]
#Add another condition
stats[stats$Income.Group == "High income" &  stats$Internet.users < 80,]

#Vind Malta, zelf geprobeerd:
stats["Malta",]
stats[,"Malta",]
#Dit werkt niet, wat wel werkt is dit:
stats[stats$Country.Name == "Malta"]
#Vergeet "Malta", niet: de komma 'niets' is belangrijk
stats[stats$Country.Name == "Malta",]

