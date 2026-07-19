# ApexPlanet Sales Analytics — Task 2: Data Analytics (SQL + EDA)

Data analytics internship project for ApexPlanet. This task covers exploratory
data analysis and SQL-based business question answering on a sales dataset.

## Project Overview

The dataset (`apexplanet_sales.db`, SQLite) covers **2025-01-01 to 2026-01-01** and
contains two tables:

| Table       | Description                  | Rows |
|-------------|-------------------------------|------|
| `orders`    | Fact table of sales orders    | 1000 |
| `customers` | Dimension table of customers  | 947  |

## Repository Structure

```
apexplanet-sales-analytics/
├── data/
│   └── apexplanet_sales.db          # SQLite database (orders + customers)
├── sql/
│   ├── business_questions_sql.sql   # All SQL queries for the business questions
│   └── SQL_Query_Results.xlsx       # Query outputs exported to Excel
├── reports/
│   └── EDA_Report__1_.docx          # Exploratory Data Analysis report
├── dashboard/
│   └── Dashboard_Mockup.pptx        # Dashboard design mockup
└── README.md
```

## Business Questions Answered

1. Top 5 products by revenue in the last 6 months
2. Monthly revenue trend across the dataset
3. Highest revenue-generating cities and their average order value
4. Revenue breakdown by customer age group and product category
5. Gender-wise split of orders, revenue, and average order value
6. Day-of-week with the highest average order value vs. order volume
7. Month-over-month revenue growth rate (using window functions)

See [`sql/business_questions_sql.sql`](sql/business_questions_sql.sql) for the full,
commented queries and [`sql/SQL_Query_Results.xlsx`](sql/SQL_Query_Results.xlsx) for
the results.

## Tools Used

- **SQLite** — database and query engine
- **SQL** (aggregation, joins, window functions) — business question analysis
- **Excel** — results export and light formatting
- **Word** — EDA report
- **PowerPoint** — dashboard mockup

## How to Run the Queries

```bash
sqlite3 data/apexplanet_sales.db
.read sql/business_questions_sql.sql
```

## Author

Data Analytics Internship — ApexPlanet
