#Method 1: Select The File Manually

stats <- read.csv(file.choose())
stats


#Method 2: Set WD and Read Data
getwd()
setwd("/home/hefe/R")
rm(stats)
stats <- read.csv("P2-Demographic-Data.csv")
