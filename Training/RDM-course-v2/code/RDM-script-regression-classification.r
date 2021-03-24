
###################################################
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    July 2019
###################################################

## load required packages
library(party)
library(rpart)
library(rpart.plot)
library(randomForest)
library(TH.data) ## bodyfat data



## ----------------------- The CPI Data and a linear regression model -----------------------
## CPI data
year <- rep(2008:2010, each = 4)
quarter <- rep(1:4, 3)
cpi <- c(162.2, 164.6, 166.5, 166.0, 
         166.2, 167.0, 168.6, 169.5, 
         171.0, 172.1, 173.3, 174.0)
plot(cpi, xaxt="n", ylab="CPI", xlab="")
# draw x-axis, where "las=3" makes text vertical
axis(1, labels=paste(year,quarter,sep="Q"), at=1:12, las=3)

## correlation between CPI and year / quarter
cor(year,cpi)
cor(quarter,cpi)

## build a linear regression model with function lm()
fit <- lm(cpi ~ year + quarter)
fit

# make prediction
cpi2011 <- fit$coefficients[[1]] + 
           fit$coefficients[[2]] * 2011 +
           fit$coefficients[[3]] * (1:4)
cpi2011

## attributes of the model
attributes(fit)
fit$coefficients

## differences between observed values and fitted values
residuals(fit)
summary(fit)

library(scatterplot3d)
s3d <- scatterplot3d(year, quarter, cpi, highlight.3d=T, type="h", 
          lab=c(2,3)) # lab: number of tickmarks on x-/y-axes
s3d$plane3d(fit) # draws the fitted plane

data2011 <- data.frame(year=2011, quarter=1:4)
cpi2011 <- predict(fit, newdata=data2011)
style <- c(rep(1,12), rep(2,4))
plot(c(cpi, cpi2011), xaxt="n", ylab="CPI", xlab="", 
     pch=style, col=style)
txt <- c(paste(year,quarter,sep="Q"), 
         "2011Q1", "2011Q2", "2011Q3", "2011Q4")
axis(1, at=1:16, las=3, labels=txt)



## ----------------------- Generalized Linear Regression -----------------------


## build a regression model
data("bodyfat", package="TH.data")
myFormula <- DEXfat ~ age + waistcirc + hipcirc + elbowbreadth + 
                      kneebreadth
bodyfat.glm <- glm(myFormula, family=gaussian("log"), data=bodyfat)
summary(bodyfat.glm)

## make prediction and visualise result
pred <- predict(bodyfat.glm, type="response")
plot(bodyfat$DEXfat, pred, xlab="Observed", ylab="Prediction")
abline(a=0, b=1)



## ----------------------- Decision Trees with Package party -----------------------
str(iris)
# split data into two subsets: training (70%) and test (30%); 
# set a fixed random seed  to make results reproducible
set.seed(1234) 
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
train.data <- iris[ind==1,]
test.data <- iris[ind==2,]

## build a ctree
library(party)
# myFormula <- Species ~ . # predict Species with all other variables
myFormula <- Species ~ Sepal.Length + Sepal.Width + 
             Petal.Length + Petal.Width
iris.ctree <- ctree(myFormula, data=train.data)
# check the prediction
table(predict(iris.ctree), train.data$Species)
print(iris.ctree)
plot(iris.ctree)
plot(iris.ctree, type="simple")

# predict on test data
testPred <- predict(iris.ctree, newdata = test.data)
table(testPred, test.data$Species)



## ----------------------- Decision Trees with Package rpart -----------------------
## build a decision tree with rpart
data("bodyfat", package = "TH.data")
dim(bodyfat)
# str(bodyfat)
head(bodyfat, 5)

# split into training and test subsets
set.seed(1234) 
ind <- sample(2, nrow(bodyfat), replace=TRUE, prob=c(0.7, 0.3))
bodyfat.train <- bodyfat[ind==1,]
bodyfat.test <- bodyfat[ind==2,]
# train a decision tree
library(rpart)
myFormula <- DEXfat ~ age + waistcirc + hipcirc + elbowbreadth + 
                      kneebreadth
bodyfat.rpart <- rpart(myFormula, data = bodyfat.train, 
                       control = rpart.control(minsplit = 10))
# print(bodyfat.rpart$cptable)
library(rpart.plot)
rpart.plot(bodyfat.rpart)
print(bodyfat.rpart)
rpart.plot(bodyfat.rpart)
# select the tree with the minimum prediction error
opt <- which.min(bodyfat.rpart$cptable[,"xerror"])
cp <- bodyfat.rpart$cptable[opt, "CP"]
# prune tree
bodyfat.prune <- prune(bodyfat.rpart, cp = cp)
# plot tree
rpart.plot(bodyfat.prune)
rpart.plot(bodyfat.prune)
## make prediction
DEXfat_pred <- predict(bodyfat.prune, newdata=bodyfat.test)
xlim <- range(bodyfat$DEXfat)
plot(DEXfat_pred ~ DEXfat, data=bodyfat.test, xlab="Observed", 
     ylab="Prediction", ylim=xlim, xlim=xlim)
abline(a=0, b=1)



## ----------------------- build a Random Forest -----------------------
# split into two subsets: training (70%) and test (30%)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
train.data <- iris[ind==1,]
test.data <- iris[ind==2,]
# use all other variables to predict Species
library(randomForest)
rf <- randomForest(Species ~ ., data=train.data, ntree=100, 
                   proximity=T)

table(predict(rf), train.data$Species)
print(rf)
attributes(rf)
plot(rf, main="")

importance(rf)
varImpPlot(rf)

irisPred <- predict(rf, newdata=test.data)
table(irisPred, test.data$Species)
plot(margin(rf, test.data$Species))
