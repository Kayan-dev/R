
###################################################
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    July 2019
###################################################

## load required packages
library(fpc) # for dbscan, pamk and kmeansruns
library(cluster) # for pam, diana and clara


## the IRIS dataset
str(iris)
summary(iris)


## k-means clustering
## set a seed for random number generation to make the results reproducible
set.seed(8953) 
## make a copy of iris data
iris2 <- iris
## remove the class label, Species
iris2$Species <- NULL
## run kmeans clustering to find 3 clusters
kmeans.result <- kmeans(iris2, 3)
## ## print the clusterng result
## kmeans.result
kmeans.result
table(iris$Species, kmeans.result$cluster)
plot(iris2[, c("Sepal.Length", "Sepal.Width")], 
     col = kmeans.result$cluster)
points(kmeans.result$centers[, c("Sepal.Length", "Sepal.Width")], 
       col = 1:3, pch = 8, cex=2) # plot cluster centers


library(fpc)
kmeansruns.result <- kmeansruns(iris2)
kmeansruns.result


## clustering with PAM
library(cluster)
# group into 3 clusters
pam.result <- pam(iris2, 3) 
# check against actual class label
table(pam.result$clustering, iris$Species) 
## plot(pam.result)
layout(matrix(c(1,2),1,2)) # 2 graphs per page 
plot(pam.result)
layout(matrix(1)) # change back to one graph per page 


library(fpc)
pamk.result <- pamk(iris2)
# number of clusters
pamk.result$nc
# check clustering against actual class label
table(pamk.result$pamobject$clustering, iris$Species)
## plot(pamk.result)
layout(matrix(c(1,2),1,2)) # 2 graphs per page 
plot(pamk.result$pamobject)
layout(matrix(1)) # change back to one graph per page 


## hiercrchical clustering
set.seed(2835)
# draw a sample of 40 records from the iris data, so that the clustering plot will not be over crowded
idx <- sample(1:dim(iris)[1], 40)
iris3 <- iris[idx,]
# remove class label
iris3$Species <- NULL
# hierarchical clustering
hc <- hclust(dist(iris3), method="ave")
# plot clusters
plot(hc, hang = -1, labels=iris$Species[idx])
# cut tree into 3 clusters
rect.hclust(hc, k=3)
# get cluster IDs
groups <- cutree(hc, k=3)
plot(hc, hang = -1, labels=iris$Species[idx])
rect.hclust(hc, k=3) # cut tree into 3 clusters


## clustering with DIANA
library(cluster)
diana.result <- diana(iris3)
## plot(diana.result, which.plots=2, labels=iris$Species[idx])
plot(diana.result, which.plots=2, labels=iris$Species[idx])


## Density-based Clustering
library(fpc)
iris2 <- iris[-5] # remove class tags
ds <- dbscan(iris2, eps=0.42, MinPts=5)
ds
# compare clusters with actual class labels
table(ds$cluster, iris$Species)
plot(ds, iris2)
plot(ds, iris2[, c(1,4)])
plotcluster(iris2, ds$cluster)


## cluster prediction
# create a new dataset for labeling
set.seed(435) 
idx <- sample(1:nrow(iris), 10)
# remove class labels
new.data <- iris[idx,-5]
# add random noise
new.data <- new.data + matrix(runif(10*4, min=0, max=0.2), 
                              nrow=10, ncol=4)
# label new data
pred <- predict(ds, iris2, new.data) 
table(pred, iris$Species[idx]) # check cluster labels
plot(iris2[, c(1,4)], col=1+ds$cluster)
points(new.data[, c(1,4)], pch="+", col=1+pred, cex=3)
