# Retail Superstore BI Dashboard

## Project Overview
Power BI dashboard project for US Superstore retail data, using star schema best practice. Model supports executive and deep-dive analysis for sales, profit, discount strategy, product and region performance over 4 years. Measures in dedicated table for maintainability.

## Data Model
- **Fact Table:** Orders
    - Sales, Profit, Quantity, Discount, Discount Range (calculated), Dates, Region, Category, Product, etc.
- **Dimension Table:** Calendar
    - Date, Month, Year, Quarter, Month-Year, Weekday (incl. sort columns)
- **Measures:** Defined in `_Measures` table
    - Total Sales, Profit, Margin %, YOY Growth, etc. (see below)

_Schema visualization:_
![powerbi-schema.png](screenshot of your model)
_Star schema: Calendar → Orders (Order Date); all key aggregations in _Measures._

## Files Included
- `superstore_dashboard.pbix` — Power BI file (model and visuals)
- `superstore_data.csv` — Raw dataset (Kaggle source)
- `portfolio-dashboard.pdf` — Exported dashboard (for preview)
- `screenshot-dashboard.png` — Full snapshot of dashboard
- `queries.sql` — Example SQL for aggregation/data validation
- `BI-methodology.md` — Steps for cleaning/modelling (optional)

## Measures & Calculations
List of main DAX KPIs (see Power BI for formula details):
- Total Sales
- Total Profit
- Average Discount
- Profit Margin (%)
- YOY/YOY Growth
- High Discount Low Margin Products
- Top/Bottom N analysis
- Discount Range (Orders table — calculated column)

## How the Model Enables Analytics
- Ready for time-based analysis (YOY, MOM) via Calendar dimension
- Discount strategy mapped via calculated column in Orders
- Product and Category analysis via aggregated visuals
- Region breakdown enables geographic insight
- All measures centralized, enabling quick reproducibility
- Supports slicers for dynamic filtering (Year, Region, Category, etc)

## Insights & Recommendations
- 📉 Sales declined 2.8% YOY in 2017 (context: Q2-Q3 drop)
- 💸 High discount (>20%) often reduces profit—review product/promo strategy
- 🏆 Technology products: best margin, profit—stocking and marketing focus
- 🔍 Region efficiency: Central best margin; West top sales
- 📊 Q4 seasonal spike: plan inventory/marketing ahead

## Data Source & License
- Kaggle Superstore dataset (CC0)
- Model, visuals, code open for non-commercial study and portfolio review

## Usage
- Open `.pbix` file in Power BI Desktop
- Interact with slicers (Year, Region, Category) to explore dynamic insights
- See PDF/screenshots for static review
- Run queries in `queries.sql` for data verification
