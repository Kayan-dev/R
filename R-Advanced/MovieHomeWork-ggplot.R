getwd()
setwd("/home/hefe/R")
getwd()

AllMovies <- read.csv(file.choose())
head(AllMovies)
tail(AllMovies)
str(AllMovies)
summary(AllMovies)

colnames(AllMovies) <- c("DayOfWeek", "Director", "Genre", "MovieTitle", "ReleaseDate", "Studio", "AdjustedGross", "BudgetInMill", "GrossInMill", "IMBDRating", "MoveLensRating", "OverseasInMill", "Overseas%", "ProfitInMill", "ProfitPer", "RunTimeInMin", "USInMill", "USGrossPer")
head(AllMovies)

library(ggplot2)

ggplot(data=AllMovies, aes(x=DayOfWeek)) + geom_bar()

ggplot(data=AllMovies, aes(x=Genre, y=USGrossPer))

A <- ggplot(data=Mov, aes(x=Genre, y=USGrossPer))


A + geom_jitter(aes(size=BudgetInMill, color=Genre)) + 
  geom_boxplot(alpha=0.7)


#Genre en Studio categoriseren

factor(AllMovies$Genre)
AllMovies$Genre <- factor(AllMovies$Genre)
AllMovies$Genre
summary(AllMovies)
str(AllMovies)

Filt <- (AllMovies$Genre == "action") | (AllMovies$Genre == "adventure")| (AllMovies$Genre == "comedy") | (AllMovies$Genre == "animation") | (AllMovies$Genre == "drama")

Filt2<- (AllMovies$Studio == "Fox") | (AllMovies$Studio == "Paramount Pictures") | (AllMovies$Studio == "Sony") | (AllMovies$Studio == "Universal") | (AllMovies$Studio == "WB") | (AllMovies$Studio == "Buene Vista Studios")

Mov <- AllMovies[Filt&Filt2,]
Mov
summary(Mov)
