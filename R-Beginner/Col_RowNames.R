#Named Vectors
Charlie <- 1:5
Charlie

#give names
names(Charlie) <- c("a", "b", "c", "d", "e")
Charlie
Charlie["d"]
Charlie[1]
Charlie[4]
Charlie[[4]]
#clear names
names(Charlie) <- NULL
Charlie

#naming Matrix Dimensions 1
temp.vec <- rep(c("a","b","zZ"),3)
# basically means = rep(c("a","b","zZ"),times=3)
temp.vec
# Or;
tempvector <- rep(c("a","b","zZ"), each= 3)
tempvector
rm(Delta)
Bravo <- matrix(temp.vec, 3,3)
Bravo
Delta <- matrix(tempvector, 3,3, byrow = F)
Delta
tempo <- 1:15
Fox <- matrix(tempo,3,5, byrow = T)
Fox


rownames(Bravo) <- c("Big", "Gus","Digus")
Bravo

colnames(Delta) <- c("Ho","lee","Fuk")
Delta
