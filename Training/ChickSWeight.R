getwd()
setwd("/home/hefe/R/Datasets")
getwd()

library(help="datasets") 
rm(Indometh)
Indo <- data("Indometh")
head(Indo)
Indo

Chick <- datasets::ChickWeight
head(Chick)
tail(Chick)
str(Chick)
is.data.frame(Chick)
summary(Chick)

library(ggplot2)

#Increase in weight from all diets in one plot
ch <- ggplot(data=Chick, aes(x=Time, y=weight, color=Diet))
OnePlot <- ch + geom_jitter() + geom_smooth() + xlab("Time in Days") + ylab("Weight in Grams") +
  ggtitle("Chicks Weight Increase For All Diet") +
  theme(axis.title.x = element_text(colour="DarkRed", size=15),
        axis.title.y = element_text(colour="DarkRed", size=15),
        axis.text.y = element_text(size=10),
        axis.text.x = element_text(size=10),
        panel.grid.major.x = element_line(color="Black"),
        panel.grid.major.y = element_line(color="Black"),
        legend.title = element_text(size=20),
        legend.text =  element_text(size=15),
      #  legend.position = c(1,1),
        legend.justification = c(1,0.5),
        plot.title = element_text(colour = "DarkRed",
                                  size=20, family = "Courier"))
OnePlot
# Increase in weight from all diets in seperated plots
cr <- ggplot(data=Chick, aes(x=weight, y=Time, color=Diet))
MultiPlot <- cr +  geom_point() + geom_smooth() + facet_grid(Diet~.) + xlab("Weight in Grams") + ylab("Time in Days") +
  ggtitle("Chicks Weight Increase Per Diet") +
  theme(axis.title.x = element_text(colour="DarkRed", size=15),
        axis.title.y = element_text(colour="DarkRed", size=15),
        axis.text.y = element_text(size=10),
        axis.text.x = element_text(size=10),
        # panel.grid.major.x = element_line(color="Black"),
        # panel.grid.major.y = element_line(color="Black"),
        legend.title = element_text(size=10),
        legend.text =  element_text(size=11),
        #  legend.position = c(1,1),
        legend.justification = c(1,0.5),
        plot.title = element_text(colour = "DarkRed",
                                  size=20, family = "Courier"))
MultiPlot

#Isolate Diets from data frame
Diet1 <- Chick[Chick$Diet=="1",]
Diet2 <- Chick[Chick$Diet=="2",]
Diet3 <- Chick[Chick$Diet=="3",]
Diet4 <- Chick[Chick$Diet=="4",]

#Max weight per diet
maxd1 <- max(Diet1$weight)
maxd2 <- max(Diet2$weight)
maxd3 <- max(Diet3$weight)
maxd4 <- max(Diet4$weight)

MaxChickWeight <- list("MaxDiet1"=maxd1, "MaxDiet2"=maxd2, "MaxDiet3"=maxd3, "MaxDiet4"=maxd4)
MaxChickWeight


#Mean weight per diet
meand1 <- mean(Diet1$weight)
meand2 <- mean(Diet2$weight)
meand3 <- mean(Diet3$weight)
meand4 <- mean(Diet4$weight)

MeanChickWeight <- list("MeanDiet1"=meand1, "MeanDiet2"=meand2, "MeanDiet3"=meand3, "MeanDiet4"=meand4)
MeanChickWeight

#List of Mean and Max weight
FinalList<- rbind(MeanChickWeight, MaxChickWeight)
FinalList
colnames(FinalList) <- c("Diet1", "Diet2", "Diet3", "Diet4")
#List of Plots
PlotList <- list(OnePlot, MultiPlot)
PlotList[[1]]
PlotList[[2]]
