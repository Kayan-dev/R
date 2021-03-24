
getwd()
setwd("/home/hefe/R/R-Beginner")
getwd()


fin <- read.csv("Future500.csv")
fin
head(fin)
tail(fin)
summary(fin)
str(fin)
  

z <- c("12", "13", "14", "12","13")
typeof(z)
z
y <- factor(c("12", "13", "14", "12","13"))
y
levels(y)
typeof(y)
y <- is.numeric(y)
y
w <- as.numeric(y)
w
typeof(w)

#FVT Example

head(fin)
str(fin)
fin$Profit <- factor(fin$Profit)

head(fin)
str(fin)

summary(fin)

#Dangerous = fin$Profit <- as.numeric(fin$Profit)


#sub() and gsub()
?sub

fin$Expenses <- gsub(" Dollars", "",fin$Expenses)
fin$Expenses <- gsub(",", "",fin$Expenses)
head(fin)

#another example
fin$Revenue <- gsub("$", "",fin$Revenue) #dit werkt niet, omdat $ speciaal teken is
fin$Revenue <- gsub("\\$", "",fin$Revenue) # zo werkt het wel : \\$
fin$Revenue <- gsub(",", "",fin$Revenue)
head(fin)
#Doesn't work for $ cuz $ is a special function in R
#Use \\
fin$Revenue <- gsub("\\$", "",fin$Revenue)
fin$Revenue <- gsub(",", "",fin$Revenue)
head(fin)

fin$Growth <- gsub("%", "",fin$Growth)
head(fin)
str(fin)
#Correct way to set factor as numeric
# the factor is first converted into character
fin$Growth <- as.numeric(fin$Growth)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Expenses <- as.numeric(fin$Expenses)
str(fin)

#Dealing with missing data
#Six options
#1 Predict with 100% accuracy = City, which state?
#2 Leave record as is = year as category 
#3 Remove record entirely =important category missing (industry)
#4 replace with mean or median = employees
#5 fill in by exploring correlations and similarities = year, expenses
#6 introduce dummy variable for "missingness" 

#What is NA?
#NA is logical
NA
?NA

TRUE #1
FALSE #2
NA

# Elegant way to locate missing values

#Basic: fin <- read.csv("Future 500.csv")
fin <- read.csv("Future500.csv", na.strings=c(""))
fin
head(fin,25)
complete.cases(fin)
head(complete.cases(fin))

#Updated import to: fin <- read.csv(file.choose(), na.strings=c(""))
fin <- read.csv("Future500.csv", na.strings=c(""))
head(!complete.cases(fin))

#zo vind je alle NIET complete data
fin[!complete.cases(fin),]
#zo vind je alle WEL complete data
fin[complete.cases(fin),]


#Filtering: using is.na() for missing data
head(fin,24)
fin[is.na(fin$Expenses),]
#fin$Expenses == NA
fin[fin$Expenses == NA,]

#Example

a <- c(1, 4, 8,5, NA, 677, 74, NA)
is.na(a)
which(is.na(a))

#Uitvoering
fin[is.na(fin$Expenses),]
is.na(fin$Expenses)
which(is.na(fin$Expenses))
head(is.na(fin$Expenses))
which(is.na(fin_backup$Expenses))

#Betere uitvoering
fin[is.na(fin$Expenses),]

#Voor State 
fin[is.na(fin$State),]

#Algemeen 
fin[!complete.cases(fin),]

#Removing records with missing data
fin_backup <- fin
fin <- fin_backup
fin[!complete.cases(fin),]
fin[is.na(fin$Industry),]
fin[!is.na(fin$Industry),] #opposite

fin <- fin[!is.na(fin$Industry),]
fin
fin[is.na(fin$Industry),]

#Resetting the dataframe index
summary(fin)

rownames(fin)
rownames(fin) <- 1:nrow(fin)
fin
summary(fin)

