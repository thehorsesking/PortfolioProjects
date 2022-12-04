USE PortfolioProject;

SELECT *
FROM CLA;

/* check null value*/
SELECT *
FROM cla
WHERE country IS NULL;

/*DELETE null values*/
DELETE 
FROM cla
WHERE country IS NUll;

/* Total no of countries in data*/
SELECT COUNT(DISTINCT country) AS no_of_countries
FROM CLA;

/* Country and count of loans in data*/ 
SELECT country
, COUNT(country) AS count_of_loans
FROM CLA
GROUP BY country
ORDER BY 2 DESC;

/* Total no of years in data*/
SELECT COUNT(DISTINCT year) AS no_of_years
FROM CLA;

/* Start and End date of the data*/
SELECT MIN(year) AS start_year
, MAX(year) AS end_year
FROM CLA;

/* Total no of lenders in data*/
SELECT COUNT(DISTINCT lender) AS no_of_lenders
FROM CLA;


/* Distinct lenders with count of loans in data*/ /*find out percentage of this */
SELECT lender
, COUNT(lender) AS count_of_loans
FROM CLA
GROUP BY lender
ORDER BY 2 DESC;

/* Total no of lender types in data*/
SELECT COUNT(DISTINCT lender_type) AS no_of_lender_type
FROM CLA;

/* Distinct lender types with count of loans in data*/ /*find out percentage of this */
SELECT lender_type
, COUNT(lender_type) AS count_of_loans
FROM CLA
GROUP BY lender_type
ORDER BY 2 DESC;

/* total loan given*/
SELECT ROUND(SUM(usd),2) as total_loan_usd_m
FROM cla;

/* Maximum, minimum, avg of all loans*/
SELECT MAX(usd) as maximum_loan
, ROUND(MIN(usd),2) as minimum_loan
, ROUND(AVG(usd),2) as avg_of_all_loans
FROM cla;

/* count, total, maximum, minimum, avg of loans ordered by country*/
SELECT country
, COUNT(USD) AS count_of_loans
, ROUND(SUM(usd),2) as total_loan
, ROUND(MAX(usd),2) as maximum_loan
, ROUND(MIN(usd),2) as minimum_loan
, ROUND(AVG(usd),2) as avg_of_all_loans
, MIN(year) AS start_year
, MAX(year) AS last_year
FROM cla
GROUP BY country
ORDER BY 3 DESC;


/* Total no of purpose in data*/
SELECT COUNT(DISTINCT purpose) AS purpose
FROM CLA;

/* Distinct purpose with count of loans in data*/ /*find out percentage of this */
SELECT purpose
, COUNT(purpose) AS count_of_purpose
FROM CLA
GROUP BY purpose
ORDER BY 2 DESC;

/* Total no of purpose in data*/
SELECT COUNT(DISTINCT sector) AS sector
FROM CLA;

/* Distinct sector with count of loans in data*/ /*find out percentage of this */
SELECT sector
, COUNT(sector) AS count_of_sector
FROM CLA
GROUP BY sector
ORDER BY 2 DESC;

/* count, sum, maximum, minimum, avg of loans ordered by lender*/
SELECT lender
, COUNT(USD) AS count_of_loans
, ROUND(SUM(usd),2) as total_loan
, ROUND(MAX(usd),2) as maximum_loan
, ROUND(MIN(usd),2) as minimum_loan
, ROUND(AVG(usd),2) as avg_of_all_loans
, MIN(year) AS start_year
, MAX(year) AS last_year
FROM cla
GROUP BY lender
ORDER BY 3 DESC;

/* count, sum, maximum, minimum, avg of loans ordered by lender_type*/
SELECT lender_type
, COUNT(USD) AS count_of_loans
, ROUND(SUM(usd),2) as total_loan
, ROUND(MAX(usd),2) as maximum_loan
, ROUND(MIN(usd),2) as minimum_loan
, ROUND(AVG(usd),2) as avg_of_all_loans
, MIN(year) AS start_year
, MAX(year) AS last_year
FROM cla
GROUP BY lender_type
ORDER BY 3 DESC;

/* count, sum, maximum, minimum, avg of loans grouped by pupose, order by total loan*/
SELECT purpose
, COUNT(USD) AS count_of_loans
, ROUND(SUM(usd),2) as total_loan
, ROUND(MAX(usd),2) as maximum_loan
, ROUND(MIN(usd),2) as minimum_loan
, ROUND(AVG(usd),2) as avg_of_all_loans
, MIN(year) AS start_year
, MAX(year) AS last_year
FROM cla
GROUP BY purpose
ORDER BY 3 DESC;

/* count, sum, maximum, minimum, avg of loans grouped by pupose, order by count*/
SELECT purpose
, COUNT(USD) AS count_of_loans
, ROUND(SUM(usd),2) as total_loan
, ROUND(MAX(usd),2) as maximum_loan
, ROUND(MIN(usd),2) as minimum_loan
, ROUND(AVG(usd),2) as avg_of_all_loans
, MIN(year) AS start_year
, MAX(year) AS last_year
FROM cla
GROUP BY purpose
ORDER BY 2 DESC;