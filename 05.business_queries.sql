-- 1. Which store denerated more revenues across the years?
SELECT 
	store_name AS Store,
    store_city AS city,
	sum(units* product_price) AS Revenues
FROM vw_sales_analysis
GROUP BY 1,2
ORDER BY 3 DESC;

-- 2. Which product generate the highest revenues?
SELECT
	product_name AS product,
    SUM(product_price*units) AS Total_Revenue,
    product_category AS Category
FROM vw_sales_analysis
GROUP BY 1,3
ORDER BY 2 DESC;
    
-- 3. Which product has the highest Gross Profit Margin %
SELECT
	product_name AS Product,
    product_category AS Category,
    SUM(units) AS Total_Units_Sold,
    product_price AS Price,
    ROUND(SUM(units * product_price), 2) AS Total_Revenue,
	ROUND((SUM(units * (product_price - product_cost))/ (SUM(units * product_price))) * 100, 2) AS Gross_Profit_Margin_Percentage
FROM vw_sales_analysis
GROUP BY 1,2,4
ORDER BY 6 DESC;

-- 4. Which city generates the highest revenues?
SELECT
    store_city AS City,
    SUM(units*product_price) AS Total_Revenues
FROM vw_sales_analysis
GROUP BY 1
ORDER BY 2 DESC;    

-- 5. Top-5 store-category revenue combinations
SELECT
	DISTINCT(store_name),
    product_category AS category,
	SUM(units * product_price) AS Total_Revenue
FROM vw_sales_analysis
GROUP BY store_name, product_category
ORDER BY 3 DESC
LIMIT 5;

-- 6. What is the Gross Profit Margin of each store?
SELECT
	store_name AS Store,
    store_city AS City,
	ROUND(SUM(units * product_price), 2) AS Total_Revenue,
	(ROUND((SUM(units * (product_price - product_cost))/ (SUM(units * product_price))) * 100, 2)) AS Gross_Profit_Margin_Percentage
FROM vw_sales_analysis
GROUP BY 1,2
ORDER BY 4 DESC;

-- 7. Which product category produce the highest Gross Profit Margin and which the lowest?
SELECT 
	
    product_category ,
	 Gross_Profit_Margin_Percentage,
    CASE
		WHEN Gross_Profit_Margin_Percentage > 50 then "High Margin"
        WHEN Gross_Profit_Margin_Percentage > 40 then "Mid-High Margin"
        WHEN Gross_Profit_Margin_Percentage > 30 then "Average Margin"
        WHEN Gross_Profit_Margin_Percentage > 20 then "Mid-Low Margin"
        ELSE "Low Margin"
	END AS Gross_Profit_Margin
FROM 
	(SELECT 
	product_category,
    (ROUND((SUM(units * (product_price - product_cost))/ (SUM(units * product_price))) * 100, 2)) AS Gross_Profit_Margin_Percentage 
    FROM vw_sales_analysis
    GROUP BY product_category
    ) as category_margins
ORDER BY 2 DESC;

-- 7.1: Total Revenue per category
SELECT
	product_category AS Category,
    SUM(product_price*units) AS Revenues
FROM vw_sales_analysis
GROUP BY 1
ORDER BY 2 DESC;

-- 8: Which products may need to be reconsidered due to low Gross Profit Margin?
SELECT 
    product_name AS Product ,
    product_category AS Category,
	ROUND(SUM(units * product_price), 2) AS Total_Revenue,
	product_price AS Price,
    SUM(units) AS Units_Sold,
	 (ROUND((SUM(units * (product_price - product_cost))/ (SUM(units * product_price))) * 100, 2)) as Gross_Profit_Margin_Percentage,
    CASE
        WHEN (ROUND((SUM(units * (product_price - product_cost))/ (SUM(units * product_price))) * 100, 2)) > 20 then "Good Margin"
        ELSE "Low Margin"
	END AS Margin_Status
FROM vw_sales_analysis
GROUP BY 1,2,4
ORDER BY 6 DESC;
 
-- 9. Which existing market would be the best candidate for opening a new store based on current sales performance?
SELECT 
	store_city AS City,
	COUNT(DISTINCT store_id) AS Number_Of_Stores,
    ROUND(SUM(units * product_price), 2) AS Total_Revenue,
    SUM(units) AS Units_Sold,
    (ROUND((SUM(units * (product_price - product_cost))/ (SUM(units * product_price))) * 100, 2)) AS Gross_Profit_Margin,
    SUM(product_price-product_cost) AS Profit,
    ROUND(SUM(units * product_price) / COUNT(DISTINCT store_id), 2) AS Revenue_Per_Store,
    ROUND(SUM(product_price-product_cost)/COUNT(DISTINCT store_id),2) AS Profit_Per_Store
FROM vw_sales_analysis
GROUP BY 1
ORDER BY 7 DESC, 8 DESC;

-- 10. Which product categories perform best by month during the available sales period??
SELECT 
    YEAR(date) AS SalesYear,
    MONTH(date) AS SalesMonth,
    product_category AS Category,
    SUM(units) AS Total_Units_Sold,
    ROUND(SUM(units * product_price), 2) AS Total_Revenue
FROM vw_sales_analysis
GROUP BY 1, 2, 3
ORDER BY 1, 2;

-- 11: Which is the highest sales category of each city?
SELECT
	store_city AS City,
	product_category AS Category,
    SUM(units*product_price) AS Total_Revenues
FROM vw_sales_analysis
GROUP BY 2,1;

-- 12. Scenario: We would like to decide where is the best location to open 3 more stores by taking into account the Revenues, the location and the Gross Profit Margin.
SELECT 
	store_location AS Location,
	COUNT(DISTINCT store_id) AS Number_Of_Stores,
    ROUND(SUM(units * product_price), 2) AS Total_Revenue,
    SUM(units) AS Units_Sold,
    (ROUND((SUM(units * (product_price - product_cost))/ (SUM(units * product_price))) * 100, 2)) AS Gross_Profit_Margin,
    ROUND(SUM(units * (product_price - product_cost)), 2) AS Gross_Profit,
    ROUND(SUM(units * product_price) / COUNT(DISTINCT store_id), 2) AS Revenue_Per_Store,
    ROUND(SUM(units * (product_price - product_cost)) / COUNT(DISTINCT store_id), 2) AS Profit_Per_Store
    
FROM vw_sales_analysis
GROUP BY 1
ORDER BY 7 DESC, 8 DESC;




