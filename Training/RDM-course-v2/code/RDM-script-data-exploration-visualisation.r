
###################################################
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    July 2019
###################################################

## load required packages
library(magrittr) ## for pipe operations
library(RODBC)
library(openxlsx)
library(foreign)
library(Hmisc)
library(scatterplot3d)
library(rgl)
library(MASS)
library(ggplot2)
library(dplyr)


## ----------------------- Have a Look at Data -----------------------
# number of rows
nrow(iris)
# number of columns
ncol(iris)
# dimensionality
dim(iris)
# column names
names(iris)
str(iris)
attributes(iris)
iris[1:3,]
head(iris, 3)
tail(iris, 3)
iris[1:10, "Sepal.Length"]
iris$Sepal.Length[1:10]


## ----------------------- Explore Individual Variables -----------------------
summary(iris)
library(Hmisc)
# describe(iris) # check all columns
describe(iris[, c(1,5)]) # check columns 1 and 5
range(iris$Sepal.Length)
quantile(iris$Sepal.Length)
quantile(iris$Sepal.Length, c(.1, .3, .65))
var(iris$Sepal.Length)
hist(iris$Sepal.Length)
library(magrittr) ## for pipe operations
iris$Sepal.Length %>% density() %>% plot(main='Density of Sepal.Length')
library(dplyr)
iris2 <- iris %>% sample_n(50)
iris2$Species %>% table() %>% pie()

# add percentages
tab <- iris2$Species %>% table()
precentages <- tab %>% prop.table() %>% round(3) * 100
txt <- paste0(names(tab), '\n', precentages, '%')
pie(tab, labels=txt)
iris2$Species %>% table() %>% barplot()

# add colors and percentages
bb <- iris2$Species %>% table() %>% 
      barplot(axisnames=F, main='Species', ylab='Frequency',
              col=c('pink', 'lightblue', 'lightgreen'))
text(bb, tab/2, labels=txt, cex=1.5)


## ----------------------- Explore Multiple Variables -----------------------
cov(iris$Sepal.Length, iris$Petal.Length)
cor(iris$Sepal.Length, iris$Petal.Length)
cov(iris[,1:4])
# cor(iris[,1:4])
aggregate(Sepal.Length ~ Species, summary, data=iris)
boxplot(Sepal.Length ~ Species, data=iris)
with(iris, plot(Sepal.Length, Sepal.Width, col = Species, 
                pch = as.numeric(Species)))
with(iris, plot(jitter(Sepal.Length), jitter(Sepal.Width), col=Species, 
                pch=as.numeric(Species)))
pairs(iris)


## ----------------------- More Explorations -----------------------
library(scatterplot3d)
scatterplot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)
## library(rgl)
## plot3d(iris$Petal.Width, iris$Sepal.Length, iris$Sepal.Width)
dist.matrix <- as.matrix(dist(iris[,1:4]))
heatmap(dist.matrix)
library(lattice)
levelplot(Petal.Width ~ Sepal.Length * Sepal.Width, 
          data=iris, cuts=8)
filled.contour(volcano, color=terrain.colors, asp=1, 
               plot.axes=contour(volcano, add=T))
persp(volcano, theta=25, phi=30, expand=0.5, col="lightblue")    
library(MASS)
parcoord(iris[1:4], col=iris$Species)
library(lattice)
parallelplot(~iris[1:4] | Species, data=iris)
library(ggplot2)
qplot(Sepal.Length, Sepal.Width, data=iris, facets=Species ~.)


## ----------------------- Save Charts to Files -----------------------
## # save as a PDF file
## pdf("myPlot.pdf")
## x <- 1:50
## plot(x, log(x))
## graphics.off()
## #
## # Save as a postscript file
## postscript("myPlot2.ps")
## x <- -20:20
## plot(x, x^2)
## graphics.off()
## ggsave('myPlot3.png')
## ggsave('myPlot4.pdf')
## ggsave('myPlot5.jpg')
## ggsave('myPlot6.bmp')
## ggsave('myPlot7.ps')
## ggsave('myPlot8.eps')
