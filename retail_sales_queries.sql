CREATE DATABASE retail_sales_db;
USE retail_sales_db;

USE retail_sales_db;

-- 1. Check total rows and preview the imported data
SELECT COUNT(*) AS Total_Orders FROM cleaned_superstore;
SELECT * FROM cleaned_superstore LIMIT 10;

-- 2. Overall Business KPIs (Total Sales, Total Profit, Profit Margin %)
SELECT 
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Pct
FROM cleaned_superstore;

-- 3. Region-wise Sales and Profit Performance
SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM cleaned_superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

-- 4. Top 5 Most Profitable Sub-Categories
SELECT 
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM cleaned_superstore
GROUP BY `Sub-Category`
ORDER BY Total_Profit DESC
LIMIT 5;

-- 5. Top 5 Loss-Making Sub-Categories (Important for HR/Business Interview)
SELECT 
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM cleaned_superstore
GROUP BY `Sub-Category`
ORDER BY Total_Profit ASC
LIMIT 5;

-- 6. Customer Segment-wise Performance
SELECT 
    Segment,
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM cleaned_superstore
GROUP BY Segment
ORDER BY Total_Profit DESC;

-- 7. Impact of Discount on Profit using CASE WHEN
SELECT 
    CASE 
        WHEN Discount = 0 THEN 'No Discount (0%)'
        WHEN Discount <= 0.2 THEN 'Low Discount (1% - 20%)'
        ELSE 'High Discount (> 20%)'
    END AS Discount_Bracket,
    COUNT(*) AS Order_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM cleaned_superstore
GROUP BY Discount_Bracket
ORDER BY Total_Profit DESC;

-- 8. Year-over-Year (YoY) Sales and Profit Trend
SELECT 
    Order_Year,
    ROUND(SUM(Sales), 2) AS Yearly_Sales,
    ROUND(SUM(Profit), 2) AS Yearly_Profit
FROM cleaned_superstore
GROUP BY Order_Year
ORDER BY Order_Year ASC;
