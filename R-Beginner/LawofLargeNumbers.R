


# Law of Large Numbers


rnorm(1)
 
n = 100

count if n falls between -1 and 1
divide count by total of n
it should be close to E(X) 68.2% theoritical chance

Mean(Xn) -> E(X) 



for (i in rnorm(100)){
rm(answer)
x <- rnorm(1)
if (x > 1){
  answer <- F
} else if  (x < -1 ){
  answer <- F
} else {
  answer <- T
}}  while(answer <- T) print(paste("Between -1 and 1"))
}

for (i in rnorm(100)){
print(paste(i))
  rm(answer)
  i <- rnorm(1)
  if (i > 1){
    answer <- F
  } else if  (i < -1 ){
    answer <- F
  } else {
    answer <- T
  } 
}

N <- 100
counter <- rm(N)
for(i in rnorm(N)){
  if (i <= 1 & i >= -1){
    counter <- T+1
  }
}
answer <- (counter/N)*100
answer

N <- 100
for(i in rnorm(100))








  
rm(answer)
x <- rnorm(1)
if (x > 1){
  answer <- T
} else if (x >= -1){
  answer <- T
} else {
  answer <- F
}


  rm(answer)
  x <- rnorm(1)
  if (x > -1){
    answer <- "Greater than 1"
  } else if (x <= 1){
    answer <- "Between 1 and -1"
  } 