#Or quicker way to reset
#make sure to reset fin <- fin_backup to practisse this exercise
#Use  <- NULL
fin <- fin_backup
fin

fin <- fin[!is.na(fin$Industry),]
fin
fin[is.na(fin$Industry),]

rownames(fin) <- 1:nrow(fin)
rownames(fin) <- NULL
tail(fin)
summary(fin)


#Replacing Missing Data: Factual Analysis

fin[!complete.cases(fin),]

fin[is.na(fin$State) & fin$City=="New York",]
fin[is.na(fin$State) & fin$City=="New York","State"]
fin[is.na(fin$State) & fin$City=="New York","State"] <- "NY"
#Check:
fin[c(11,377),]
fin[!complete.cases(fin),]

#Try it for San Francisco
fin[is.na(fin$State) & fin$City=="San Francisco",]
fin[is.na(fin$State) & fin$City=="San Francisco","State"]

#I didnt know if San Francisco was in California 
#Or how California was coded in the dataset
fin[fin$State=="CA",]
#It is coded as CA
fin[is.na(fin$State) & fin$City=="San Francisco","State"] <- "CA"
#Check
fin[fin$City=="San Francisco",]
fin[!complete.cases(fin),]

#How to change missing data for employees
fin[fin$Employees,]
#The following with mean() is not possible
mean(fin[fin$Employees,])
# daarom na.rm=TRUE, maar kolom is niet numeric
mean(fin[fin$Employees,], na.rm = TRUE)
#Dus:
fin$Employees <- as.numeric(fin$Employees)
mean(fin[fin$Employees,], na.rm = TRUE)
#Deze code is niet goed het moet zo;
mean(fin[,"Employees"], na.rm = TRUE)
# Dit werkt ook niet: mean(fin[,fin$Employees], na.rm= T)
str(fin)

#Median
median(fin[,"Employees"])
#na.rm=T toevoegen
median(fin[,"Employees"], na.rm = T)
#Bekijken alleen voor retail
median(fin["Retail","Employees"], na.rm = T)
#Hierboven krijg je alleen NA, omdat niet alle retails meegenomen worden
median(fin[fin$Industry=="Retail","Employees"], na.rm = T)
#Maak er een variable van, altijd
med_ret_emp <- median(fin[fin$Industry=="Retail","Employees"], na.rm = T)
med_ret_emp
#mean voor retail
mean_ret_emp <- mean(fin[fin$Industry=="Retail","Employees"], na.rm = T)
mean_ret_emp

#Change NA under Employee now with median value
fin[is.na(fin$Employees & fin$Industry=="Retail"),"Employees"] <- med_ret_emp
#check
fin[3,]
fin[is.na(fin$Employees),]

fin[is.na(fin$Employees & fin$Industry=="Financial Services"), "Employees"]
#Do now the same for Financial Services
fin[is.na(fin$Employees),]

#Mean
mean_fin_empl <- mean(fin[fin$Employees & fin$Industry=="Financial Services",])
#Vergeet na.rm=T niet
mean_fin_empl <- mean(fin[fin$Employees & fin$Industry=="Financial Services",], na.rm = T)
#Verkeerde code zie hieronder voor het correcte:
mean_fin_empl <- mean(fin[fin$Industry=="Financial Services","Employees"], na.rm = T)
mean_fin_empl
#Median
med_fin_empl <- median(fin[fin$Industry=="Financial Services","Employees"], na.rm = T)
med_fin_empl
#Verander Na naar median
#Dit klopt niet:
fin[is.na(fin$Employees),"Financial Services"]
#Dit klopt ook niet:
fin[is.na(fin$Employees),]
#Juiste code:
fin[is.na(fin$Employees & fin$Industry=="Financial Services"),"Employees"] <- med_fin_empl
#Check
fin[330,]
fin[is.na(fin$Employees),]

#Replacing Missing data: Median Imputation Method (Part 2)
fin[!complete.cases(fin),]
fin$Growth <- as.numeric(fin$Growth)
str(fin)
med_growth <- median(fin[fin$Growth=="Growth",], na.rm = T)
fin[fin$Growth,]

