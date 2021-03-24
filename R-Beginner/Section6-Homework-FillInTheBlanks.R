#Import the Data
getwd()
setwd("_")
mov <- read.csv("Section6-Homework-Data.csv")

#Data Exploration
_(mov) #top rows
_(mov) #column summaries
_(mov) #structure of the dataset

#Activate GGPlot2
#install.packages("ggplot2")
library(_)

#{Offtopic} This Is A Cool Insight:
ggplot(data=mov, aes(x=Day.of.Week)) + geom_bar()
#Notice? No movies are released on a Monday. Ever.

#Now we need to filter our dataset to leave onlly the 
#Genres and Studios that we are interested in
#We will start with the Genre filter and use the Logical 'OR'
#operator to select multiple Genres:
filt <- (mov$Genre == "action") | (mov$Genre == "adventure") | (mov$Genre == "animation") | (mov$Genre == "comedy") | (mov$Genre == "drama")

#Now let's do the same for the Studio filter:
filt2 <- (_ == "Buena Vista Studios") | (_ _ "WB") | (_ _ "Fox") _ (_ _ "Universal") _ (_ _ "Sony") _ (_ _ "Paramount Pictures")
  
#Apply the row filters to the dataframe
mov2 <- mov[_ & _,]

#Prepare the plot's data and aes layers
#Note we did not rename the columns. 
#Use str() or summary() to fin out the correct column names
p <- ggplot(data=_, aes(x=_, y=_))
p #Nothing happens. We need a geom.

#Add a Point Geom Layer
p + 
  _()

#Add a boxplot instead of the points
p + 
  _()

#Notice that outliers are part of the boxplot layer
#We will use this observation later (*)

#Add points
p + 
  geom_boxplot() + 
  _()
#Not what we are after

#Replace points with jitter
p + 
  geom_boxplot() + 
  _()

#Place boxplot on top of jitter
p + 
  _() + 
  _() 

#Add boxplot transparency
p + 
  _() + 
  _(_=0.7) 

#Good. Now add size and colour to the points:
p + 
  _(aes(_=Budget...mill., _=Studio)) + 
  _(_=0.7) 
#See the remaining black points? Where are they from?
#They are part of the boxplot - Refer to our observation (*) above 

#Let's remove them:
p + 
  _(aes(_=Budget...mill., _=Studio)) + 
  _(_ = 0.7, outlier.colour = NA) 

#Let's "Save" our progress by placing it into a new object:
q <- p + 
  _(aes(_=Budget...mill., _=Studio)) + 
  _(_ = 0.7, outlier.colour = NA) 
q

#Non-data ink
q <- q +
  _("Genre") + #x axis title
  _("Gross % US") + #y axis title
  _("Domestic Gross % by Genre") #plot title
q

#HINT: for the next part use ?theme if you need to 
#refresh which parameters are responsible for what

#Theme
q <- q + 
  theme(
    #this is a shortcut to alter ALL text elements at once:
    text = element_text(family="Comic Sans MS"),
    
    #Axes titles:
    _ = element_text(colour="Blue", size=30),
    _ = element_text(colour="Blue", size=30),
    
    #Axes texts:
    _ = element_text(size=20),
    _ = element_text(size=20),  
    
    #Plot title:
    _ = element_text(colour="Black",
                              size=40),
    
    #Legend title:
    _ = element_text(size=20),
    
    #Legend text
    _ = element_text(size=12)
  )
q

#Final touch. We haven't discussed this in the course,
#However this is how you can change individual legend titles:
q$labels$size = "Budget $M"
q

#Well done!