
###################################################
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    July 2019
###################################################

## load required packages
library(dtw)
library(wavelets)
library(party)


## an example of time series data
a <- ts(1:20, frequency=12, start=c(2011,3))
print(a)
str(a)
attributes(a)


## load time series data
plot(AirPassengers)
## time series decomposation
apts <- ts(AirPassengers, frequency = 12)
f <- decompose(apts)
plot(f$figure, type="b") # seasonal figures
plot(f)


## build an ARIMA model
fit <- arima(AirPassengers, order=c(1,0,0), 
       list(order=c(2,1,0), period=12))
## make forecast
fore <- predict(fit, n.ahead=24)
## error bounds at 95% confidence level
upper.bound <- fore$pred + 2*fore$se
lower.bound <- fore$pred - 2*fore$se
## plot forecast results
ts.plot(AirPassengers, fore$pred, upper.bound, lower.bound, 
        col = c(1, 2, 4, 4), lty = c(1, 1, 2, 2))
legend("topleft", col = c(1, 2, 4), lty = c(1, 1, 2),
       c("Actual", "Forecast", "Error Bounds (95% Confidence)"))


## Dynamic Time Warping (DTW)
library(dtw)
idx <- seq(0, 2*pi, len=100)
a <- sin(idx) + runif(100)/10
b <- cos(idx)
align <- dtw(a, b, step=asymmetricP1, keep=T)
dtwPlotTwoWay(align)


# read data into R
# sep="": the separator is white space, i.e., one
# or more spaces, tabs, newlines or carriage returns
sc <- read.table("../data/synthetic_control.data", header=F, sep="")
# show one sample from each class
idx <- c(1, 101, 201, 301, 401, 501)
sample1 <- t(sc[idx,])
plot.ts(sample1, main="")
plot.ts(sample1, main="")


# sample n cases from every class
n <- 10
s <- sample(1:100, n)
idx <- c(s, 100+s, 200+s, 300+s, 400+s, 500+s)
sample2 <- sc[idx,]
observedLabels <- rep(1:6, each=n)


## hierarchical clustering with Euclidean distance              
hc <- hclust(dist(sample2), method="ave")
plot(hc, labels=observedLabels, main="")
plot(hc, labels=observedLabels, main="")
# cut tree to get 8 clusters
memb <- cutree(hc, k=8)
table(observedLabels, memb)


# hierarchical clustering with DTW distance   
myDist <- dist(sample2, method="DTW")
hc <- hclust(myDist, method="average")
plot(hc, labels=observedLabels, main="")
# cut tree to get 8 clusters
memb <- cutree(hc, k=8)
table(observedLabels, memb)
plot(hc, labels=observedLabels, main="")



## build a decision tree
classId <- rep(as.character(1:6), each = 100)
newSc <- data.frame(cbind(classId, sc))   
library(party)
ct <- ctree(classId ~ ., data = newSc, 
            controls = ctree_control(minsplit = 20, 
                       minbucket = 5, maxdepth = 5))          
pClassId <- predict(ct)
table(classId, pClassId)
# accuracy
(sum(classId==pClassId)) / nrow(sc)


# extract DWT (with Haar filter) coefficients
library(wavelets)
wtData <- NULL
for (i in 1:nrow(sc)) {
  a <- t(sc[i,])
  wt <- dwt(a, filter="haar", boundary="periodic")
  wtData <- rbind(wtData, 
      unlist(c(wt@W, wt@V[[wt@level]])))
}
wtData <- as.data.frame(wtData)
wtSc <- data.frame(cbind(classId, wtData))
## build a decision tree
ct <- ctree(classId ~ ., data = wtSc, 
            controls = ctree_control(minsplit=20, minbucket=5, 
                                     maxdepth=5))
pClassId <- predict(ct)                 
table(classId, pClassId)
(sum(classId==pClassId)) / nrow(wtSc)
plot(ct, ip_args=list(pval=F), ep_args=list(digits=0))


## k-NN classification
k <- 20
newTS <- sc[501,] + runif(100)*15
distances <- dist(newTS, sc, method="DTW")
s <- sort(as.vector(distances), index.return=TRUE)
# class IDs of k nearest neighbours
table(classId[s$ix[1:k]])
