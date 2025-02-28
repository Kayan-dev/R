#Data
revenue <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)

#Solution
#Calculate Profit As The Differences Between Revenue And Expenses
profit <- _ - _
profit

#Calculate Tax As 30% Of Profit And Round To 2 Decimal Points
tax <- round(0.30 * _, _)
tax 

#Calculate Profit Remaining After Tax Is Deducted
profit.after.tax <- _ - _
profit.after.tax

#Calculate The Profit Margin As Profit After Tax Over Revenue
#Round To 2 Decimal Points, Then Multiply By 100 To Get %
profit.margin <- _(_ / _, 2) * _
profit.margin

#Calculate The Mean Profit After Tax For The 12 Months
mean_pat <- _(profit.after.tax)
mean_pat

#Find The Months With Above-Mean Profit After Tax
good.months <- _ _ mean_pat
good.months

#Bad Months Are The Opposite Of Good Months !
bad.months <- _good.months
bad.months

#The Best Month Is Where Profit After Tax Was Equal To The Maximum
best.month <- profit.after.tax == _(profit.after.tax)
best.month

#The Worst Month Is Where Profit After Tax Was Equal To The Minimum
worst.month <- _ == _(_)
worst.month

#Convert All Calculations To Units Of One Thousand Dollars
revenue.1000 <- round(revenue / 1000, 0)
revenue.1000
expenses.1000 <- _(_ _ _, _)
profit.1000 <- _(_ _ _, _)
profit.after.tax.1000 <- _(_ _ _, _)

#Print Results
revenue.1000
expenses.1000
profit.1000
profit.after.tax.1000
profit.margin
good.months
bad.months
best.month
worst.month

#BONUS:
#Preview Of What's Coming In The Next Section
M <- rbind(
  revenue.1000,
  expenses.1000,
  profit.1000,
  profit.after.tax.1000,
  profit.margin,
  good.months,
  bad.months,
  best.month,
  worst.month
)

#Print The Matrix
_

