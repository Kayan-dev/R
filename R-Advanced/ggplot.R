getwd()
setwd("/desktop/efe/R/R-Advanced")
getwd()

movies <- read.csv("P2-Movie-Ratings.csv")
movies
head(movies)
tail(movies)
summary(movies)

colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions", "Year")
head(movies)
tail(movies)
str(movies)

#Change YEAR to a category by using factor()
factor(movies$Year)
movies$Year <- factor(movies$Year)
movies$Year
summary(movies)
str(movies)


#--------- Aesthetics
library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

#----------Add Geometrie
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) +
  geom_point()

#More Aethetics = more color
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre, size=BudgetMillions,alpha=I(0.75))) +
  geom_point()
#>>> This is the first try but it will improve with new ggplot skills

#------ Plotting with layers

p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre, size=BudgetMillions,alpha=I(0.75)))
str(p)


#Geometrie POINTS
p + geom_point()

#Geometrie LINES
p + geom_line()

#Multiple Layers
p + geom_point() + geom_line()
p + geom_line() + geom_point()
p + geom_boxplot() + geom_point()
p + geom_abline() + geom_point()
p + geom_blank()


#----Overriding Aesthetics

q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             colour=Genre, size=BudgetMillions))
#add geom layer
q+ geom_point()

#Overriding aes = criticrating instead of budgetmillions
q + geom_point(aes(size=CriticRating))

#Examples
q + geom_point(aes(color=BudgetMillions))
q + geom_point(aes(colour=CriticRating))
q + geom_point(aes(color=CriticRating, size=BudgetMillions))
q + geom_point(aes(color=BudgetMillions, size=CriticRating))

# q remains the same
q + geom_point()

#Example 3
q +geom_point(aes(x=BudgetMillions))
#de x-as zegt nog steeds CriticRating dus;
q + geom_point(aes(x=BudgetMillions)) +
  xlab("Budget Millions")

#Example 4
q + geom_line() + geom_point()
#reduce line size
q + geom_line(size=1) + geom_point(size=1)
#I.p.v. aes() kun je meteen size typen
#Dit is mapping vs setting


#------Mapping vs Setting

r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()

#Add colour
#1. Mapping (what we've done so far);
r + geom_point(aes(colour=Genre))
#2. Setting (New way);
r + geom_point(colour="DarkGreen")
#Error:
r + geom_point(aes(colour="DarkGreen"))

#1. Mapping
r + geom_point(aes(size=BudgetMillions))
#Setting
r + geom_point(size=10)
#Error
r + geom_point(aes(size=10))

# Mapping = use aes() function
# Setting = size=, colour= etc.


#---------- Histograms and Density Charts

s <- ggplot(data=movies, aes(x=BudgetMillions, colour=Genre))
s + geom_histogram(binwidth=20)

#Add colour by Setting "fill="
s + geom_histogram(binwidth = 10, fill="Green")
#Add colour by Mapping "aes(fill=)"
s + geom_histogram(binwidth = 15, aes(fill=Genre))
#If you want set colour to the lines use colour outside of aes();
s + geom_histogram(binwidth=20, aes(fill=Genre), color="Black")
#See the difference
s + geom_histogram(binwidth=20)

#>>> Chart nr.3 (we will improve it)

#Sometimes you may need density charts
s + geom_density()
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position="stack")
s + geom_density(aes(fill=Genre), position="stack", colour="Black")


#--------Starting Layer Tips

t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10,
          fill="white", colour="Blue")
#another way
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10,
                   aes(x=AudienceRating),
                   fill="white", colour="Blue")
#>>> another
t + geom_histogram(binwidth = 10,
                    aes(x=CriticRating),
                    fill="DarkRed", colour="Orange")
#>>> empty plot in case of different datasets
t <- ggplot()


#------ Statistical Transformation

?geom_smooth

u <- ggplot(data=movies, aes(x=AudienceRating, y=CriticRating, colour=Genre))
u + geom_smooth(fill=NA) + geom_point()

#boxplots
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating, color=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.0)
u+ geom_boxplot(size=1.0) + geom_point()
#top / hack for points = jitter
u + geom_boxplot(size=1.0) + geom_jitter()
#Another way
u + geom_jitter() + geom_boxplot(size=1.0, alpha=0.3)

# Boxplot for CriticRating
v <- ggplot(data=movies, aes(x=Genre, y=CriticRating, colour=Genre))
v + geom_jitter() + geom_boxplot(size=1.0, alpha=0.3)

