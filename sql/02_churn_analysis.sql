/*
PROJECT: Telecom Customer Churn Analysis
FILE: 02_churn_analysis.sql
PURPOSE: Analyse churn patterns and identify customer segments
that may benefit from targeted retention strategies.

SOURCE TABLE: public.customers
DATABASE: telco_churn

All queries are read-only. Percentages are rounded to 2 decimal places.
*/

/* ============================================================

1. OVERALL CHURN PERFORMANCE
   Business question: What proportion of customers have churned?
   ============================================================ */

SELECT
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
COUNT(*) FILTER (WHERE churn = 'No') AS retained_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM public.customers;

/* ============================================================
2. CHURN BY CONTRACT TYPE
Business question: Which contract type has the highest churn?
============================================================ */

/* 2. Churn by contract type */
WITH contract_summary AS (
SELECT
contract,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers
FROM public.customers
GROUP BY contract
)
SELECT
contract,
total_customers,
churned_customers,
ROUND(
churned_customers * 100.0 / NULLIF(total_customers, 0),
2
) AS churn_rate_pct,
ROUND(
churned_customers * 100.0
/ NULLIF(SUM(churned_customers) OVER (), 0),
2
) AS share_of_all_churners_pct
FROM contract_summary
ORDER BY churn_rate_pct DESC;

/* ============================================================
3. CHURN BY TENURE BAND
Business question: At what stage of the customer relationship
is churn most common?
============================================================ */

WITH tenure_groups AS (
SELECT
CASE
WHEN tenure BETWEEN 0 AND 12 THEN '0-12 months'
WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
WHEN tenure BETWEEN 25 AND 36 THEN '25-36 months'
WHEN tenure BETWEEN 37 AND 48 THEN '37-48 months'
WHEN tenure BETWEEN 49 AND 60 THEN '49-60 months'
WHEN tenure BETWEEN 61 AND 72 THEN '61-72 months'
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
churn
FROM public.customers
)
SELECT
tenure_band,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM tenure_groups
GROUP BY tenure_band, tenure_band_sort
ORDER BY tenure_band_sort;

/* ============================================================
4. CHURN BY DEMOGRAPHICS
Business question: How does churn vary across customer groups?
============================================================ */

-- 4a. Gender
SELECT
gender,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM public.customers
GROUP BY gender
ORDER BY churn_rate_pct DESC;

-- 4b. Senior citizen status
SELECT
seniorcitizen,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM public.customers
GROUP BY seniorcitizen
ORDER BY seniorcitizen DESC;

-- 4c. Partner status
SELECT
partner,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM public.customers
GROUP BY partner
ORDER BY churn_rate_pct DESC;

-- 4d. Dependents
SELECT
dependents,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM public.customers
GROUP BY dependents
ORDER BY churn_rate_pct DESC;

/* ============================================================
5. CHURN BY INTERNET AND ADD-ON SERVICES
Business question: Which service groups have higher churn?
============================================================ */

-- 5a. Internet service
-- 5a. Internet service
WITH internet_summary AS (
SELECT
internetservice AS internet_service,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers
FROM public.customers
GROUP BY internetservice
)
SELECT
internet_service,
total_customers,
churned_customers,
ROUND(
churned_customers * 100.0
/ NULLIF(total_customers, 0),
2
) AS churn_rate_pct,
ROUND(
churned_customers * 100.0
/ NULLIF(SUM(churned_customers) OVER (), 0),
2
) AS share_of_all_churners_pct
FROM internet_summary
ORDER BY churn_rate_pct DESC;


-- 5b. Online security
SELECT
onlinesecurity AS online_security,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM public.customers
GROUP BY onlinesecurity
ORDER BY churn_rate_pct DESC;

-- 5c. Tech support
SELECT
techsupport AS tech_support,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM public.customers
GROUP BY techsupport
ORDER BY churn_rate_pct DESC;

/* ============================================================
6. CHURN BY BILLING AND PAYMENT
Business question: Are billing preferences associated with
different churn rates?
============================================================ */

-- 6a. Payment method
WITH payment_summary AS (
SELECT
paymentmethod AS payment_method,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers
FROM public.customers
GROUP BY paymentmethod
)
SELECT
payment_method,
total_customers,
churned_customers,
ROUND(
churned_customers * 100.0 / NULLIF(total_customers, 0),
2
) AS churn_rate_pct,
ROUND(
churned_customers * 100.0
/ NULLIF(SUM(churned_customers) OVER (), 0),
2
) AS share_of_all_churners_pct
FROM payment_summary
ORDER BY churn_rate_pct DESC;


