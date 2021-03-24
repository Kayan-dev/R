

#integer
x <- 2L
typeof(x)

#double
y <- 2.5
typeof(y)

#integer
x <- 2L
typeof(x)

#double
y <- 2.5
typeof(y)

#double
t <- 3.0
typeof(t)

#complex
z <- 3 + 2i
typeof(z)

#character
a <- "h"
typeof(a)

#logical
q <- T
typeof(q)
q2 <- F
typeof(q2)

#complex
aa <- 5 + 4
typeof(aa)
typeof(z)

A <- 10
B <- 5

C <- A + B
C

#variable 1
var1 <- 2.5
#variable 2
var2 <- 4

result <- var1 / var2
result 

answer <- sqrt(var2)
answer

greeting <- "Hello"
name <- "Bob"
message <- paste(greeting, name)
message
result
answer

#variable 3
var3 <- 70
#variable 4
var4 <- 0.5 
result <- var4 - (var1 + (var2*var3))
result
var2

counter <- 1
while(counter < 12){
  print(counter)
  counter <- counter + 1
}




for (i in 1:5){
  print("hello")
}
1:5

for (i in 5:10){
  print("hello")
}


 aim <- for (i in 55:58){
  i <- i + 1}
aim
# ---- -2 ---- -1 ---- 0 ---- 1 ---- 2 ----


rm(answer)
x <- rnorm(1)
if(x > 1){
  answer <- "Greater than 1"
} else if(x >= -1){
  answer <- "between -1 and 1"
} else{ 
  answer <- "less than -1"
}
answer

