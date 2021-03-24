
Vector <- c(3 ,45, 56, 732)
Vector
is.numeric(Vector)
is.integer(Vector)
is.double(Vector)

V2 <- c(3L, 12L, 243L, 0L)
V2
is.numeric(V2)
is.integer(V2)
is.double(V2)

V3 <- c("A", "B", "C", "D")
V3
is.character(V3)
is.numeric(V3)





seq() #sequence - Like '1:15'
rep() #replicate 

seq(1,15)
1:15

z <- seq(1,15,3)
z

rep(3, 50)
d <- rep(3, 10)
d
rep("A", 10)
x <- c(80,20)
x
y <- rep(x,30)
y
o <- y + d
o
z + rep(d) -> k
k


q <- c(0000,123,534,13,4) #combine
q

y <- seq(-500,20,1)   #sequence
y

z <- rep("Hey Hey", 5) #replicate
z


w <- c("a", "b", "c", "d", "e")
w

w[2] #access to numeric numer of the vector of w
w[-1]
w[-3]
w[+1]
w[1+2]
w[1&2]
w[1:2]
w[3:5]
w[1:2:4]
h <- w[-3]
h
w[c(1,5,4)]
w[c(-2,-4)]
-3:-5
w[-3:-5]



# Vectorized Operation

function(d)
function


x <- rnorm(10)
x

# R specific programming loop
for(i in x){
  print(i)
}

print(x[1])
print(x[2])
print(x[3])
print(x[4])
print(x[5])

#conventional programming loop
for(j in 1:10){
print(x[j])
}

#--------------- 2nd Part of vectorized operations

N <- 10

a <- rnorm(N)
b <- rnorm(N)
a
b
#Vectorized Approach
c <- a * b
c
#De-vectorized Approach

d <- rep(NA,N)
d
for(i in 1:N){
  d[i] <- a[i] * b[i]
}














