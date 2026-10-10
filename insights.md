# Telecom Customer Churn Analysis: Detailed Findings and Business Insights

## 1. Executive Summary

This project investigates customer churn in a telecommunications dataset containing 7,043 customer records. Using Excel for initial data inspection, PostgreSQL for data preparation and analysis, and Power BI for interactive reporting, the analysis identifies customer characteristics and combinations of attributes associated with elevated churn.

The dataset contains 1,869 churned customers, giving an overall churn rate of 26.54%.

The strongest patterns observed were:

- Month-to-month customers had a churn rate of 42.71%, substantially higher than customers on longer-term contracts.
- Customers in their first 12 months had the highest tenure-based churn rate, at 47.44%.
- Fiber-optic customers had a churn rate of 41.89%.
- Customers paying by electronic check had a churn rate of 45.29%.
- A combined segment of first-year, month-to-month, fiber-optic customers paying by electronic check had a churn rate of 71.16%.

These results identify customer groups that merit further investigation and targeted retention analysis. They describe associations in the available data and do not establish that any particular attribute causes churn.

## 2. Business Questions

The analysis was designed to answer the following questions:

1. What is the overall customer churn rate?
2. Which contract types have the highest churn rates and contribute the most churned customers?
3. How does churn vary with customer tenure?
4. How do internet service and payment methods relate to churn?
5. Are billing preferences, demographics, or monthly charges associated with different churn rates?
6. Which combinations of customer attributes identify high-risk segments?
7. What actions could the business investigate to improve retention?

## 3. Dataset and Preparation

### Dataset overview

The IBM Telco Customer Churn dataset contains 7,043 customer records and 21 original columns.

The fields describe customer demographics, account characteristics, subscribed services, billing arrangements, tenure, and churn status.

### Data quality checks

The preparation process included:

- Confirming the row count and dataset structure.
- Checking customer IDs for duplicates.
- Investigating missing values in `TotalCharges`.
- Validating numeric fields and categorical values.
- Checking the range of tenure and monthly charges.
- Preparing an analysis-ready SQL view for Power BI.

Eleven records contained missing `TotalCharges` values. These were preserved as NULL rather than replaced with assumed amounts.

The analytical view includes derived tenure and monthly-charge bands, sort fields for chronological and numerical ordering, and a numeric churn flag for reporting.

### Analytical approach

Churn rates were compared across individual customer attributes and combinations of attributes. Segment sizes and churned-customer counts were considered alongside percentages to avoid drawing conclusions from rates alone.

Power BI was used to present the findings in two interactive report pages, with synchronised slicers for contract type, tenure, and internet service.

## 4. Overall Churn

| Metric             | Result |
| ------------------ | -----: |
| Total customers    |  7,043 |
| Churned customers  |  1,869 |
| Retained customers |  5,174 |
| Overall churn rate | 26.54% |

Approximately one in four customers in the dataset had churned.

This provides the baseline against which segment-level churn rates can be compared. A segment with a churn rate above 26.54% has an elevated observed rate relative to the overall customer population, although the difference alone does not explain why customers left.

## 5. Contract Type Analysis

| Contract type  | Customers | Churned | Churn rate |
| -------------- | --------: | ------: | ---------: |
| Month-to-month |     3,875 |   1,655 |     42.71% |
| One year       |     1,473 |     166 |     11.27% |
| Two year       |     1,695 |      48 |      2.83% |

### Key findings

Month-to-month customers had a churn rate of 42.71%, compared with 11.27% for one-year contracts and 2.83% for two-year contracts.

Month-to-month customers represented approximately 55.0% of the customer base but accounted for 88.55% of all churned customers.

The churn rate for month-to-month customers was approximately 15 times the rate observed among two-year contract customers.

### Business interpretation

Contract type is one of the clearest segmentation variables in this analysis. The difference may reflect variation in commitment, customer circumstances, service satisfaction, or other characteristics associated with contract choice.

The data does not establish which explanation is responsible.

### Recommendation

Investigate the reasons for churn among month-to-month customers. Evaluate whether improved onboarding, service recovery, customer engagement, or suitable longer-term plan options could improve retention without creating unnecessary friction for customers.

## 6. Customer Tenure Analysis

