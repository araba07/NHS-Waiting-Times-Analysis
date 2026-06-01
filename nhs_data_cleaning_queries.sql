USE nhs_waiting_list;
SELECT * FROM nhs_waiting_data LIMIT 10;
DESCRIBE nhs_waiting_data;

/*-- PART 1: DATABASE STRUCTURE & BUG FIXES --*/

/* Modifying table to remove encoding mistake in month column name */
ALTER TABLE nhs_waiting_data
CHANGE COLUMN `ï»¿Month` `Month` text;

DESCRIBE nhs_waiting_data;

/*-- PART 2: INITIAL DATA ANALYSIS --*/

/* Find months where total patients waiting is less than 5 million */
SELECT `Month`
FROM nhs_waiting_data
WHERE `Total Waiting (mil)` < 5;

/* Show the worst 3 performing months for hitting NHS's within 18 weeks target*/
SELECT `Month` , `% within 18 weeks`
FROM nhs_waiting_data
ORDER BY `% within 18 weeks` ASC
LIMIT 3;

/* Query 3: Look at only results that have more than 6 million total waiting and show the worst out of them */
SELECT `Month` , `% within 18 weeks` , `Total Waiting (mil)`
FROM nhs_waiting_data
WHERE `Total waiting (mil)` > 6
ORDER BY `% within 18 weeks`ASC
LIMIT 1;

/*-- PART 3: DATA CLEANING, TYPE CONVERSION & AGGREGATION --*/

/* DATA CLEANING & TYPE CONVERSION: `% within 18 weeks`
   The column was originally imported as a TEXT data type because it contained literal 
   '%' symbols. This prevented any mathematical calculations (like AVG, MIN, MAX). */
SELECT 
CAST(REPLACE (`% within 18 weeks`, '%', '') AS DECIMAL(5 , 2)) AS `% within 18 weeks`
FROM nhs_waiting_data;

/* What is the overall average percentage of patients seen within 18 weeks across this entire dataset? */
SELECT
AVG (CAST(REPLACE (`% within 18 weeks`, '%', '') AS DECIMAL(5 , 2))) AS `% within 18 weeks`
FROM nhs_waiting_data;

/* Find the highest performance month in this dataset */
SELECT
`Month`, (CAST(REPLACE (`% within 18 weeks`, '%', '') AS DECIMAL(5 , 2))) AS `% within 18 weeks`
FROM nhs_waiting_data
ORDER BY `% within 18 weeks`DESC
LIMIT 1;

/* Find the lowest performance month in this dataset */
SELECT
`Month`, (CAST(REPLACE (`% within 18 weeks`, '%', '') AS DECIMAL(5 , 2))) AS `% within 18 weeks`
FROM nhs_waiting_data
ORDER BY `% within 18 weeks`ASC
LIMIT 1;

/* How many total months in the dataset actually dropped below that 92% baseline */
SELECT 
`Month`, CAST(REPLACE (`% within 18 weeks`, '%', '') AS DECIMAL(5 , 2)) AS `% within 18 weeks`
FROM nhs_waiting_data
WHERE CAST(REPLACE (`% within 18 weeks`, '%', '') AS DECIMAL(5 , 2)) < 92;