#Hoe stom
mean_growth <- mean(fin[fin$Industry=="Construction","Growth"], na.rm = T)
mean_growth
median_growth <- median(fin[fin$Industry=="Construction", "Growth"], na.rm = T )
median_growth

#Verander NA voor growth met industrie median
#Als je "Growth" niet toevoegd bij kolom kreeg je de hele rij
fin[is.na(fin$Growth & fin$Industry=="Construction"),]
#Dus "Growth"
fin[is.na(fin$Growth & fin$Industry=="Construction"), "Growth"] <- median_growth
#Check
fin[!complete.cases(fin),]
fin[8,]

#Replacing Missing Data: Median Imputation Method (part 3)
#Eerst zelf geprobeerd
fin[!complete.cases(fin),]
#Revenue en Expenses veranderen met median
#Specifiek voor Revenue en dan Expenses, voor industrie= construction
fin$Revenue <- as.numeric(fin$Revenue)
med_rev_con <- median(fin[fin$Industry=="Construction","Revenue"], na.rm = T)
med_rev_con
fin[fin$Revenue & fin$Industry=="Construction",]
fin[fin$Revenue,]
#Voeg median toe aan NA waarden
fin[is.na(fin$Revenue & fin$Industry=="Construction"),"Revenue"] <- med_rev_con
#Check
fin[!complete.cases(fin),]

#EXPENSES:
#Exact hetzelfde voor Expenses
fin$Expenses <- as.numeric(fin$Revenue)
med_exp_con <- median(fin[, "Expenses"],na.rm = T)
med_exp_con
#Voeg median aan NA voor Expenses
str(fin)
fin$Expenses <- as.numeric(fin$Expenses)
fin[is.na(fin$Expenses & fin$Industry=="Construction"),"Expenses"] <- med_exp_con
#check
fin[!complete.cases(fin),]

#Verander expenses voor IT Services
actual_exp_ID15 <- (14001180-11901180) 
actual_exp_ID15
str(fin)
#   fin$Expenses <- as.numeric(fin$Expenses)
fin[is.na(fin$Expenses & fin$Industry=="IT Services"),"Expenses"] <- actual_exp_ID15
#Check
fin[!complete.cases(fin),]

#PROFIT:
#Change profit
actual_profit <- (9055058-4600156)
actual_profit
fin[is.na(fin$Industry=="Construction" & fin$Profit), "Profit"] <- actual_profit
#check
fin[!complete.cases(fin),]

#Gegeven voorbeeld voor profit change:
fin[is.na(fin$Profit),"Profit"] <- fin[is.na(fin$Profit),"Revenue"] - fin[is.na(fin$Profit),"Expenses"]
fin[c(8,42),]
fin[15,]
fin[!complete.cases(fin),]


#Data visualization
library(ggplot2)
head(fin)

#A scatterplot classified by industry showin revenue, expenses, profit
p <- ggplot(data=fin, aes(x=Expenses, y=Revenue, colour=Industry))
p
p + geom_point(data=fin, size=1.5) + geom_smooth(fill=NA)

#Scatterplot

d <- ggplot(data=fin, aes(x=Revenue, y=Expenses, colour=Industry), size=Profit)
d + geom_point() + geom_smooth(fill=NA,size=1.5)

#Boxplot

b <- ggplot(data=fin, aes(x=Industry, y=Profit, colour=Industry))
b + geom_boxplot() + geom_jitter(alpha=0.5, size=1)

c <- ggplot(data=fin, aes(x=Industry, y=Growth, colour=Industry))
c + geom_boxplot() + geom_jitter(alpha=0.5, size=1)

e <- ggplot(data=fin, aes(x=Industry, y=Revenue, colour=fin$Industry))
e + geom_boxplot() + geom_jitter(alpha=0.5, size=1, outlier.color=NA)
