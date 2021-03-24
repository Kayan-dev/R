
###################################################
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    July 2019
###################################################

## load required packages
library(magrittr) 
library(arules)
library(arulesViz)


## ## download data
## download.file(url="http://www.rdatamining.com/data/titanic.raw.rdata",
##               destfile="./data/titanic.raw.rdata")
library(magrittr) ## for pipe operations
## load data, and the name of the R object is titanic.raw
load("../data/titanic.raw.rdata")
## dimensionality
titanic.raw %>% dim()
## structure of data
titanic.raw %>% str()
## draw a random sample of 5 records
idx <- 1:nrow(titanic.raw) %>% sample(5)
titanic.raw[idx, ]
## a summary of the dataset
titanic.raw %>% summary()


## mine association rules
library(arules) ## load required library
rules.all <- titanic.raw %>% apriori() ## run the APRIORI algorithm
rules.all %>% length() ## number of rules discovered
rules.all %>% inspect() ## print all rules


## run APRIORI again to find rules with rhs containing "Survived" only
rules.surv <- titanic.raw %>% apriori(
             control = list(verbose=F),
             parameter = list(minlen=2, supp=0.005, conf=0.8),
             appearance = list(rhs=c("Survived=No",
                                     "Survived=Yes"),
                               default="lhs"))
## keep three decimal places
quality(rules.surv) <- rules.surv %>% quality() %>% round(digits=3)
## sort rules by lift
rules.surv.sorted <- rules.surv %>% sort(by="lift")
rules.surv.sorted %>% inspect() ## print rules


## redundant rules
rules.surv.sorted[1:2] %>% inspect()
## find redundant rules
subset.matrix <- is.subset(rules.surv.sorted, rules.surv.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- F
redundant <- colSums(subset.matrix) >= 1
## which rules are redundant
redundant %>% which()

## remove redundant rules
rules.surv.pruned <- rules.surv.sorted[!redundant]
rules.surv.pruned %>% inspect() ## print rules
rules.surv.pruned[1] %>% inspect() ## print rules


## mine rules about class and age group
rules.age <- titanic.raw %>% apriori(control = list(verbose=F),
     parameter = list(minlen=3, supp=0.002, conf=0.2),
     appearance = list(default="none", rhs=c("Survived=Yes"),
                       lhs=c("Class=1st", "Class=2nd", "Class=3rd",
                             "Age=Child", "Age=Adult")))
rules.age <- sort(rules.age, by="confidence")
rules.age %>% inspect() ## print rules
## average survival rate
titanic.raw$Survived %>% table() %>% prop.table() 


## rule visualisation
library(arulesViz)
rules.all %>% plot()
rules.surv %>% plot(method="grouped")
rules.surv %>% plot(method="graph", 
                    control=list(layout=igraph::with_fr()))
rules.surv %>% plot(method="graph", 
                    control=list(layout=igraph::in_circle()))
rules.surv %>% plot(method="paracoord", 
                    control=list(reorder=T))
## rules.all %>% plot(interactive = T)
## rules.surv %>% plot(method="paracoord", control=list(reorder=T))
## 
## 
## ## load mushroom data from UCI the Machine Learning Repository
## url <- past0("http://archive.ics.uci.edu/ml/",
##     "machine-learning-databases/mushroom/agaricus-lepiota.data")
url <- "../data/mushroom/agaricus-lepiota.data"
mushrooms <- read.csv(file = url, header = FALSE)
names(mushrooms) <- c("class", "cap-shape", "cap-surface",
    "cap-color", "bruises", "odor", "gill-attachment", "gill-spacing",
    "gill-size", "gill-color", "stalk-shape", "stalk-root",
    "stalk-surface-above-ring", "stalk-surface-below-ring",
    "stalk-color-above-ring", "stalk-color-below-ring",
    "veil-type", "veil-color", "ring-number", "ring-type",
    "spore-print-color", "population", "habitat")
table(mushrooms$class, useNA="ifany")
str(mushrooms)


## find associatin rules from the mushroom dataset
rules <- apriori(mushrooms, control = list(verbose=F),
                 parameter = list(minlen=2, maxlen=5),
                 appearance = list(rhs=c("class=p", "class=e"),
                                   default="lhs"))
quality(rules) <- round(quality(rules), digits=3)
rules.sorted <- sort(rules, by="confidence")
inspect(head(rules.sorted))
