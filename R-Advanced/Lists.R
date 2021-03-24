#Lists in R

getwd()
setwd("/home/hefe/R/R-Advanced")
getwd()

util <- read.csv("Machine-Utilization.csv")
head(util)
tail(util)
summary(util)
str(util)

#Derive utilization column
util$Utilization = 1 - util$Percent.Idle
head(util,12)

#Handling Date-Times in R
tail(util)
#Universal date for R
?POSIXct
util$PosixTime <- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
head(util,12)
summary(util)
#TIP: How to rearrange column in a df:
#First tip: remove old timestamp;
util$Timestamp <- NULL
head(util,12)
#Second tip: rearrange column position
util <- util[,c(4,1,2,3)]
head(util,12)

#What is a list?

summary(util)
RL1 <- util[util$Machine=="RL1",]
RL1
summary(RL1)
str(RL1)
RL1$Machine <- factor(RL1$Machine)
summary(RL1)

#Construct list:

#Vector (min,mean,max) excluding unknown hours (NA)
util_stats_rl1 <- c(min(RL1$Utilization, na.rm = T),
                    mean(RL1$Utilization, na.rm = T),
                    max(RL1$Utilization, na.rm = T))
util_stats_rl1
#Logical: below 90%, T/F?
#If <0.90 then where in data:
which(RL1$Utilization < 0.90)
#How many times <0.90?;
length(which(RL1$Utilization < 0.90)) 
#OR True or False answer
length(which(RL1$Utilization < 0.90)) > 0
#Or with as.logical()
as.logical(length(which(RL1$Utilization < 0.90)))

util_under_90_flag <- length(which(RL1$Utilization < 0.90)) > 0
util_under_90_flag

list_rl1 <- list("RL1", util_stats_rl1, util_under_90_flag)
list_rl1

#Making components of a list
list_rl1
names(list_rl1)
names(list_rl1) <- c("Machine", "Stats, min, mean, max", "90%Threshold")
list_rl1
#Another way. Like with dataframes:
rm(list_rl1)
list_rl1 <- list(Machine="RL1", "Stats, min, mean, max"=util_stats_rl1, LowThreshold=util_under_90_flag)
list_rl1

#Extracting components of a list
#Three ways
#[] - will always return a list
#[[]] - will always return the actual object
#$ - sames as [[]] but prettier
list_rl1
list_rl1[1]
list_rl1[[1]]
list_rl1$Machine

list_rl1[2]
typeof(list_rl1[2])
list_rl1[[2]]
typeof(list_rl1[[2]])

list_rl1[[3]]
typeof(list_rl1[[3]])
list_rl1$LowThreshold

#How to get to max of stats
list_rl1$Stats[3]
list_rl1[[2]][3]
# Or min of stats
list_rl1$`Stats, min, mean, max`[1]
#Adding and deleting list components
list_rl1
list_rl1[13] <- "new information"
list_rl1

#another way to add via the $ sign
#We will add:
#Vector: All hours where utilization is unknown (NA)
RL1[is.na(RL1$Utilization),"PosixTime"]
#Add via the $ sign
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
list_rl1

#Now remove component: using the NULL method
list_rl1[4] = NULL
list_rl1
list_rl1[c(5,6,7,8,9,10,11,12)] = NULL
#numeration has shifted!
list_rl1
#Add another component:
list_rl1$Data <- RL1
list_rl1
summary(list_rl1)
str(list_rl1)


#Subsetting a list
list_rl1
#Quick Challenge
list_rl1$UnknownHours[1]
list_rl1[[4]][1]

#Let's proceed...
list_rl1
list_rl1[1]
list_rl1[1:2]
list_rl1[1:3]
list_rl1[c(1,4)]

sublist_rl1 <-list_rl1[c("UnknownHours", "Stats, min, mean, max")]
sublist_rl1
sublist_rl1[[2]][2]

#Double Square Brackets [[]] are NOT for Subsetting:
list_rl1[[1:3]] #Error
#See doesn't work
#You can only access 1 thing;
# A single component using [[]]



#Building a TimeSeries Plot
library(ggplot2)

p <- ggplot(data=util)
p + geom_line(aes(x=PosixTime, y=Utilization, colour=Machine),size=1.2) +
  facet_grid(Machine~.) +
    geom_hline(yintercept = 0.90,
               colour="Black", size=1.2,
               linetype=3)
?linetype

myplot <- p + geom_line(aes(x=PosixTime, y=Utilization, colour=Machine),size=1.2) +
  facet_grid(Machine~.) +
  geom_hline(yintercept = 0.90,
             colour="Black", size=1.2,
             linetype=3)

#Add picture/plot in list
list_rl1$Plot <- myplot
head(list_rl1)
summary(list_rl1)
str(list_rl1)
  