| Tenure band  | Customers | Churned | Churn rate |
| ------------ | --------: | ------: | ---------: |
| 0–12 months  |     2,186 |   1,037 |     47.44% |
| 13–24 months |     1,024 |     294 |     28.71% |
| 25–36 months |       832 |     180 |     21.63% |
| 37–48 months |       762 |     145 |     19.03% |
| 49–60 months |       832 |     120 |     14.42% |
| 61–72 months |     1,407 |      93 |      6.61% |

### Key findings

The first-year tenure group had the highest churn rate at 47.44%. Churn rates generally declined across the longer-tenure bands, reaching 6.61% among customers with 61–72 months of tenure.

The first-year group alone accounted for approximately 55.5% of all churned customers.

### Business interpretation

Early customer tenure is a major retention concern in this dataset. Customers may be more likely to leave before establishing a lasting relationship with the service provider.

Possible explanations include unmet expectations, onboarding difficulties, pricing concerns, service quality, or a mismatch between the service and customer needs. These explanations require further investigation.

### Recommendation

Evaluate retention initiatives during the first 12 months. Track early customer complaints, service issues, payment problems, and customer feedback to understand which experiences are associated with departures.

## 7. Internet Service Analysis

| Internet service    | Customers | Churned | Churn rate |
| ------------------- | --------: | ------: | ---------: |
| Fiber optic         |     3,096 |   1,297 |     41.89% |
| DSL                 |     2,421 |     459 |     18.96% |
| No internet service |     1,526 |     113 |      7.40% |

### Key findings

Fiber-optic customers had a churn rate of 41.89%, more than twice the rate among DSL customers.

Fiber-optic customers accounted for 69.40% of all churned customers despite representing 43.96% of the customer base.

### Business interpretation

Fiber-optic customers represent an important segment for retention investigation. The observed difference could be associated with pricing, customer expectations, service quality, customer composition, or other factors not isolated by this descriptive analysis.

The higher rate should not be interpreted as proof that fiber-optic service itself causes churn.

### Recommendation

Examine fiber-optic customer feedback, service reliability, pricing, support contacts, and contract arrangements. Compare the experience of fiber customers who churn with that of fiber customers who remain.

## 8. Payment Method Analysis

| Payment method            | Customers | Churned | Churn rate |
| ------------------------- | --------: | ------: | ---------: |
| Electronic check          |     2,365 |   1,071 |     45.29% |
| Mailed check              |     1,612 |     308 |     19.11% |
| Bank transfer (automatic) |     1,544 |     258 |     16.71% |
| Credit card (automatic)   |     1,522 |     232 |     15.24% |

### Key findings

Electronic-check customers had the highest observed churn rate at 45.29%. They accounted for 57.30% of all churned customers.

Customers using automatic bank transfers and automatic credit-card payments had substantially lower observed churn rates.

### Business interpretation

Payment method may be associated with differences in customer behaviour or customer characteristics. The data does not establish whether payment friction, payment reliability, or other factors explain the observed differences.

### Recommendation

Investigate whether payment-related issues, failed transactions, billing complaints, or customer preferences differ across payment groups. Any initiative to encourage alternative payment methods should be evaluated rather than assumed to reduce churn.

## 9. Monthly Charges Analysis

| Monthly charge band | Customers | Churned | Churn rate |
| ------------------- | --------: | ------: | ---------: |
| Under 35            |     1,731 |     188 |     10.86% |
| 35–54.99            |       889 |     246 |     27.67% |
| 55–74.99            |     1,295 |     351 |     27.10% |
| 75–94.99            |     1,820 |     662 |     36.37% |
| 95 and above        |     1,308 |     422 |     32.26% |

### Key findings

The highest churn rate was observed among customers paying 75–94.99 per month, at 36.37%. Customers in the 95-and-above band had a churn rate of 32.26%.

The lowest monthly-charge band had a churn rate of 10.86%.

The relationship was not strictly increasing across every band, so the findings do not support a simple conclusion that churn always rises as monthly charges increase.

### Business interpretation

Monthly charges may be related to service combinations, contract type, customer expectations, or affordability. The elevated rates in the higher charge bands justify further investigation, but price alone cannot be identified as the cause.

### Recommendation

Compare monthly charges alongside contract type, internet service, tenure, and customer feedback. Investigate whether customers with high bills experience lower perceived value or other service issues before proposing pricing changes.

## 10. Customer Demographics and Household Characteristics

### Senior-citizen status

| Group          | Customers | Churned | Churn rate |
| -------------- | --------: | ------: | ---------: |
| Senior citizen |     1,142 |     476 |     41.68% |
| Non-senior     |     5,901 |   1,393 |     23.61% |

