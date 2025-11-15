# Business Intelligence Methodology
## Project: Retail Superstore BI Dashboard

### 1. Define Business Questions & Project Scope
The first step is to formulate key business questions that the data analysis will address. For this project:
- What are the trends in sales and profit over time?
- Which products and categories have the highest and lowest margins?
- How does the discount strategy impact profitability?
- Which regions are most efficient and which need improvement?

The scope is limited to analyzing sales, profit, margin, and the impact of discounts on product and regional performance for the period 2014–2017.

### 2. Data Sourcing & Preprocessing
**Data Source:**
- "Superstore" dataset from Kaggle in CSV format
- Total of 9,994 rows of US retail transactions (2014–2017)
- Key columns: Order Date, Category, Sub-Category, Product Name, Sales, Profit, Discount, Region, etc.

**Preprocessing in Power Query:**
- Convert Order Date and Ship Date from text to Date type with US locale (M/D/YYYY format)
- Set Sales, Profit, Discount as Decimal Number
- Set Quantity as Whole Number
- Keep Postal Code as Text (to preserve leading zeros)
- Check and handle null values: replace with 0 for numeric columns
- Remove unnecessary columns: Row ID, Country (if all "United States")

**Creating Calendar Table:**
Build a time dimension table with DAX to support time intelligence:
```dax
Calendar = 
ADDCOLUMNS(
    CALENDAR(DATE(2014, 1, 1), DATE(2018, 12, 31)),
    "Year", YEAR([Date]),
    "Quarter", "Q" & QUARTER([Date]),
    "Month", FORMAT([Date], "MMM"),
    "Month Number", MONTH([Date]),
    "Month-Year", FORMAT([Date], "MMM YYYY"),
    "Weekday", FORMAT([Date], "ddd"),
    "Weekday Number", WEEKDAY([Date], 2)
)
```
Add a "Month-Year Sort" helper column to ensure chronological order instead of alphabetical.

### 3. Data Model Design
**Star Schema:**
- **Fact Table:** Orders (transactions, products, dates, customer segmentation)
- **Dimension Table:** Calendar (complete time attributes)
- Other attributes like Region, Category, Sub-Category remain as columns in Orders

**Relationships:**
- One-to-many from Calendar[Date] → Orders[Order Date]
- Cardinality: 1:* (One to Many)
- Cross filter direction: Single
- Mark Calendar table as Date Table

**Calculated Column:**
Create Discount Range column for visual analysis:
```dax
Discount Range =
SWITCH(
    TRUE(),
    Orders[Discount] = 0, "No Discount",
    Orders[Discount] > 0 && Orders[Discount] <= 0.1, "1-10%",
    Orders[Discount] > 0.1 && Orders[Discount] <= 0.2, "11-20%",
    Orders[Discount] > 0.2 && Orders[Discount] <= 0.3, "21-30%",
    Orders[Discount] > 0.3, ">30%",
    "Other"
)
```

### 4. Data Validation (SQL Cross-Check)
To ensure data quality and analysis accuracy, perform validation with SQL:
- Import dataset to local database (SQLite, PostgreSQL, or similar tool)
- Run queries to check aggregation consistency
- Compare SQL query results with Power BI dashboard results

Sample validation queries are available in the `queries.sql` file.

### 5. KPI & Analytics Development (DAX)
**Core Measures:**
All measures are stored in the `_Measures` table for better organization.

```dax
Total Sales = SUM(Orders[Sales])
Total Profit = SUM(Orders[Profit])
Total Orders = DISTINCTCOUNT(Orders[Order ID])
Total Quantity = SUM(Orders[Quantity])
Profit Margin = DIVIDE([Total Profit], [Total Sales], 0)
Average Order Value = DIVIDE([Total Sales], [Total Orders], 0)
Average Discount = AVERAGE(Orders[Discount])
```

