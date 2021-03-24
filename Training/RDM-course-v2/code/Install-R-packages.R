########################################################################
## Install R packages used by the R and Data Mining book and course
## by Yanchang Zhao
## July 2019
## Email: yanchang@RDataMining.com
## http://RDataMining.com
##
## This script is for installing R packages used for the R and Data Mining training course. 
## It may take a couple of minutes, depending on the speed of your Internet connection.
##
## Q&A:
##
## 1. "Package which is only available in source form, and may need compilation of C/C++/Fortran: ‘RODBC’
##     Do you want to attempt to install these from sources? y/n:" 
##  A: Choose "y".
##
## 2. The downloaded binary packages are in ... 
##    Old packages: ...
##    Update all/some/none? [a/s/n]:"
##  A: Choose "a" to update all old packages, or "n" to update none.
##
## 3. Installing RODBC on Mac or Linux
##  A: Run steps below:
##     1) ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
##     2) brew update
##     3) brew install unixODBC
##     4) install.packages("RODBC") and choose "y" when asked whether to install it from sources.
##
## 4. Installing rgl on Mac or Linux
##  A: Download and install XQuartz https://www.xquartz.org and then install the rgl package.
########################################################################



## what's already included in R base:
## rpart, parallel, data.table


## install R packages from CRAN
pkgs <- c("arules", "arulesSequences", "arulesViz", "caret", "cluster", 
          "data.table", "dplyr", "dtw", "e1071",
          "ff", "fpc", "foreign", "ggplot2", "glmnet", 
          "Hmisc", "igraph", "knitr", "lattice", "lda",
          "magrittr", "MASS", "party", 
          "randomForest", "RColorBrewer", "rgl", "rJava", "rmarkdown", "ROAuth", "ROCR", "RODBC", 
          "rpart.plot", "scatterplot3d", "sna", "SnowballC", "snowfall", "stringi", "stringr",
          "TH.data", "topicmodels", "tm", "twitteR", "ROAuth",
          "visNetwork", "wavelets", "wordcloud", "openxlsx")

## exclude packages already installed
pkgs.installed <- installed.packages()
pkgs.to.install <- setdiff(pkgs, pkgs.installed[, 1])
print("Packages to install:")
print(pkgs.to.install)
install.packages(pkgs.to.install)


## install R packages from Bioconductor
source("http://bioconductor.org/biocLite.R")
biocLite("graph")
biocLite("Rgraphviz")


## install R packages from GitHub
install.packages("devtools")
library(devtools)
install_github("okugami79/sentiment140")
