

Efe <- 25

BigDick<- Efe

while(BigDick >= 10){
  print(BigDick)
  BigDick <- BigDick - 1
}
i <- 2
i
for (year in 2010:2015) {
  
  print(paste("The year is", year))

}

for (i in 1:10) {
  
  print(paste("The year is", i))
  
}



for (i in 1:10) {
  if (!i %% 2) {
    next
  }
  print(i)
}

for (i in 1:10) {
  if (i %% 2) {
    next
  }
  print(i)
}

x <- 1/2
x
m <- 3/2
m


n <- 100
n


rm(answer)
x <- rnorm(1)
for ( i in 1:10) { 
  if (x > 1){
  answer <- "Greater than 1"
} else if(x < -1){
  answer <- "Less than -1"
} else if (x < 1){
  answer <- "Between 0 and 1"
} else {
  answer <- "Not greater than 1"
} 
print(answer) }



rm(answer)
x <- rnorm(1)
if (x > 1){
  copy <- "Greater than 1"
} else{
  
  if (x >= -1){
    copy <- "Between 1 and -1"
  }
 else {
  copy <- "Less than -1"
 }
}
copy
  
rm(answer)
x <- rnorm(1)
if (x > 1){
  answer <- T
} else if (x >= -1){
  answer <- T
} else {
    answer <- F
  }
answer






