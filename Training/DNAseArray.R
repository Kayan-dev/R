DNA <- datasets::DNase
DNA

library(ggplot2)

str(DNA)
head(DNA)
Dplot <- ggplot(data=DNA, aes(x=conc, y=density, color=Run))
Dplot + geom_point() + geom_smooth()
Yplot <- ggplot(data=DNA, aes(x=conc, color=Run))
Dplot + geom_density()