#Histogram for every genre= Facets
#--------- Using Facets

e <- ggplot(data=movies, aes(x=BudgetMillions))
e + geom_histogram(colour="Black", binwidth = 20, aes(fill=Genre))

  d <- ggplot(data=movies, aes(x=BudgetMillions))
d + geom_histogram(binwidth = 20, aes(fill=Genre),
                   colour="Black")
#Histogram for every Genre = Facets
e + geom_histogram(binwidth = 20, aes(fill=Genre),
                   color="Black") + 
      facet_grid(Genre~.)
#Fix Scale for better insight
e + geom_histogram(binwidth = 20, aes(fill=Genre),
                   color="Black") + 
  facet_grid(Genre~., scales = "free")


#Scatterplot

w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, color=Genre))
w + geom_point(size=2)

#Facets
w + geom_point(size=3) +
    facet_grid(Genre~.)
w + geom_point(size=3) +
    facet_grid(.~Year)
w + geom_point(size=1.5) +
    facet_grid(Genre~Year)
w + geom_point(size=1.5) +
  geom_smooth() +
  facet_grid(Genre~Year)
w +geom_point(aes(size=BudgetMillions)) +
  geom_smooth(fill=NA) +
  facet_grid(Genre~Year)

#Improve Chart Coordinates
#How to limit axis
#How to zoom into axis

m <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, size=BudgetMillions, color=Genre))

m + geom_point()

m + geom_point() +
  xlim(50,100) +
  ylim(50,100)  

#This won't work well always
n <- ggplot(data=movies, aes(x=BudgetMillions))
n + geom_histogram(binwidth = 15, aes(fill=Genre), colour="Black")

#This actually cuts off data points
#It doesn't just zoom in
n + geom_histogram(binwidth = 15, aes(fill=Genre), colour="Black") +
  ylim(0,50)

# Instead - zoom:
n + geom_histogram(binwidth = 15, aes(fill=Genre), colour="Black") +
    coord_cartesian(ylim = c(0,50))

n + geom_histogram(binwidth = 15, aes(fill=Genre), colour="Black") +
    coord_cartesian(xlim = c(0,150))

#Zoom in to improved plot
w +geom_point(aes(size=BudgetMillions)) +
  geom_smooth(fill=NA) +
  facet_grid(Genre~Year) +
  coord_cartesian(ylim = c(0,100))

# Theme
o <- ggplot(data=movies, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")
h
#Axes labels
h + xlab("Money Axis") +
  ylab("Number of Movies")
#label formatting
h + xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour="DarkGreen", size=20),
        axis.title.y = element_text(colour="Red", size=20))
#Tick mark formatting
h + xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour="DarkGreen", size=20),
        axis.title.y = element_text(colour="Red", size=20),
        axis.text.y = element_text(size=20),
        axis.text.x = element_text(size=20))
#Check out what Theme supplies
?theme

h + xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour="DarkGreen", size=20),
        axis.title.y = element_text(colour="Red", size=20),
        axis.text.y = element_text(size=20),
        axis.text.x = element_text(size=20),
        panel.grid.major.x = element_line(color="Black"),
        panel.grid.major.y = element_line(color="Black"))

#Legend formatting
h + xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour="DarkGreen", size=20),
        axis.title.y = element_text(colour="Red", size=20),
        axis.text.y = element_text(size=20),
        axis.text.x = element_text(size=20),
        panel.grid.major.x = element_line(color="Black"),
        panel.grid.major.y = element_line(color="Black"),
        
        legend.title = element_text(size=20),
        legend.text =  element_text(size=15),
        legend.position = c(1,1),
        legend.justification = c(1,1))

#Title Formatting
h + xlab("Money Axis") +
  ylab("Number of Movies") +
  ggtitle("Distribution of Movie Budgets") +
  theme(axis.title.x = element_text(colour="DarkGreen", size=20),
        axis.title.y = element_text(colour="Red", size=20),
        axis.text.y = element_text(size=20),
        axis.text.x = element_text(size=20),
        panel.grid.major.x = element_line(color="Black"),
        panel.grid.major.y = element_line(color="Black"),
        legend.title = element_text(size=20),
        legend.text =  element_text(size=15),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        plot.title = element_text(colour = "DarkRed",
                                  size=30, family = "Courier"))
  