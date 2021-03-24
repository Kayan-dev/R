Games
Games[1:3, 6:10]
Games[6:10, 1:3]
Games[c(1,10),4:10]
Games[,c("2008","2014")]
Games[1,]

is.matrix(Games[1,])
is.vector(Games[1,])

Games[1,5]
is.vector(Games[1,5])
Games[1,5,drop=F]
is.vector(Games[1,5,drop=F])

