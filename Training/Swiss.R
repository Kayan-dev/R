
swiss
head(swiss)
str(swiss)

Tswiss <- lapply(swiss, t)
Tswiss

library(ggplot2)

p <- ggplot(data=swiss, aes(x=Agriculture, y=Catholic))
p + geom_point()
is.data.frame(swiss)
swi <- as.matrix(swiss)
swi
str(swi)
head(swi)
str(swiss)

x <- matrix(1:6, 2, 3)
x

for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
    
  }
}

library(plyr)
z <- 5
cointoss <- while(z >= 3 && z <= 10) {
  print(z)
  coin <- rbinom(1,1,0.5)
  if(coin == 1) {
    z <- z+1
    } else {
      z <- z -1
    }
  }
  as.data.frame(table(cointoss))

  
for (i in 1:100) {
  if( i <= 20) {
    next
  }
     return(i == 55)
   }

add2 <- function(x, y){
  x + y
}
  
above10 <- function(x) {
  use <- x > 10
  x[use]
}  
  
x <- 8  
above10(x)  

above <- function(x, n = 10) {
  use <- x > n
  x[use]
}  
 

mydata <- rnorm(100) 
sd(mydata)  
sd( (x <- 1) + mydata)  
sd(x + mydata)  

f <- function(a ,b) {
  a^2
  b^2
}  
f  
f  
f(2)  
f(1)  
f(3)  
f(4)  
f(4,2)  
f(2,0)  
f(a=2,b=4)  

g <- function(c, d){
  print(c)
  print(d)
  }
g(45)  
g(45,23)  
  