-- 6b. Paperless billing
SELECT
paperlessbilling AS paperless_billing,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM public.customers
GROUP BY paperlessbilling
ORDER BY churn_rate_pct DESC;

/* ============================================================
7. CHURN BY MONTHLY CHARGE BAND
Business question: How does churn vary by monthly charge level?
============================================================ */

WITH charge_groups AS (
SELECT
CASE
WHEN monthlycharges < 35 THEN 'Under 35'
WHEN monthlycharges < 55 THEN '35-54.99'
WHEN monthlycharges < 75 THEN '55-74.99'
WHEN monthlycharges < 95 THEN '75-94.99'
ELSE '95+'
END AS monthly_charge_band,
CASE
WHEN monthlycharges < 35 THEN 1
WHEN monthlycharges < 55 THEN 2
WHEN monthlycharges < 75 THEN 3
WHEN monthlycharges < 95 THEN 4
ELSE 5
END AS band_sort,
churn
FROM public.customers
WHERE monthlycharges IS NOT NULL
)
SELECT
monthly_charge_band,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM charge_groups
GROUP BY monthly_charge_band, band_sort
ORDER BY band_sort;

/* ============================================================
8. CONTRACT TYPE × INTERNET SERVICE
Business question: Does internet service help explain churn
within each contract group?
============================================================ */

SELECT
contract,
internetservice AS internet_service,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM public.customers
GROUP BY contract, internetservice
ORDER BY contract, churn_rate_pct DESC;

/* ============================================================
9. CONTRACT TYPE × PAYMENT METHOD
Business question: How does payment method relate to churn
within each contract group?
============================================================ */

SELECT
contract,
paymentmethod AS payment_method,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM public.customers
GROUP BY contract, paymentmethod
ORDER BY contract, churn_rate_pct DESC;

/* ============================================================
10. HIGH-RISK CUSTOMER PROFILE
Business question: Which combination of contract, tenure,
internet service and payment method contributes most to churn?
============================================================ */

WITH customer_profiles AS (
SELECT
contract,
CASE
WHEN tenure BETWEEN 0 AND 12 THEN '0-12 months'
WHEN tenure BETWEEN 13 AND 24 THEN '13-24 months'
WHEN tenure BETWEEN 25 AND 36 THEN '25-36 months'
WHEN tenure BETWEEN 37 AND 48 THEN '37-48 months'
WHEN tenure BETWEEN 49 AND 60 THEN '49-60 months'
WHEN tenure BETWEEN 61 AND 72 THEN '61-72 months'
ELSE 'Other / check'
END AS tenure_band,
internetservice AS internet_service,
paymentmethod AS payment_method,
churn
FROM public.customers
),
profile_summary AS (
SELECT
contract,
tenure_band,
internet_service,
payment_method,
COUNT(*) AS total_customers,
COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
ROUND(
COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
/ NULLIF(COUNT(*), 0),
2
) AS churn_rate_pct
FROM customer_profiles
GROUP BY
contract,
tenure_band,
internet_service,
payment_method
)
SELECT
contract,
tenure_band,
internet_service,
payment_method,
total_customers,
churned_customers,
churn_rate_pct,
ROUND(
churned_customers * 100.0
/ NULLIF(SUM(churned_customers) OVER (), 0),
2
) AS share_of_churners_in_profile_results_pct
FROM profile_summary
ORDER BY churned_customers DESC, churn_rate_pct DESC;

/* ============================================================
11. AVERAGE CHARGES: CHURNED VS RETAINED
Business question: How do average monthly and total charges
differ between churned and retained customers?

Note: TotalCharges averages exclude NULL values automatically.
These are descriptive comparisons, not proof of causation.
============================================================ */

SELECT
churn,
COUNT(*) AS total_customers,
ROUND(AVG(monthlycharges), 2) AS avg_monthly_charges,
ROUND(AVG(totalcharges), 2) AS avg_total_charges
FROM public.customers
GROUP BY churn
ORDER BY churn;

/* ============================================================
END OF CHURN ANALYSIS
============================================================ */
