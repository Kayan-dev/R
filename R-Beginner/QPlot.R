install.packages("ggplot2")
library(ggplot2)
?qplot
head(stats,3)
qplot(data=stats, x=Internet.users)
qplot(data=stats, x=Internet.users, y=Birth.rate)
#Dit is niet goed:
qplot(data=stats, x=Income.Group, y=Birth.rate, size=3)
#Dit is wel goed met I() voor size:
qplot(data=stats, x=Income.Group, y=Birth.rate, size= I(10))
#Kleur kiezen, ook met I():
qplot(data=stats, x=Income.Group, y=Birth.rate, size= I(3), colour=I("blue"))
#Visualisatie kiezen zoals boxplot:
qplot(data=stats, x=Income.Group, y=Birth.rate, size= I(0.5), color=I("Purple"), geom="boxplot")

#---------------Visualizing what we need
qplot(data=stats, x=Internet.users, y=Birth.rate)
qplot(data=stats, x=Internet.users, y=Birth.rate, size=I(3), colour=I("blue"))

#Waarden andere kleuren geven door colour waarde te veranderen:
qplot(data=stats, x=Internet.users, y=Birth.rate, size=I(3), color=Income.Group)

stats[stats$Internet.users < 25 & stats$Income.Group == "High income",]
stats[stats$Internet.users < 25 & stats$Income.Group == "Upper middle income",]


regions <- read.csv(file.choose())
regions
#-------- Creating Data Frame

mydf <- data.frame(Countries_2012_Dataset, Codes_2012_Dataset, Regions_2012_Dataset)

head(mydf)
#Kolom namen zijn te lang dus verander: 
colnames(mydf) <- c("Country", "Code", "Region")
mydf
head(mydf)

#Dit kan veel sneller door direct de kolom namen te veranderen
rm(mydf)
mydf <- data.frame(Country=Countries_2012_Dataset, Code=Codes_2012_Dataset, Regions=Regions_2012_Dataset)
head(mydf)
tail(mydf)
summary(mydf)      

#------------ Merging Data Frames
head(stats)
head(mydf)

merged <- merge(stats, mydf, by.x = "Country.Code", by.y = "Code")
merged
head(merged)
merged$xyz <- NULL
head(merged)
str(merged)


qplot(data= merged, x=Birth.rate, y=Internet.users, size=I(3) ,color=Regions)

#1. Shapes
qplot(data= merged, x=Birth.rate, y=Internet.users, size=I(3) ,color=Regions, shape=I(18))
#2. Transparency
qplot(data= merged, x=Birth.rate, y=Internet.users, size=I(3) ,color=Regions, shape=I(19), alpha=I(0.5))
#3. Titles
qplot(data= merged, x=Birth.rate, y=Internet.users, size=I(3) ,color=Regions, shape=I(19), alpha=I(0.5), main="Birth Rate vs Internet users")


dataset <- read.csv(file.choose())
dataset
head(dataset)
str(dataset)

data1960 <- dataset[dataset$Year== 1960,]
head(data1960)

data2013 <- dataset[dataset$Year==2013,]
head(data2013)


data1960[data1960$Fertility.Rate < 2,]
data2013[data2013$Fertility.Rate < 2,]

dataset[dataset$Country.Name == "Canada",]

secdf <- data.frame(Code= Country_Code, Life_2013= Life_Expectancy_At_Birth_2013, Life_1960= Life_Expectancy_At_Birth_1960)
secdf
head(secdf)
tail(secdf)
summary(secdf)

NewMerged1 <- merge(data1960, secdf, by.x = "Country.Code", by.y ="Code")
head(NewMerged1)
tail(NewMerged1)
summary(NewMerged1)
NewMerged1$Life_2013 <- NULL
head(NewMerged1)

NewMerged2 <- merge(data2013, secdf, by.x = "Country.Code", by.y = "Code")
head(NewMerged2)
NewMerged2$Life_1960 <- NULL
tail(NewMerged2)
summary(NewMerged2)


qplot(data=NewMerged2, x= Fertility.Rate, y=Life_2013, size=I(3), color=Region, alpha=I(0.3))
qplot(data=NewMerged1, x= Fertility.Rate, y=Life_1960, size=I(3), color=Region, alpha=I(0.3))
