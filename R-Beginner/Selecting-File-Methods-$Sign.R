#Method 1: Select The File Manually

stats <- read.csv(file.choose())
stats


#Method 2: Set WD and Read Data
getwd()
setwd("/home/hefe/R")
rm(stats)
stats <- read.csv("P2-Demographic-Data.csv")



#-------- Exploring Data
stats
nrow(stats)
#Imported rows:195
ncol(stats)
#Imported column:5
head(stats, n=10)
#Shows top 6 rows including column (names) or change n
tail(stats, n=8)
#Shows bottom 6 rows incl. column (names) or change n
str(stats)
#Shows STRucture, it gives numbers or levels to different factors
runif(stats)
# R variables distributed UNIFormarly
summary(stats)
#Samenvatting voor meerdere factors, zeer handig

#-------- Using the $ sign
stats
head(stats)
stats[3,3,] #matrix
stats[3, "Birth.rate"] # kolom naam geeft zelfde resultaat
stats[ , 3]
stats["Angola", 3] # Rows hebben geen namen, maar cijfers, Angola is een waarde
stats$Internet.users # $ geeft de hele kolom
stats$Internet.users[2] #geeft aan welke rij van internet.users

# Deze twee methoden geven dezelfde resultaat
head(stats$Internet.users)
head(stats[,"Internet.users"])

#levels laat zien wat de levels zijn per kolom
levels(stats$Income.Group)