The senior-citizen group had a higher observed churn rate than the non-senior group. This identifies a difference worth understanding, not an explanation for individual customer behaviour.

### Partner status

| Partner status | Customers | Churned | Churn rate |
| -------------- | --------: | ------: | ---------: |
| No             |     3,641 |   1,200 |     32.96% |
| Yes            |     3,402 |     669 |     19.66% |

Customers without a recorded partner had a higher observed churn rate.

### Dependents

| Dependents | Customers | Churned | Churn rate |
| ---------- | --------: | ------: | ---------: |
| No         |     4,933 |   1,543 |     31.28% |
| Yes        |     2,110 |     326 |     15.45% |

Customers without dependents had a higher observed churn rate.

### Business interpretation

These patterns may reflect differences in customer circumstances, service requirements, tenure, or contract choice. The analysis does not establish that household status itself drives churn.

### Recommendation

Use these characteristics as contextual variables when investigating customer segments, rather than treating them as direct causes or making unsupported assumptions about individual customers.

## 11. Paperless Billing

| Paperless billing | Customers | Churned | Churn rate |
| ----------------- | --------: | ------: | ---------: |
| Yes               |     4,171 |   1,400 |     33.57% |
| No                |     2,872 |     469 |     16.33% |

Customers using paperless billing had a higher observed churn rate than customers not using it.

This difference may be associated with other characteristics, including contract type, service combinations, or customer preferences. The analysis does not establish a causal relationship between paperless billing and churn.

A useful next step would be to compare paperless-billing groups within the same contract and tenure categories.

## 12. Combined Segment Analysis

Individual comparisons are useful, but customer characteristics can overlap. Cross-segmentation helps identify combinations associated with particularly high churn rates.

### Contract type and internet service

| Contract type  | Internet service | Customers | Churned | Churn rate |
| -------------- | ---------------- | --------: | ------: | ---------: |
| Month-to-month | Fiber optic      |     2,128 |   1,162 |     54.60% |
| Month-to-month | DSL              |     1,223 |     394 |     32.22% |
| Month-to-month | No internet      |       524 |      99 |     18.89% |
| One year       | Fiber optic      |       539 |     104 |     19.29% |
| One year       | DSL              |       570 |      53 |      9.30% |
| One year       | No internet      |       364 |       9 |      2.47% |
| Two year       | Fiber optic      |       429 |      31 |      7.23% |
| Two year       | DSL              |       628 |      12 |      1.91% |
| Two year       | No internet      |       638 |       5 |      0.78% |

_Rates in this table are calculated from the displayed counts and rounded to two decimal places._

The highest churn rate in this comparison occurred among month-to-month fiber-optic customers, at approximately 54.60%.

The same internet service category had substantially lower churn rates among customers on longer-term contracts. This suggests that contract type and internet service should be investigated together rather than interpreted only in isolation.

### Contract type and payment method

| Contract type  | Payment method   | Customers | Churned | Churn rate |
| -------------- | ---------------- | --------: | ------: | ---------: |
| Month-to-month | Electronic check |     1,850 |     994 |     53.73% |
| Month-to-month | Bank transfer    |       589 |     201 |     34.13% |
| Month-to-month | Credit card      |       543 |     178 |     32.78% |
| Month-to-month | Mailed check     |       893 |     282 |     31.58% |
| One year       | Electronic check |       347 |      64 |     18.44% |
| One year       | Credit card      |       398 |      41 |     10.30% |
| One year       | Bank transfer    |       391 |      38 |      9.72% |
| One year       | Mailed check     |       337 |      23 |      6.82% |
| Two year       | Electronic check |       168 |      13 |      7.74% |
| Two year       | Bank transfer    |       564 |      19 |      3.37% |
| Two year       | Credit card      |       581 |      13 |      2.24% |
| Two year       | Mailed check     |       382 |       3 |      0.79% |

The month-to-month and electronic-check combination had a churn rate of 53.73%, making it a high-priority segment for further investigation.

Electronic-check customers also had higher observed churn rates within the one-year and two-year contract groups. However, the differences between payment methods do not establish that the payment method itself causes churn.

## 13. High-Risk Customer Profiles

A more detailed segmentation combined four variables:

- Contract type
- Tenure band
- Internet service
- Payment method

### Largest contributing high-risk profile

The segment consisting of month-to-month customers in their first 12 months, using fiber-optic internet and paying by electronic check produced the following results:

