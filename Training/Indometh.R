Elisa <- datasets::DNase
Sleep <- datasets::sleep
Sleep
Women <- datasets::women
Women
Indo <- datasets::Indometh
Indo
Tindo <- t(Indo)
Tindo



head(Indo)
is.data.frame(Indo)
Indo <- as.matrix(Indo)
is.matrix(Indo)
Indo <- as.data.frame(Indo)
head(Indo)
Tindo <- t(Indo)
head(Tindo)
str(Tindo)
summary(Tindo)
Indo$Subject <- factor(Indo$Subject)
Indo$conc <- as.numeric(as.character(Indo$conc))
Indo$time <- as.numeric(as.character(Indo$time))
str(Indo)
rm(Indo)
library(ggplot2)
p <- ggplot(data=Indo, aes(x=time, y=conc, color=Subject,size=0.5, alpha=I(0.75)))

p + geom_line() + geom_point()
p + geom_line() + geom_point() + xlab("Time in hour") + ylab("Concentration mcg/ml") +
  geom_hline(aes(yintercept=TresholdSubject1),colour="Purple") +
  geom_hline(aes(yintercept=TresholdSubject2),colour="Cyan") +
  geom_hline(aes(yintercept=TresholdSubject3),colour="Yellow") +
  geom_hline(aes(yintercept=TresholdSubject4),colour="DarkBlue") +
  geom_hline(aes(yintercept=TresholdSubject5),colour="Blue") +
  geom_hline(aes(yintercept=TresholdSubject6),colour="Green")

    p + geom_line(size=1) + geom_point() + xlab("Time in hour") + ylab("Concentration in mcg/ml") + facet_grid(Subject~.) 


#Histograms
h <- ggplot(data=Indo, aes(x=time, color=Subject))
h + geom_density()
h + geom_density(aes(fill=Subject), alpha=I(0.55))
h + geom_density(aes(fill=Subject), alpha=I(0.55), color="Black")
h + geom_density(aes(fill=Subject), alpha=I(0.55), position = "Stack")
h + geom_density(aes(fill=Subject), alpha=I(0.55), position = "Stack", color="Black") 


l <- ggplot(data=Indo, aes(x=time, y=conc,color=Subject))
l + geom_smooth(fill=NA) + geom_point()
l + geom_smooth(fill=NA) + geom_point() + facet_grid(Subject~.) + 
    geom_hline(aes(yintercept=TresholdSubject1),colour="Red") +
    geom_hline(aes(yintercept=TresholdSubject2),colour="Yellow") +
    geom_hline(aes(yintercept=TresholdSubject3),colour="Green") +
    geom_hline(aes(yintercept=TresholdSubject4),colour="Black") +
    geom_hline(aes(yintercept=TresholdSubject5),colour="Blue") +
    geom_hline(aes(yintercept=TresholdSubject6),colour="Purple")


head(Indo,n=23)

max(Indo[Indo$Subject,"conc"])
Indo$Subject <- factor(Indo$Subject)
str(Indo)
TresholdSubject1 <- (max(Indo[Indo$Subject=="1","conc"])) / 2
TresholdSubject2 <- (max(Indo[Indo$Subject=="2","conc"])) / 2
TresholdSubject3 <- (max(Indo[Indo$Subject=="3","conc"])) / 2
TresholdSubject4 <- (max(Indo[Indo$Subject=="4","conc"])) / 2
TresholdSubject5 <- (max(Indo[Indo$Subject=="5","conc"])) / 2
TresholdSubject6 <- (max(Indo[Indo$Subject=="6","conc"])) / 2

list(TresholdSubject1, TresholdSubject2, TresholdSubject3, TresholdSubject4, TresholdSubject5, TresholdSubject6)
apply(Tindo$Subject, 1, max)

Mindo <- as.matrix(Indo)
Mindo
apply(Mindo$Subject=="1", 1, max)

which.max(Indo$conc)

Indo[Indo,"Subject"]
Indo[Indo$Subject,]
Indo$Subject <- as.numeric(as.character(Indo$Subject))
head(Indo)
Subject1 <- Indo[Indo$Subject=="1",]
Subject2 <- Indo[Indo$Subject=="2",]
Subject3 <- Indo[Indo$Subject=="3",]
Subject4 <- Indo[Indo$Subject=="4",]
Subject5 <- Indo[Indo$Subject=="5",]
Subject6 <- Indo[Indo$Subject=="6",]
Subjects <- list(Subject1=Subject1, Subject2=Subject2, Subject3=Subject3, Subject4=Subject4,Subject5=Subject5,Subject6=Subject6)
Subjects
Tsub <- t(Subjects)
Tsub
MaxPerSubject1 <- apply(Subject1[3], 2, max)
MaxPerSubject2 <- apply(Subject2[3], 2, max)
MaxPerSubject3 <- apply(Subject3[3], 2, max)
MaxPerSubject4 <- apply(Subject4[3], 2, max)
MaxPerSubject5 <- apply(Subject5[3], 2, max)
MaxPerSubject6 <- apply(Subject6[3], 2, max)

MaxPerSubject1
MaxPerSubject2
MaxPerSubject3 
MaxPerSubject4 
MaxPerSubject5 
MaxPerSubject6

MaxSubjects <- list(MaxPerSubject1=MaxPerSubject1, MaxPerSubject2=MaxPerSubject2, MaxPerSubject3=MaxPerSubject3, MaxPerSubject4=MaxPerSubject4,
                 MaxPerSubject5=MaxPerSubject5,MaxPerSubject6=MaxPerSubject6)
MaxSubjects
T2sub <- rbind(Subjects, MaxPerSubject1)
T2sub

Subjects2 <- lapply(seclist, rbind, MaxSubjects)


#seclist <- lapply(Subjects, t)
#seclist
#seclist <- rbind(seclist, NewRow=1)
#seclist
#thirdlist <- rbind(Subjects, NewRow=1)
#thirdlist
#as.matrix(thirdlist)
#thirdlist
#forlist <- Subjects
#forlist <- as.matrix(forlist)
#forlist
