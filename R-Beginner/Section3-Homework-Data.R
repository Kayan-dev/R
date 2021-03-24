
# Homework solution Financial Statement Analysis

#Two vectors = monthly revenue + expenses
#Assignment;
# Profit of each month
# profit after 30% tax
# profit margin of each month after tax
# Good months = profit after tax higher than mean of year
# Bad months, the opposite
# Best month, max profit after tax
# worst month, min profit after tax

# Present all results in vectors with T or F
# Dollar values precise by the $0.01 but presented in K
# Profit margins presented in %

#Data
revenue <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)

#Solution
expenses
revenue

MonthlyProfit <- revenue - expenses
MonthlyProfit
seq(MonthlyProfit)
z <- print((round((MonthlyProfit/1000),digits=2)))

for(i in z){
  print(i)} # monthly profits shown in K =1k is $1000

for(i in z) {
  if(i <= 0) 
    print(F)
  if(i > 0) 
    print(T)
  } # Monthly profits shown as T or F

# Question 2
TaxProfit <- MonthlyProfit * 0.70
TaxProfit  
y <- print((round((TaxProfit/1000),digits=2))) 
y  
for(i in y){
  print(i)} # monthly profit after tax shown in K =1k is $1000 

for(i in y) {
  if(i <= 0) 
    print(F)
  if(i > 0) 
    print(T)
} # Monthly profits after tax shown as T or F 
  
w <- (TaxProfit/revenue)*100 
w
w2 <-print((round(w,digits=0))) # Monthly profit margin in %

for(i in w2) {
  if(i <= 0) 
    print(F)
  if(i > 0) 
    print(T)
} # Monthly profit margin shown in T or F 

H <- mean(y) # mean of year is 1.67k


for(i in y) {
  if(i > H){ 
    print(T)
  }
  else if(i < H){ 
    print(F)
  }
} #Good months with higher profit after tax shown with T
  # Bad months are shown with F

# Best month of the year

max <- y == max(y) 
BestMonth <- max
BestMonth
max1 <- y[1] == max(y)
max1
names(BestMonth) <- seq(1:12)
BestMonth
?names




Best.month
p <- seq(1:12)
BestMonth <- p + best.month
Best <- best.month + BestMonth[1:12]
Best




# Worst month of the year

min <- y == min(y) 
WorstMonth <- min
names(WorstMonth) <- seq(1:12)
WorstMonth



