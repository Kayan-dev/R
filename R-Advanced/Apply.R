


getwd()
setwd("/home/hefe/R/R-Advanced/Weather Data")
getwd()
file.choose()
Chicago <- read.csv("Chicago-F.csv", row.names = 1)
NewYork <- read.csv("NewYork-F.csv", row.names = 1)
Houston <- read.csv("Houston-F.csv", row.names = 1)
SanFrancisco <- read.csv("SanFrancisco-F.csv", row.names = 1)
#Check
is.data.frame(Chicago)
is.data.frame(NewYork)
is.data.frame(Houston)
is.data.frame(SanFransisco)
#Convert to Matrices
Chicago
Chicago <- as.matrix(Chicago)
is.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFransisco <- as.matrix(SanFransisco)
#Check
is.matrix(Chicago)
#Put into a list
Weather <- list(Chicago=Chicago, NewYork=NewYork, Houston=Houston, SanFransisco=SanFransisco)
Weather

Weather[3]
Weather[[3]]
Weather$Houston
Weather$Chicago

#Using apply()
?apply
Chicago
AverageChicago <- apply(Chicago, 1, mean)
AverageChicago
#Check
mean(Chicago["DaysWithPrecip",])
#analyze one city:
Chicago
apply(Chicago, 1, max)
apply(Chicago, 1, min)
#For practise:
apply(Chicago, 2, max) #Doesn't make sense for this dataset 
apply(Chicago, 2, min) #but nice to see for practise
#Compare
apply(Chicago, 1, mean)
apply(NewYork, 1, mean)
apply(Houston, 1, mean)
apply(SanFransisco, 1, mean)
                      # << (nearly) deliverably:but there is a faster way

#Recreating the apply function with loops
Chicago
#Find the mean for every row
#1. via loops
output <- NULL #preparing empty vector
for (i in 1:5) {
  output[i] <- mean(Chicago[i,])
}
output
names(output) <- rownames(Chicago)
output
#2. via apply() function
apply(Chicago, 1, mean)
apply(Chicago, 2, mean)
#Apply() is faster and shorter


#Using lapply()
?lapply
Chicago
#Transpose the matrix
t(Chicago)
Weather
newlist <- lapply(Weather, t) # list(t(Weather$Chicago), t(Weather$NewYork), etc)
newlist
#Example two: add new row
Chicago
rbind(Chicago, NewRow=1:12)
#Use lapply() to make this less labor intensive
lapply(Weather, rbind, NewYork=1:12)
#Example 3
?rowMeans
rowMeans(Chicago) #Identical to: apply(Chicago,1,mean)
#How to do this for all cities?
lapply(Weather, rowMeans)
# << (nearly) deliverably: even better but will improve further

#rowMeans

#colMeans
lapply(Weather, colMeans)
#rowSums
lapply(Weather, rowSums)
#colSums
lapply(Weather, colSums)
?colMeans
#Combining lapply() with the [ ] operator
Weather
Weather$Chicago[1,1]
#Weather$Houston[1,1]
#Weather$NewYork[1,1]
#Weather$SanFransisco[1,1]
#Identical to:
Weather[[3]][3,2]
#Weather[[2]][1,1]
#Weather[[3]][1,1]
#Weather[[4]][1,1]
lapply(Weather, "[", 3,2)
# The "[" means the [3,2] not the [[3]]
lapply(Weather, "[", 1, )
#Only for month March
lapply(Weather, "[", ,3)
# The warning triangle is normal, R thinks I forgot a row argument, but I didn't


#Adding your own functions
#Into apply family functions
lapply(Weather, rowMeans)
#First row
lapply(Weather, function(x) x[1,])
#Fifth row
lapply(Weather, function(x) x[5,])
#December
lapply(Weather, function(x) x[,12])
#A bit more complex example
Weather
lapply(Weather, function(z) z[1,] - z[2,])
lapply(Weather, function(z) (z[1,] - z[2,]) / z[2,])
#Round the numbers by 2 decimals
lapply(Weather, function(z) round((z[1,] - z[2,]) / z[2,],2))
        #<< Deliverable: temp fluctuactions. will improve

#Using sapply()
?sapply
Weather
#AvgHigh_F for July:
lapply(Weather, "[", 1, 7)
sapply(Weather, "[", 1, 7)
#AvgHigh_F for 4th quarter
lapply(Weather, "[", 1, 7:12)
sapply(Weather, "[", 1, 7:12)
  #Another example:
lapply(Weather, rowMeans)
sapply(Weather, rowMeans)
round(sapply(Weather, rowMeans),2) #<< Deliverable: This is it
⎄#Another example:
lapply(Weather, function(z) round((z[1,] - z[2,]) / z[2,],2))
sapply(Weather, function(z) round((z[1,] - z[2,]) / z[2,],2))
round(sapply(Weather, function(z) (z[1,] - z[2,]) / z[2,]), 2)
#<< so much better with sapply!!!!
#By the way
sapply(Weather, rowMeans, simplify = FALSE) #same as lapply
sapply(Weather, rowMeans)

#Nesting apply() functions

Weather
lapply(Weather, rowMeans)
?rowMeans
#Why no rowMax or rowMin?
Chicago
#How to get max from every row?
apply(Chicago, 1, max)
#now I want to apply it to every matrix in Weather list
lapply(Weather, apply, 1, max)
sapply(Weather, apply, 1, max) #Deliv 3
#Same idea but use own function
lapply(Weather, function(x) apply(x, 1, max))
sapply(Weather, function(x) apply(x, 1, max))

#Same can be done for minimum
lapply(Weather, apply, 1, min)
sapply(Weather, apply, 1, min) #deliv 4

#Advanced tutorial
#Which.max
?which.max
#which.max(sapply(Weather, apply, 1, max))
which.max(Chicago[1,])
names(which.max(Chicago[1,]))
#Put this in apply for every row in Chicago
apply(Chicago, 1, function(x) names(which.max(x)))
#This is the shit
#Put the apply(..) into lapply for whole of Weather list
lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))
# This doesn't work; lapply(Weather, function(x) names(which.max(x)))
#Make it more pretty with sapply();
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))










































