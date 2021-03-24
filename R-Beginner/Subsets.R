# Subsetting

x <- c("a", "b", "c", "d", "e")
x
x[c(1,5)]
x[1]
x[5]



x[c(2,4)]
Games
Games[1:3,6:10]
Games[c(1,10),]
Games[c(1,10),6:10]
Games[,c("2008","2009")]
Games[1,,drop=F]
is.matrix(Games[1,])
is.vector(Games[1,])

Games[1,5, drop=F]
is.vector(Games[1,5])

# Visualizing Subsets

Data <- MinutesPlayed[1,]
Data

matplot((Data), type= "b", pch = 1, col=c(1))
legend("bottomright", inset=0.001, legend=Players[1], col=c(1), pch=1, horiz = F )



# second way= let op de t() en drop=F

Data <- MinutesPlayed[2,, drop=F]
matplot(t(Data), type= "b", pch = 1, col=c(1))
legend("bottomright", inset=0.001, legend=Players[2], col=c(1), pch=1, horiz = F )




# matplot(t(MinutesPerGoal), type= "b", pch = 1:8, col=c(1:8))
#legend( "bottomright", inset=0.001, legend=Players, col=c(1:8), pch=1:8, horiz = F )
# warnings()


# CREATING OWN FUNCTION

SubsetPlot <- function(pagga,rows=1:10, Color=7:11, SYM){
  Data <- pagga[rows,, drop=F]
  matplot(t(Data), type= "b", pch = SYM, col=c(Color))
  legend("bottomright", inset=0.001, legend=Players[rows], col=c(Color), pch=SYM, horiz = F )
}

SubsetPlot(Points/Games, 3, SYM= 13:16)
#or ; SubsetPlot(Points, rows=1:5, Color= 3:8, SYM= 13:16) 
# WITHOUT default settings










