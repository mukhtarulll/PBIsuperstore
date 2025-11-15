[![id](https://img.shields.io/badge/lang-id-blue.svg)](https://github.com/ilovetahugimbal/PBIsuperstore/blob/main/README.md)

# Retail Superstore BI Dashboard
## Portfolio Project: Business Intelligence & Analytics

This project is an interactive Business Intelligence dashboard that analyzes Superstore retail data over 4 years (2014–2017). The dashboard is built with Power BI using a star schema, DAX measures, and multi-dimensional visualizations to identify sales trends, profitability patterns, and the impact of discount strategies on business performance.

---

## Quick Summary

![alt text](https://github.com/ilovetahugimbal/PBIsuperstore/blob/readme-baru/superstore_dashboard.png)

Dashboard includes:
- **Executive KPI**: Total sales ($2.3M), profit ($286K), margin (12.5%), YOY growth trends
- **Trend Analysis**: Monthly sales & profit with seasonality pattern (Q4 spike 40%)
- **Business Dimensions**: Breakdown by category, region, product, and discount range
- **Actionable Insights**: Loss-making products, discount impact on margins, pricing & inventory recommendations

---

## Dataset

**Source:** Kaggle Superstore Dataset  
**Link:** https://www.kaggle.com/datasets/vivek468/superstore-dataset-final/data  
**License:** CC0 Public Domain

| Attribute | Detail |
|-----------|--------|
| Total Rows | 9,994 transactions |
| Time Period | 2014–2017 (4 years) |
| Geography | United States (4 regions) |
| Product Categories | 3 categories, 17 sub-categories |
| Key Features | Sales, Profit, Discount, Category, Region, Order Date |

---

## Data Model Structure

The dashboard uses a **simple star schema** for optimal performance and maintainability:

![alt text](https://github.com/ilovetahugimbal/PBIsuperstore/blob/main/superstore_scheme%20model.png)

**Relationship:**  
Calendar[Date] → Orders[Order Date] (One-to-Many)

**Key Components:**
- **Calendar Table**: Complete time dimension with Year, Quarter, Month, Month-Year, Weekday
- **Discount Range Column**: Calculated column for discount grouping (No Discount, 1-10%, 11-20%, 21-30%, >30%)
- **_Measures Table**: 11+ DAX measures for KPIs and analytics

---

## Dashboard Features

### 1. KPI Cards (Executive Summary)
Displays key metrics at a glance:
- Total Sales (current year)
- Total Profit
- Profit Margin %
- YOY Growth (Sales & Profit)
- Total Orders, Average Order Value
- Average Discount
- Count of High-Discount Low-Margin Products

### 2. Trend Analysis
**Line Chart: Sales & Profit by Year**
- Shows trajectory 2014–2017
- Dual axis for comparing sales and profit
- Insight: Sales grew consistently but declined in 2015, then recovered

### 3. Category & Regional Breakdown
**Bar Charts:**
- Profit by Category and Product (top performers)
- Sales by Region and City (market distribution)
- Insight: Technology highest margin, West highest margin

### 4. Discount Impact Analysis
**Clustered Column Chart: Profit & Sales by Discount Range**
- Breakdown: No Discount, 1-10%, 11-20%, 21-30%, >30%
- Insight: High discount (>20%) often reduces profit despite sales increase

**High Discount Low Margin Products Card:**
- Count of products with >20% discount but negative profit
- Insight: 23 products need pricing review

### 5. Product Deep Dive
**Top & Bottom 10 Products by Profit**
- Top 10: star products (high profit, stable margin)
- Bottom 10: products with losses or minimal margins
- Action: Consider discontinuing or repricing bottom performers

### 6. Interactivity
- **Slicers**: Year, Region, Category for multi-dimensional filtering
- **Cross-Filtering**: Click bar chart auto-updates other visuals
- **Drill-Down**: Year → Quarter → Month → Day in trend chart

---

## Key Findings

### Sales Declined 2.8% YOY in 2015
- Positive trend 2014–2016 suddenly weakened in 2015
- **Action**: Investigate external factors (competitor activity, market saturation, pricing)

### High Discount ≠ High Profit
- 23 products with >20% discount still unprofitable
- Optimal discount appears in 1-10% range (balance volume & margin)
- **Action**: Review discount policy—cap at 15% max for low-margin products

### Technology is the Star Category
- Largest profit: $145K (30% of total)
- Highest margin: 17.4%
- Recommendation: Prioritize stock, promotions, and margin protection

### Central Region Shows Best Efficiency
- West highest sales ($725K, 31% share) and margin
- Central lower margin but strong sales volume, better operational efficiency
- **Action**: Transfer West best practices to Central

### Q4 Seasonal Spike 40%
- Consistent pattern: Q4 (Oct–Dec) significantly higher
- Requires inventory build-up Sep–Nov
- Opportunity for margin management & flash sales

---

## Metrics & Definitions

| Metric | Formula | Interpretation |
|--------|---------|-----------------|
| **Total Sales** | SUM(Orders[Sales]) | Overall revenue for period |
| **Total Profit** | SUM(Orders[Profit]) | Net profit after costs |
| **Profit Margin %** | Total Profit / Total Sales | Margin efficiency (target >12%) |
| **Average Order Value** | Total Sales / Total Orders | Average value per order |
| **Average Discount** | AVERAGE(Orders[Discount]) | Average discount applied (in %) |
| **YOY Growth** | (Current Year - Previous Year) / Previous Year | Year-over-year growth rate |

---

## How to Use

### 1. Preview Dashboard
- Open `superstore_dashboard.pdf` to view the static dashboard version
- See screenshots `superstore_dashboard.png` and `superstore_scheme model.png` for quick overview

### 2. Interactive Exploration (Offline)
- Download `superstore_dashboard.pbix`
- Open with Power BI Desktop (free download from Microsoft)
- Use slicers Year/Region/Category to filter data
- Click bar/chart for drill-down and cross-filtering

### 3. Data Validation & Methodology
- Read `BI-methodology.en.md` for detailed technical steps
- Run queries in `queries.sql` to verify aggregation results
- Compare SQL output with dashboard results

### 4. Customize & Extend
- To extend: add new slicers, visuals, or measures in Power BI
- Edit `.pbix` directly or use Power BI Service for publishing

---

## Tools & Requirements

**For Preview/Reading:**
- Web browser (read markdown & PDF)
- PDF reader (for `superstore_dashboard.pdf`)

**For Interactive Exploration:**
- Power BI Desktop (free, download from https://powerbi.microsoft.com/downloads)
- Dataset CSV included; simply open the `.pbix` file

**For Data Validation:**
- SQL client (SQLite, DBeaver, pgAdmin, or similar)
- Import `Sample - Superstore.csv` to database
- Run queries from `queries.sql`

---

## Methodology & Best Practices

Dashboard built following BI/DA best practices:
- **Star Schema Design**: Scalable, efficient for aggregation & time intelligence
- **DAX Best Practices**: Measures separate from dimensions, CALCULATE for context override
- **Documentation**: Every step documented for reproducibility
- **Data Validation**: Cross-checked with SQL for accuracy
- See `BI-methodology.en.md` for detailed explanation of each stage