**Time Intelligence:**
```dax
Sales YOY Growth = 
VAR CurrentYearSales = 
    CALCULATE([Total Sales], Calendar[Year] = MAX(Calendar[Year]))
VAR PreviousYearSales = 
    CALCULATE([Total Sales], Calendar[Year] = MAX(Calendar[Year]) - 1)
RETURN
DIVIDE(CurrentYearSales - PreviousYearSales, PreviousYearSales, 0)

Profit YOY Growth = 
VAR CurrentYearProfit = 
    CALCULATE([Total Profit], Calendar[Year] = MAX(Calendar[Year]))
VAR PreviousYearProfit = 
    CALCULATE([Total Profit], Calendar[Year] = MAX(Calendar[Year]) - 1)
RETURN
DIVIDE(CurrentYearProfit - PreviousYearProfit, PreviousYearProfit, 0)
```

**Specialized Measure:**
```dax
High Discount Low Margin Products = 
CALCULATE(
    DISTINCTCOUNT(Orders[Product Name]),
    Orders[Discount] > 0.2,
    Orders[Profit] < 0
)
```

### 6. Visualization and Dashboard Design
**Dashboard Structure:**
Single-page dashboard with the following components:

**KPI Cards:**
- Total Sales, Total Profit, Profit Margin %
- YOY Growth (Sales & Profit)
- Total Orders, Average Order Value
- Average Discount, High Discount Low Margin Products

**Analytical Visualizations:**
- Line chart: Sales & Profit trend by Year with drill-down to Month-Year
- Stacked bar chart: Profit by Category and Product
- Clustered bar chart: Sales by Region and City
- Clustered column chart: Profit & Sales by Discount Range
- Horizontal bar chart: Top 10 and Bottom 10 Products by Profit
- Scatter plot: Sales vs Profit by Category (bubble size = Average Discount)

**Interactivity:**
- Slicers for Year, Region, Category
- Cross-filtering between visuals
- Drill-down hierarchy: Year → Quarter → Month
- Active data labels on all charts
- Consistent color scheme

### 7. Insight Generation and Documentation
**Key Insights:**
- Sales declined 2.8% YOY in 2017, primarily in Q2–Q3
- 23 products with discounts >20% still experience losses
- Technology is the category with the highest margin (15.6%)
- Central region has the best margin efficiency despite West having the highest volume
- Seasonality pattern shows Q4 consistently 40% higher than average

**Business Recommendations:**
1. Audit loss-making products and revise pricing/discount strategy
2. Focus promotions and inventory on Technology category
3. Apply Central region's operational best practices to other regions
4. Anticipate Q4 surge with inventory planning starting September–November
5. Review discount policy: cap at 15% for low-margin products

**Documentation Format:**
- README.md: project overview, dataset, insights, and supporting files
- BI-methodology.en.md: technical documentation of work stages (this file)
- Dashboard and data model diagram screenshots
- Export dashboard to PDF for quick preview
- queries.sql file for SQL validation

### 8. Supporting Files in Repository
File structure for GitHub portfolio:
```
├── README.md
├── BI-methodology.md
├── BI-methodology.en.md
├── superstore_dashboard.pbix
├── superstore_data.csv
├── queries.sql
├── portfolio-insights.pdf
├── screenshot-dashboard.png
├── screenshot-model.png
└── CHANGELOG.md (optional)
```

### Tools & Technologies
- **Power BI Desktop:** Data modeling, DAX, visualization
- **Power Query:** ETL and data cleaning
- **SQL (SQLite/PostgreSQL):** Data validation and aggregation
- **Excel:** Sanity checks and initial EDA
- **Git/GitHub:** Version control and portfolio hosting

### Project Timeline
- Day 1: Data sourcing, cleaning, model design (4–5 hours)
- Day 2: DAX measures, dashboard build, insight generation (4–5 hours)
- Day 3: Documentation, export, polish, upload to GitHub (2–3 hours)

Total: 10–13 hours for a comprehensive entry-level portfolio project.

---

**Note:**
This methodology follows BI/DA best practices for reproducibility, transparency, and business value. Each stage is documented to help reviewers understand the process from raw data to actionable insights.