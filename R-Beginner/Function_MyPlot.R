
myplot <- function(){
  Data <- Salary[2:3,,drop=F]
  matplot(t(Data), type="b", pch = 10:20, col=c(1:6))
  legend("bottomleft", inset=0.01, legend=Players[2:3], col=c(1:6), pch=10:20, horiz=F)
}

myplot()

#specify parameters = function(input,rows)
myplot <- function(input,rows){
Data <- input[rows,,drop=F]
matplot(t(Data), type="b", pch = 10:20, col=c(1:6))
legend("bottomleft", inset=0.01, legend=Players[rows], col=c(1:6), pch=10:20, horiz=F)
}

myplot(Salary, 1:4)

#default parameters (rows=1:10)
myplot <- function(input,rows=1:10){
  Data <- input[rows,,drop=F]
  matplot(t(Data), type="b", pch = 10:20, col=c(1:6))
  legend("bottomleft", inset=0.01, legend=Players[rows], col=c(1:6), pch=10:20, horiz=F)
}

myplot(Salary)
