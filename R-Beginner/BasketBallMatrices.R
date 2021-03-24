



Games
row.names(Games)
colnames(Games)

Games["LeBronJames", "2012"]

FieldGoals

FieldGoals / Games
# or
round(FieldGoals/Games, 1)

FieldGoals
Games
Games["KevinDurant", "2013"]
MinutesPlayed/Games["KevinDurant", "2013"]

A <- round(MinutesPlayed/Games)
B <- round(MinutesPlayed/Games, 1)
A
B
A["KevinDurant", "2013"]
B["KevinDurant", "2013"]

C <- round(FieldGoals/FieldGoalAttempts,2)
C
D <- mean(C[1:10])
D

G <- max(C)
G
E <- 1:5
E
mean(E)

H <- round(FieldGoals/MinutesPlayed,2)
H
H["CarmeloAnthony",1:10]
mean(H["CarmeloAnthony",1:10])

Z <- round(Salary/Points)
Z





    
Baby <- rep(c("I", "Love", "Flora"),3)
Girl <- matrix(Baby,3 ,3)
Girl


rownames(Girl) <- c("Ho", "Lee", "Fuk")
colnames(Girl) <- c("Big", "Gus", "Digus")
ElHefe <- Girl
ElHefe

for (i in 1:10) {
  rnorm()
  
}

SI <- rnorm(10, 0, 1)

for (i in SI){
  if(i > 0)
    print("Flora Smacks El Hefe's Ass")
   if(i < 0)
    print("El Hefe Smacks Booty Girl Flora")
  
}