| Metric                         | Result |
| ------------------------------ | -----: |
| Customers in segment           |    631 |
| Churned customers              |    449 |
| Segment churn rate             | 71.16% |
| Share of all churned customers | 24.02% |

This is a particularly important finding because the segment combines a high churn rate with a meaningful number of customers and a substantial contribution to overall churn.

It is not simply a small group with an extreme percentage: nearly one-quarter of all churned customers belonged to this profile.

Another smaller segment, consisting of first-year month-to-month fiber-optic customers using bank transfer, contained 87 customers, of whom 71 churned. Its churn rate was 81.61%.

The latter segment had a higher churn rate but a much smaller customer count. This illustrates why segment size and churn contribution should be considered alongside churn rate.

### Business interpretation

The results suggest that early tenure, month-to-month contracts, fiber-optic service, and electronic-check payment deserve particular attention when prioritising retention investigations.

These profiles are descriptive findings. Further analysis would be required to determine which factors are independently associated with churn and which interventions would be effective.

## 14. Monthly Charges and Total Charges by Churn Status

The average monthly charges were approximately:

| Customer status | Average monthly charges |
| --------------- | ----------------------: |
| Churned         |                   74.44 |
| Retained        |                   61.27 |

Churned customers had higher average monthly charges in this dataset.

Average total charges showed the opposite pattern:

| Customer status | Average total charges |
| --------------- | --------------------: |
| Churned         |              1,531.80 |
| Retained        |              2,555.34 |

This is consistent with the possibility that retained customers have accumulated more charges because they have remained customers for longer. Total charges reflect cumulative billing, so they should not be interpreted as a direct measure of customer value without accounting for tenure and other relevant factors.

### Recommendation

Compare customer value using tenure-adjusted measures, such as average monthly revenue and revenue over a consistent observation period. Investigate whether high monthly charges coincide with particular service combinations, shorter tenure, or elevated churn.

## 15. Prioritised Business Recommendations

### Priority 1: Investigate early-tenure churn

The first-year group had a churn rate of 47.44% and accounted for approximately 55.5% of all churned customers.

Review onboarding, early service experience, support interactions, and customer feedback to identify preventable causes of early departure.

### Priority 2: Investigate month-to-month customers

Month-to-month customers accounted for 88.55% of all churned customers.

Assess their reasons for leaving and evaluate suitable retention options. Any longer-term plan offer should be tested for customer suitability and commercial effectiveness.

### Priority 3: Investigate high-risk fiber-optic segments

Fiber-optic customers had a churn rate of 41.89%, while month-to-month fiber-optic customers had a rate of approximately 54.60%.

Investigate pricing, service quality, support, and expectations within these groups, taking contract type and tenure into account.

### Priority 4: Review payment-related patterns

Electronic-check customers had a churn rate of 45.29%. Determine whether billing concerns, payment difficulties, customer characteristics, or other factors are associated with this pattern.

### Priority 5: Measure retention interventions

Use the identified segments to formulate testable retention hypotheses. Evaluate any intervention using clearly defined outcomes, such as subsequent churn, customer experience, and financial impact.

The business should validate interventions through measurement rather than assuming that an observed association guarantees an improvement.

## 16. Limitations and Further Analysis

This analysis has several limitations:

- The dataset is observational. The results show associations and do not establish causation.
- The findings reflect the supplied dataset and may not generalise to other companies, periods, or customer populations.
- Several customer characteristics overlap, so individual segment comparisons may be influenced by other variables.
- The analysis does not establish why a customer left or whether a particular retention intervention would have prevented churn.
- Total charges are cumulative and are influenced by customer tenure.
- No causal model or predictive model was developed as part of this descriptive project.

Potential extensions include multivariable statistical analysis, churn prediction, customer lifetime value estimation, and controlled evaluation of retention strategies.

## 17. Conclusion

The analysis identified clear differences in churn across contract type, tenure, internet service, payment method, and other customer characteristics.

The strongest findings concern month-to-month customers, customers in their first year, fiber-optic customers, and electronic-check users. Combining these attributes identified a high-risk segment with a 71.16% churn rate that accounted for 24.02% of all churned customers.

The project demonstrates an end-to-end analytical workflow spanning data validation, SQL analysis, customer segmentation, KPI development, and interactive Power BI reporting.

Most importantly, it translates descriptive findings into specific questions that a business can investigate to improve customer retention.
