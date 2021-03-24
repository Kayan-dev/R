
N <- 100 #input
counter <- 0
for(i in rnorm(N)){
  if (i > -1 & i < 1){
    counter <- counter + 1
    
answer <- (counter/N)*100
answer
  }
}


N <- 1000 #input
counter <- 0
for(i in rnorm(N)){
if (i > -1 & i < 1){
  i <- T
  if(i<-T){
    counter <- counter+1
}
answer <- (counter/N)*100
answer
 } 
}

#compare answer (given in %) to 68.2%
















