-- 1. Add a new column for our A/B test campaign
ALTER TABLE customers ADD COLUMN Campaign VARCHAR(20);

-- 2. Randomly assign customers to Campaign A or B
UPDATE customers 
SET Campaign = CASE WHEN ABS(RANDOM()) % 2 = 0 THEN 'Campaign_A' ELSE 'Campaign_B' END;

-- 3. Standardize Marital_Status
UPDATE customers
SET Marital_Status = CASE
    WHEN Marital_Status IN ('Divorced', 'Widow', 'Alone', 'Single', 'YOLO') THEN 'Single'
    WHEN Marital_Status IN ('Married', 'Together') THEN 'Partner'
    ELSE 'Other'
END;

-- 4. Create Age column first
ALTER TABLE customers ADD COLUMN Age INT;
UPDATE customers
SET Age = (2024 - Year_Birth);

-- 5. Now create Age_Group column using the Age column
ALTER TABLE customers ADD COLUMN Age_Group VARCHAR(20);
UPDATE customers
SET Age_Group = CASE
        WHEN Age < 35 THEN 'Young'
        WHEN Age BETWEEN 35 AND 55 THEN 'Middle-Aged'
        ELSE 'Senior'
    END;

-- 6. Handle NULL Income (replace with overall average instead of median)
UPDATE customers
SET Income = (SELECT AVG(Income) FROM customers WHERE Income IS NOT NULL)
WHERE Income IS NULL;

-- 7. Create Total_Spent column
ALTER TABLE customers ADD COLUMN Total_Spent INT;
UPDATE customers
SET Total_Spent = (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds);