-- Top 10 products by profit
SELECT 
  "Product Name", 
  SUM("Profit") AS Total_Profit, 
  SUM("Sales") AS Total_Sales, 
  ROUND(SUM("Profit") / SUM("Sales") * 100, 1) AS Profit_Margin_pct
FROM Orders
GROUP BY "Product Name"
ORDER BY Total_Profit DESC
LIMIT 10;

-- Monthly sales & order count
SELECT 
  STRFTIME('%Y-%m', "Order Date") AS Month,
  SUM("Sales") AS Monthly_Sales,
  COUNT(DISTINCT "Order ID") AS Order_Count
FROM Orders
GROUP BY Month
ORDER BY Month;

-- Diskon >20% dan profit < 0
SELECT COUNT(DISTINCT "Product Name") AS Loss_Making_Products
FROM Orders
WHERE "Discount" > 0.20 AND "Profit" < 0;