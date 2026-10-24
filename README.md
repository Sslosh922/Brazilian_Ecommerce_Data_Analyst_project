# Brazilian E-Commerce Data Analytics Project

**Author:** Koti Tarun  
**Project Type:** End-to-End Data Analytics Capstone  
**Tools:** Python, PostgreSQL, Power BI, GitHub  
**Domain:** E-Commerce Analytics

## Project Overview

This project analyzes the Brazilian e-commerce dataset from Olist to uncover insights into sales performance, order fulfillment, delivery experience, customer reviews, product categories, and payment behavior.

The project follows an end-to-end analytics workflow, from data cleaning and validation to SQL-based analysis and interactive Power BI dashboards. The objective is to transform raw e-commerce data into meaningful business insights that can support better operational and commercial decisions.

## Business Objectives

- Analyze monthly sales and order trends.
- Monitor order statuses and delivery performance.
- Investigate the relationship between delivery delays and customer satisfaction.
- Identify leading product categories based on Gross Merchandise Value (GMV).
- Understand customer geographic distribution and delivery performance.
- Analyze payment methods, transaction values, and installment patterns.

## Tools and Technologies

| Tool | Purpose |
|---|---|
| Python | Data cleaning, validation, exploratory data analysis, and visualizations |
| Pandas | Data manipulation and aggregation |
| PostgreSQL | Relational data storage and SQL-based business analysis |
| Power BI | Interactive dashboards, data visualization, and DAX measures |
| GitHub | Version control and project documentation |

## Dataset

The project uses the **Brazilian E-Commerce Public Dataset by Olist**, containing information about orders, customers, sellers, products, payments, reviews, and geographic locations.

The dataset includes nine CSV files:

- `olist_customers_dataset.csv`
- `olist_geolocation_dataset.csv`
- `olist_order_items_dataset.csv`
- `olist_order_payments_dataset.csv`
- `olist_order_reviews_dataset.csv`
- `olist_orders_dataset.csv`
- `olist_products_dataset.csv`
- `olist_sellers_dataset.csv`
- `product_category_name_translation.csv`

**Dataset source:** [Brazilian E-Commerce Public Dataset by Olist on Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Project Workflow

### 1. Data Cleaning and Exploratory Analysis — Python

- Loaded and inspected the nine CSV files using Pandas.
- Checked record counts, duplicate identifiers, and missing values.
- Converted relevant columns into appropriate date and time formats.
- Validated relationships between orders, customers, products, sellers, payments, and reviews.
- Standardized product category labels using the available English translation dataset.
- Analyzed monthly GMV, delivery performance, customer review scores, and geographic delivery patterns.

### 2. Database Design and SQL Analysis — PostgreSQL

- Designed relational tables for the Olist datasets.
- Defined primary keys, composite keys, and applicable foreign key relationships.
- Imported the datasets into PostgreSQL.
- Used SQL to explore order trends, product category performance, payment behavior, and delivery-related metrics.

### 3. Interactive Dashboard Development — Power BI

Developed dashboards to present the analysis through KPIs and interactive visualizations.

**Dashboard 1: E-Commerce Overview**
- Total orders
- Total GMV
- Delivered orders
- Cancellation rate
- Average review score
- Monthly GMV trend
- Order status distribution
- Top product categories by GMV
- Customer state-wise order distribution

**Dashboard 2: Delivery & Customer Experience**
- On-time delivery rate
- Late delivery rate
- Average delivery time
- Average review score by delivery result
- Average delivery time by customer state

**Dashboard 3: Payment Analysis**
- Total payment value
- Average payment value
- Total payment transactions
- Payment value by payment type
- Payment method contribution
- Payment value by installment count

## Key Findings

- The dataset contains approximately 99,000 orders and 112,000 order-item records.
- The delivered-order GMV analysis identified November 2017 as the highest-GMV month in the analyzed period.
- Approximately 91.89% of eligible delivered orders arrived on or before their estimated delivery dates, while 8.11% arrived late.
- Orders delivered late had a substantially lower average review score than orders delivered on time or early.
- Health and beauty, watches and gifts, and bed, bath and table were among the leading product categories by GMV in the Power BI analysis.
- Credit cards accounted for the largest share of recorded payment value.

*Note:* Findings are based on the dataset and analysis performed. GMV is calculated using item prices and excludes freight charges. Delivery performance is evaluated only for delivered orders with both actual and estimated delivery dates available. The association between delivery timing and review scores does not, by itself, establish causation.

## Business Recommendations

- Investigate the operational causes of late deliveries in states with high late-delivery rates.
- Monitor delivery performance alongside customer review scores.
- Track monthly GMV and order-status trends to identify significant changes in business performance.
- Review product category performance to inform merchandising and inventory decisions.
- Monitor payment method preferences to better understand customer payment behavior.

## Repository Structure

```text
Brazilian-E-Commerce-Data-Analytics/
│
├── README.md
├── data/
│   └── Dataset instructions and source information
├── notebooks/
│   └── Python exploratory data analysis
├── sql/
│   └── PostgreSQL schema and analysis queries
├── powerbi/
│   └── Power BI dashboard file (.pbix)
└── screenshots/
    └── Dashboard screenshots
```

*The folders above are a suggested structure. Include only folders and files that actually exist in your repository.*

## Skills Demonstrated

- Data cleaning and validation
- Exploratory data analysis
- Python and Pandas
- SQL and relational database design
- PostgreSQL
- Power BI dashboard development
- DAX measures and KPI reporting
- Data visualization
- Business insight generation
- Analytical storytelling

## Conclusion

This project demonstrates an end-to-end approach to e-commerce analytics by combining Python, PostgreSQL, and Power BI. It transforms raw transactional data into measurable business indicators and interactive dashboards that help evaluate sales performance, delivery operations, customer experience, and payment behavior.

## Author

**Koti Tarun**  
B.E. in Artificial Intelligence and Data Science  
Ramaiah Institute of Technology, Bengaluru

GitHub: Add your GitHub profile link here  
LinkedIn: Add your LinkedIn profile link here
