# Olist E-Commerce Analytics — Data Model

**Author:** Koti Tarun  
**Database:** PostgreSQL  
**Project:** Brazilian E-Commerce Analytics

## 1. Overview

This project uses nine CSV datasets from the Brazilian Olist E-Commerce dataset. The tables cover customers, orders, products, sellers, payments, reviews, product categories, and geographical information.

The data model supports business analysis of sales performance, delivery operations, customer satisfaction, regional performance, and payment behaviour.

## 2. Database Tables

| Table | Purpose | Primary Key |
|---|---|---|
| `customers` | Customer location and identifiers | `customer_id` |
| `orders` | Order status and timestamps | `order_id` |
| `order_items` | Products purchased within each order, seller, price, and freight | `(order_id, order_item_id)` |
| `products` | Product attributes and category | `product_id` |
| `sellers` | Seller identifiers and locations | `seller_id` |
| `order_payments` | Payment methods, instalments, and payment values | `(order_id, payment_sequential)` |
| `order_reviews` | Review scores and customer comments | No primary key defined |
| `product_category_translation` | Original product categories and English translations | `product_category_name` |
| `geolocation` | Geographic coordinates and postal-code information | No primary key defined |

## 3. Table Relationships

The following relationships connect the main business entities:

- `customers.customer_id` → `orders.customer_id` (one-to-many)
- `orders.order_id` → `order_items.order_id` (one-to-many)
- `products.product_id` → `order_items.product_id` (one-to-many)
- `sellers.seller_id` → `order_items.seller_id` (one-to-many)
- `orders.order_id` → `order_payments.order_id` (one-to-many)
- `orders.order_id` → `order_reviews.order_id` (one-to-many)
- `product_category_translation.product_category_name` → `products.product_category_name` (one-to-many, where category values match)

The `geolocation` table is maintained separately because postal-code prefixes are repeated and cannot safely serve as unique identifiers.

## 4. Data Cleaning and Modelling Decisions

### Date and timestamp fields
Order purchase, approval, shipping, delivery, and estimated-delivery fields are treated as date/time values for time-series and delivery analysis.

### Product categories
The category translation dataset does not provide English translations for every original category. Untranslated values are retained instead of inventing translations.

### Duplicate review identifiers
The review dataset contains repeated `review_id` values. The table is retained without a primary key, and review scores are analysed with care to avoid unintended duplication.

### Missing delivery dates
Orders without valid actual or estimated delivery timestamps are excluded from delivery-performance calculations. Non-delivered orders are also excluded from those calculations.

### Geolocation
Postal-code prefixes can occur multiple times in the geolocation dataset. They are not treated as unique keys.

### GMV calculation
Gross merchandise value (GMV) is calculated by summing product item prices. Freight charges are excluded from this measure, and GMV is not treated as profit.

## 5. Analytical Use Cases

The data model supports:

- Monthly GMV and order-volume analysis.
- Late-delivery and on-time delivery analysis.
- Regional delivery-performance comparisons.
- Delivery performance versus customer review scores.
- Payment-method and instalment analysis.
- Product-category sales comparisons.

## 6. Data Quality Considerations

Foreign-key relationships are used where the source data supports reliable references. Tables without suitable unique identifiers, such as geolocation and order reviews, are not assigned artificial primary keys merely to force uniqueness.

Before running analytical queries, row counts, key uniqueness, missing values, and join behaviour should be checked to ensure that aggregations are not unintentionally inflated.

## 7. Tools

- PostgreSQL — relational data storage and SQL analysis.
- Python and Pandas — data cleaning and exploratory analysis.
- Power BI — data modelling, measures, and interactive dashboards.

---

**Author:** Koti Tarun  
**Project:** Brazilian E-Commerce Analytics
