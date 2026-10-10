/*
PROJECT: Telecom Customer Churn Analysis
FILE: 03_powerbi_dataset.sql
PURPOSE: Create the analytical dataset consumed by Power BI.

SOURCE TABLE: public.customers
OUTPUT VIEW: public.vw_churn_powerbi

This script creates derived fields for reporting, including:

* Tenure bands and sort order
* Monthly charge bands and sort order
* A numeric churn flag for Power BI measures

The original customer table is not modified.
*/

CREATE OR REPLACE VIEW public.vw_churn_powerbi AS
SELECT
customerid AS customer_id,
gender,
seniorcitizen AS senior_citizen,
partner,
dependents,
-- Tenure and tenure bands
tenure,
CASE
    WHEN tenure BETWEEN 0 AND 12 THEN '0 - 12 months'
    WHEN tenure BETWEEN 13 AND 24 THEN '13 - 24 months'
    WHEN tenure BETWEEN 25 AND 36 THEN '25 - 36 months'
    WHEN tenure BETWEEN 37 AND 48 THEN '37 - 48 months'
    WHEN tenure BETWEEN 49 AND 60 THEN '49 - 60 months'
    WHEN tenure BETWEEN 61 AND 72 THEN '61 - 72 months'
    ELSE 'Other / check'
END AS tenure_band,

CASE
    WHEN tenure BETWEEN 0 AND 12 THEN 1
    WHEN tenure BETWEEN 13 AND 24 THEN 2
    WHEN tenure BETWEEN 25 AND 36 THEN 3
    WHEN tenure BETWEEN 37 AND 48 THEN 4
    WHEN tenure BETWEEN 49 AND 60 THEN 5
    WHEN tenure BETWEEN 61 AND 72 THEN 6
    ELSE 7
END AS tenure_band_sort,

-- Phone services
phoneservice AS phone_service,
multiplelines AS multiple_lines,

-- Internet and add-on services
internetservice AS internet_service,
onlinesecurity AS online_security,
onlinebackup AS online_backup,
deviceprotection AS device_protection,
techsupport AS tech_support,
streamingtv AS streaming_tv,
streamingmovies AS streaming_movies,

-- Contract and billing
contract,
paperlessbilling AS paperless_billing,
paymentmethod AS payment_method,

-- Monthly charges and charge bands
monthlycharges AS monthly_charges,
CASE
    WHEN monthlycharges < 35 THEN 'Under 35'
    WHEN monthlycharges < 55 THEN '35 - 54.99'
    WHEN monthlycharges < 75 THEN '55 - 74.99'
    WHEN monthlycharges < 95 THEN '75 - 94.99'
    WHEN monthlycharges >= 95 THEN '95 and above'
    ELSE 'Unknown'
END AS monthly_charge_band,

CASE
    WHEN monthlycharges < 35 THEN 1
    WHEN monthlycharges < 55 THEN 2
    WHEN monthlycharges < 75 THEN 3
    WHEN monthlycharges < 95 THEN 4
    WHEN monthlycharges >= 95 THEN 5
    ELSE 6
END AS monthly_charge_band_sort,

totalcharges AS total_charges,

-- Churn outcome and numeric flag
churn,
CASE
    WHEN churn = 'Yes' THEN 1
    ELSE 0
END AS churn_flag

FROM public.customers;

/* ============================================================
VALIDATION CHECKS
Run these after creating or replacing the view.
============================================================ */

-- 1. Confirm total rows and churn totals
SELECT
COUNT(*) AS total_customers,
SUM(churn_flag) AS churned_customers,
COUNT(*) - SUM(churn_flag) AS retained_customers,
ROUND(AVG(churn_flag::NUMERIC) * 100, 2) AS churn_rate_pct
FROM public.vw_churn_powerbi;

-- 2. Check the tenure bands
SELECT
tenure_band,
tenure_band_sort,
COUNT(*) AS total_customers
FROM public.vw_churn_powerbi
GROUP BY tenure_band, tenure_band_sort
ORDER BY tenure_band_sort;

-- 3. Check the monthly charge bands
SELECT
monthly_charge_band,
monthly_charge_band_sort,
COUNT(*) AS total_customers
FROM public.vw_churn_powerbi
GROUP BY monthly_charge_band, monthly_charge_band_sort
ORDER BY monthly_charge_band_sort;

-- 4. Check for duplicate customer IDs in the view
SELECT
customer_id,
COUNT(*) AS occurrences
FROM public.vw_churn_powerbi
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 5. Inspect the final dataset structure
SELECT *
FROM public.vw_churn_powerbi
LIMIT 10;

/* ============================================================
END OF POWER BI DATASET SCRIPT
============================================================ */
