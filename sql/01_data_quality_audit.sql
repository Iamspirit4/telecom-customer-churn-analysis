
/*
Project: Telecom Customer Churn Analysis
Database: telco_churn
Source table: public.customers

Purpose:
Document the data quality checks performed before analysis.

Checks include:
1. Dataset size
2. Duplicate customer IDs
3. Missing values
4. Categorical value validation
5. Numeric range checks
6. Overall churn distribution

This script is read-only. It does not modify the source data.
*/


-- =========================================================
-- 1. DATASET SIZE
-- Expected: 7,043 customer records
-- =========================================================

SELECT
    COUNT(*) AS total_records
FROM public.customers;


-- =========================================================
-- 2. UNIQUE CUSTOMER IDs
-- Expected: 7,043 distinct customer IDs
-- =========================================================

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT customerid) AS distinct_customer_ids,
    COUNT(*) - COUNT(DISTINCT customerid) AS duplicate_id_difference
FROM public.customers;


-- Identify any duplicated customer IDs.
-- Expected: zero rows returned.

SELECT
    customerid,
    COUNT(*) AS occurrences
FROM public.customers
GROUP BY customerid
HAVING COUNT(*) > 1
ORDER BY occurrences DESC, customerid;


-- =========================================================
-- 3. MISSING VALUES
-- =========================================================

SELECT
    COUNT(*) AS total_records,

    COUNT(*) FILTER (
        WHERE customerid IS NULL
    ) AS missing_customerid,

    COUNT(*) FILTER (
        WHERE gender IS NULL
    ) AS missing_gender,

    COUNT(*) FILTER (
        WHERE seniorcitizen IS NULL
    ) AS missing_seniorcitizen,

    COUNT(*) FILTER (
        WHERE tenure IS NULL
    ) AS missing_tenure,

    COUNT(*) FILTER (
        WHERE monthlycharges IS NULL
    ) AS missing_monthlycharges,

    COUNT(*) FILTER (
        WHERE totalcharges IS NULL
    ) AS missing_totalcharges,

    COUNT(*) FILTER (
        WHERE churn IS NULL
    ) AS missing_churn

FROM public.customers;


-- Inspect records with missing TotalCharges.
-- Expected: 11 records, based on the completed data checks.
-- NULL values are preserved rather than replaced with guesses.

SELECT
    customerid,
    tenure,
    monthlycharges,
    totalcharges,
    churn
FROM public.customers
WHERE totalcharges IS NULL
ORDER BY customerid;


-- =========================================================
-- 4. CATEGORICAL VALUE VALIDATION
-- Inspect the distinct values in important categorical fields.
-- Unexpected values can then be investigated.
-- =========================================================

SELECT DISTINCT gender
FROM public.customers
ORDER BY gender;

SELECT DISTINCT churn
FROM public.customers
ORDER BY churn;

SELECT DISTINCT contract
FROM public.customers
ORDER BY contract;

SELECT DISTINCT internetservice
FROM public.customers
ORDER BY internetservice;

SELECT DISTINCT paymentmethod
FROM public.customers
ORDER BY paymentmethod;

SELECT DISTINCT paperlessbilling
FROM public.customers
ORDER BY paperlessbilling;

SELECT DISTINCT partner
FROM public.customers
ORDER BY partner;

SELECT DISTINCT dependents
FROM public.customers
ORDER BY dependents;


-- =========================================================
-- 5. NUMERIC RANGE CHECKS
-- Review minimum, maximum, and average values.
-- =========================================================

SELECT
    MIN(tenure) AS minimum_tenure,
    MAX(tenure) AS maximum_tenure,
    AVG(tenure)::NUMERIC(10,2) AS average_tenure,

    MIN(monthlycharges) AS minimum_monthly_charges,
    MAX(monthlycharges) AS maximum_monthly_charges,
    AVG(monthlycharges)::NUMERIC(10,2) AS average_monthly_charges,

    MIN(totalcharges) AS minimum_total_charges,
    MAX(totalcharges) AS maximum_total_charges,
    AVG(totalcharges)::NUMERIC(10,2) AS average_total_charges

FROM public.customers;


-- =========================================================
-- 6. SENIOR CITIZEN VALUE VALIDATION
-- Expected values: 0 and 1
-- =========================================================

SELECT
    seniorcitizen,
    COUNT(*) AS customer_count
FROM public.customers
GROUP BY seniorcitizen
ORDER BY seniorcitizen;


-- =========================================================
-- 7. OVERALL CHURN DISTRIBUTION
-- Expected:
-- Total customers: 7,043
-- Churned: 1,869
-- Retained: 5,174
-- Churn rate: approximately 26.54%
-- =========================================================

SELECT
    churn,
    COUNT(*) AS customer_count,
    ROUND(
        COUNT(*) * 100.0
        / NULLIF(SUM(COUNT(*)) OVER (), 0),
        2
    ) AS percentage_of_customers
FROM public.customers
GROUP BY churn
ORDER BY churn;


-- =========================================================
-- END OF DATA QUALITY AUDIT
-- =========================================================