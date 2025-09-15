-- Create a summary table for campaign KPIs
CREATE TABLE IF NOT EXISTS campaign_kpis AS
SELECT
    Campaign,
    COUNT(*) AS Total_Targeted,
    SUM(Response) AS Total_Conversions,
    ROUND((SUM(Response) * 100.0 / COUNT(*)), 2) AS Conversion_Rate_Percent,
    SUM(Total_Spent) AS Total_Revenue,
    AVG(Total_Spent) AS Avg_Revenue_Per_Customer
FROM customers
WHERE Campaign IN ('Campaign_A', 'Campaign_B')
GROUP BY Campaign;