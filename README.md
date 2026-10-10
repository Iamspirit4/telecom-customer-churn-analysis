# Telecom Customer Churn Analysis

## Project Overview

This project analyses customer churn for a telecommunications company to identify customer segments with elevated churn rates and uncover patterns that may inform customer retention strategies.

Using SQL and Power BI, I explored how churn varies across contract types, customer tenure, internet services, payment methods, billing preferences, and customer demographics. I also examined combinations of customer attributes to identify high-risk segments.

## Business Problem

Customer churn can reduce recurring revenue and increase the cost of acquiring replacement customers. Understanding which customer segments are more likely to leave can help a business prioritise retention efforts.

The objective of this project was to answer three key questions:

- What proportion of customers have churned?
- Which customer segments have the highest churn rates?
- Which combinations of customer characteristics identify particularly high-risk segments?

## Tools and Technologies

- **PostgreSQL:** Data validation, transformation, aggregation, and segmentation.
- **Power BI:** Interactive dashboards, data visualisation, and KPI reporting.
- **DAX:** Measures for customer counts and churn rate.
- **Excel:** Initial data inspection and quality checks.

## Dataset

The project uses the IBM Telco Customer Churn dataset, containing 7,043 customer records and 21 original columns.

The dataset includes customer demographics, account information, services, billing attributes, tenure, and churn status.

## Methodology

### 1. Data validation and preparation

- Checked the dataset structure and record count.
- Checked customer IDs for duplicates.
- Investigated missing values in `TotalCharges`.
- Validated categorical values and numeric fields.
- Created an analytical SQL view for Power BI.
- Derived tenure and monthly charge bands to support segmentation.

Missing `TotalCharges` values were preserved as NULL rather than replaced with assumed values.

### 2. Exploratory analysis with SQL

Analysed churn across contract type, tenure, internet service, payment method, senior-citizen status, paperless billing, partner status, dependents, and monthly charge bands.

Further analysis examined combinations of contract type, tenure, internet service, and payment method to identify high-risk customer profiles.

### 3. Interactive reporting with Power BI

Built a two-page report featuring KPI cards, churn comparisons, segment analysis, and interactive slicers for contract type, tenure, and internet service. Slicers were synchronised across both pages to support consistent filtering.

## Key Findings

### Overall churn

- Total customers: **7,043**
- Churned customers: **1,869**
- Overall churn rate: **26.54%**

### Contract type

Month-to-month customers had a churn rate of **42.71%**, compared with **11.27%** for one-year contracts and **2.83%** for two-year contracts.

Month-to-month customers accounted for **88.55% of all churned customers**, making this an important segment for further retention analysis.

### Customer tenure

Customers in their first 12 months had a churn rate of **47.44%**, the highest among the tenure bands analysed. Churn rates generally declined across longer-tenure groups.

### Internet service

Customers using fiber-optic internet had a churn rate of **41.89%**, compared with **18.96%** for DSL customers and **7.40%** for customers without internet service.

### Payment method

Customers paying by electronic check had a churn rate of **45.29%**, compared with 15.24% to 19.11% across the other payment methods.

### High-risk customer segment

A four-variable segmentation identified a notable group consisting of customers with month-to-month contracts, tenure of 0–12 months, fiber-optic internet, and electronic-check payments.

- Customers in the segment: **631**
- Churned customers: **449**
- Segment churn rate: **71.16%**
- Share of all churned customers: **24.02%**

This segment combines several characteristics associated with elevated churn and may warrant further investigation.

## Business Recommendations

Based on the observed patterns, the following actions could be investigated:

1. **Prioritise early-tenure retention:** Evaluate onboarding support and early customer engagement for customers in their first year.
2. **Review month-to-month retention strategies:** Investigate service concerns and assess whether suitable longer-term plans could improve retention.
3. **Investigate fiber-optic customer experience:** Examine satisfaction, service reliability, pricing, and support outcomes among fiber customers.
4. **Review electronic-check payment patterns:** Determine whether payment friction or other customer characteristics help explain the higher observed churn rate.
5. **Use targeted retention analysis:** Evaluate interventions for high-risk segments and measure their effectiveness before scaling them.

These recommendations are hypotheses for further investigation, not proof that any individual attribute causes churn.

## Dashboard Preview

The Power BI report contains two pages:

### Customer Churn Overview

![Customer Churn Overview](Page%201.png)

This page presents the overall churn KPIs and compares churn rates across customer segments. Interactive slicers allow users to explore contract type, tenure, and internet service.

### Customer Churn Drivers

![Customer Churn Drivers](Page%202.png)

This page explores payment methods, billing preferences, customer demographics, monthly charges, and combined customer segments to identify patterns associated with elevated churn.

## Limitations

- The analysis is descriptive and identifies associations rather than causal relationships.
- The results reflect the supplied dataset and may not represent current customer behaviour.
- High churn rates in a segment do not, on their own, explain why those customers left.
- Recommendations should be validated with further investigation and measured retention experiments.

## Conclusion

This project demonstrates an end-to-end analytical workflow using Excel, PostgreSQL, and Power BI. It combines data validation, SQL-based segmentation, KPI development, and interactive reporting to turn customer data into actionable retention insights.

The analysis highlights the importance of contract type, early tenure, internet service, and payment method when investigating customer churn.

## Detailed Analysis

For a more detailed breakdown of the SQL analysis, segment comparisons, and findings, see [insights.md](insights.md).
