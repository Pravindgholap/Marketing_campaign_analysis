-- Create a summary table for cohort analysis
CREATE TABLE IF NOT EXISTS cohort_analysis AS
SELECT
    Campaign,
    Age_Group,
    Marital_Status,
    COUNT(*) AS Total_Customers,
    SUM(Response) AS Conversions,
    ROUND((SUM(Response) * 100.0 / COUNT(*)), 2) AS Conversion_Rate,
    AVG(Total_Spent) AS Avg_Spend
FROM customers
GROUP BY Campaign, Age_Group, Marital_Status;