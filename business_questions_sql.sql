-- =====================================================================
-- ApexPlanet Data Analytics Internship — Task 2
-- SQL for Business Questions
-- Database: apexplanet_sales.db  (SQLite)
-- Tables  : orders (fact, 1000 rows) | customers (dimension, 947 rows)
-- Note    : dataset covers 2025-01-01 through 2026-01-01. "Last 6 months"
--           is interpreted relative to the latest order date in the data
--           (2026-01-01), i.e. 2025-07-01 through 2026-01-01.
-- =====================================================================


-- ---------------------------------------------------------------------
-- Q1. What are the top 5 products by revenue in the last 6 months?
-- (filtering + aggregation)
-- ---------------------------------------------------------------------
SELECT
    Product,
    Category,
    COUNT(*)                    AS Orders,
    SUM(Total_Sales)            AS Total_Revenue,
    ROUND(AVG(Total_Sales), 2)  AS Avg_Order_Value
FROM orders
WHERE Order_Date >= '2025-07-01'
GROUP BY Product, Category
ORDER BY Total_Revenue DESC
LIMIT 5;


-- ---------------------------------------------------------------------
-- Q2. What is the monthly revenue trend across the dataset?
-- (aggregation, chronological trend)
-- ---------------------------------------------------------------------
SELECT
    Order_Month,
    COUNT(*)                   AS Orders,
    SUM(Total_Sales)           AS Total_Revenue,
    ROUND(AVG(Total_Sales), 2) AS Avg_Order_Value
FROM orders
GROUP BY Order_Month
ORDER BY Order_Month;


-- ---------------------------------------------------------------------
-- Q3. Which cities generate the highest total revenue, and what is the
--     average order value in each?
-- (aggregation, ranking)
-- ---------------------------------------------------------------------
SELECT
    City,
    COUNT(*)                   AS Orders,
    SUM(Total_Sales)           AS Total_Revenue,
    ROUND(AVG(Total_Sales), 2) AS Avg_Order_Value
FROM orders o
JOIN customers c ON c.Customer_ID = o.Customer_ID
GROUP BY City
ORDER BY Total_Revenue DESC;


-- ---------------------------------------------------------------------
-- Q4. How does revenue break down by customer age group and product
--     category? (which age group drives which category)
-- (multi-table JOIN + two-dimensional aggregation)
-- ---------------------------------------------------------------------
SELECT
    c.Age_Group,
    o.Category,
    COUNT(*)                   AS Orders,
    SUM(o.Total_Sales)         AS Total_Revenue,
    ROUND(AVG(o.Total_Sales), 2) AS Avg_Order_Value
FROM orders o
JOIN customers c ON c.Customer_ID = o.Customer_ID
GROUP BY c.Age_Group, o.Category
ORDER BY c.Age_Group, Total_Revenue DESC;


-- ---------------------------------------------------------------------
-- Q5. What is the gender-wise split of orders, revenue, and average
--     order value?
-- (multi-table JOIN + aggregation)
-- ---------------------------------------------------------------------
SELECT
    c.Gender,
    COUNT(*)                     AS Orders,
    SUM(o.Total_Sales)           AS Total_Revenue,
    ROUND(AVG(o.Total_Sales), 2) AS Avg_Order_Value,
    ROUND(100.0 * SUM(o.Total_Sales) /
          (SELECT SUM(Total_Sales) FROM orders), 2) AS Pct_Of_Total_Revenue
FROM orders o
JOIN customers c ON c.Customer_ID = o.Customer_ID
GROUP BY c.Gender;


-- ---------------------------------------------------------------------
-- Q6. Which day of the week has the highest average order value, and
--     does order volume follow the same pattern?
-- (aggregation, ranking)
-- ---------------------------------------------------------------------
SELECT
    Order_Weekday,
    COUNT(*)                    AS Orders,
    SUM(Total_Sales)            AS Total_Revenue,
    ROUND(AVG(Total_Sales), 2)  AS Avg_Order_Value
FROM orders
GROUP BY Order_Weekday
ORDER BY Avg_Order_Value DESC;


-- ---------------------------------------------------------------------
-- Q7. What is the month-over-month revenue growth rate?
-- (window function — LAG — for period-over-period comparison)
-- ---------------------------------------------------------------------
WITH monthly AS (
    SELECT Order_Month, SUM(Total_Sales) AS Revenue
    FROM orders
    GROUP BY Order_Month
)
SELECT
    Order_Month,
    Revenue,
    LAG(Revenue) OVER (ORDER BY Order_Month) AS Prev_Month_Revenue,
    ROUND(
        100.0 * (Revenue - LAG(Revenue) OVER (ORDER BY Order_Month))
        / LAG(Revenue) OVER (ORDER BY Order_Month), 2
    ) AS MoM_Growth_Pct
FROM monthly
ORDER BY Order_Month;
