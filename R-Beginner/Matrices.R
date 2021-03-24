



Salary
Games
MinutesPlayed


#Matrices
my.data <- 1:20
my.data
A <- matrix(my.data, 4 ,5)
A
A[2,3]

B <- matrix(my.data, 4 ,5)
B
B[2,5]
C <- rbind(my.data,)
C

#rbind
r1 <- c("I", "am", "happy")
r2 <- c("Hello", "Mother", "Fucker")
r3 <- c(1, 2 ,3)
R <- rbind(r1,r2,r3)
R

#cbind

c1 <- c("I", "am", "happy")
c2 <- c("Hello", "Mother", "Fucker")
c3 <- c(1, 2 ,3)
D <- cbind(c1,c2, c3)
D

V <- c(27, 27, 27, 0, 27)
V
colnames(c1) <- c("X", "Y")



#Naming Vectors
charlie <- 1:5
charlie

#give names
names(charlie) <- c("A", "B", "C", "D", "E")
names(charlie)

charlie["D"]

# to clear names

names(charlie) <- 
charlie



#--------------

# naming matrix dimensions 1

temp.vec <- rep( 
  c("a", "B","zZ"), each=3)
temp.vec

Dickhead <- matrix(temp.vec, 3, 3)
Dickhead

Pickhead <- matrix(temp.vec, 3,)
Pickhead


rownames( Pickhead) <- c( "Ah", "OK", "TY")
Pickhead

colnames(Pickhead) <- c("No", "It's", "Dickhead")
Pickhead


Pickhead["OK", "It's"] <- 0
Pickhead

rownames(Pickhead)
colnames(Pickhead)

#Matrix operations

Games
rownames(Games)
colnames(Games)
Games["LeBronJames", "2012"]

FieldGoals

max(FieldGoals)
FieldGoals[max(FieldGoals), drop=F]

DFieldGoals<-round(FieldGoals / Games, 1)
max(DFieldGoals)

DFieldGoals
?NaN
max(rownames(FieldGoals))
max(colnames(FieldGoals))
min(rownames(FieldGoals))

FieldGoals

round(MinutesPlayed / Games)


MinutesPlayed

GoalsvsAttempts <- round(FieldGoals / FieldGoalAttempts, 2)

MinutesvsAttempts <- round(MinutesPlayed / FieldGoalAttempts, 2)

SalaryvsGoals <- round(Salary / FieldGoals, 3)

MinutesPerGoal <- round(MinutesPlayed / FieldGoals, 2)
MinutesPerGoal
GoalsvsAttempts
Morethan50% <-for(i in GoalsvsAttempts) {
  print(i >= 0.50) }


Morethan50 <- matrix(Morethan50%, byrow= 10)

temp.vec <- rep( 
  c("a", "B","zZ"), each=3)
temp.vec

Dickhead <- matrix(temp.vec, 3, 3)
Dickhead


if( GoalsvsAttempts >= 0.50)
  print(GoalsvsAttempts)

MinutesvsAttempts
SalaryvsGoals


#Matplot = designed to plot columns of Matrices


matplot(t(FieldGoals), type= "b", pch = 1:4,8, col=c(1:8,10))
legend( "bottomright", inset=0.001, legend=Players, col=c(1:4,8), pch=1:8,10, horiz = F )
warnings()

matplot(t(MinutesPerGoal), type= "b", pch = 1:8, col=c(1:8))
legend( "bottomright", inset=0.001, legend=Players, col=c(1:8), pch=1:8, horiz = F )
warnings()











