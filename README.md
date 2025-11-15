[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/ilovetahugimbal/PBIsuperstore/blob/main/README.en.md)

# Retail Superstore BI Dashboard

## Project Overview
Ringkasan: Dashboard BI ini menganalisis data retail "Superstore" dari Kaggle untuk membantu manajemen memahami performa penjualan, profit, margin, dan dampak diskon pada setiap kategori dan produk. Proyek ini melatih seluruh workflow BA/BI: ETL, model data, DAX, visualisasi, insight, dan rekomendasi bisnis.

## Dataset
- Sumber: [Superstore Kaggle dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final/data)
- Baris: 9,994 (2014–2017)
- Fitur kunci: Order Date, Category, Sales, Profit, Discount, Region
- Lisensi: CC0 Public Domain

## Data Pipeline
- ETL: Import CSV → transform di Power Query (clean tipe data, buat calendar table)
- Data Modeling: Star schema (Orders fact, Calendar dim, Region dim)
- SQL Validation: Lihat file `queries.sql` untuk top 10 products & monthly sales check

## Dashboard Features
- **Executive KPI Cards:** Total Sales, Profit, Margin %, YOY Growth
- **Sales & Profit Trend:** Line chart bulanan/tahunan
- **Category/Region Breakdown:** Bar & stacked chart sales & profit by segment
- **Product Deep Dive:** Top/bottom 10 by profit, diskon, margin (lihat screenshot)
- **Discount Impact:** Chart diskon range vs profit, insight outlier
- **Interactivity:** Slicer Year, Region, Category. Cross-filter antar visual.
- **Export:** PDF dashboard (lihat `portfolio-insights.pdf`) & PNG screenshot

## Methodology
- Buat Calendar Date table untuk analisis time intelligence (YOY, MoM)
- DAX measures: Total Sales, Profit, Average Discount, Profit Margin, YOY Growth
- Diskon range dibuat sebagai calculated column
- Insight didapat dari pola chart, outlier, dan rule of thumb bisnis
- Lihat detail pembersihan di file `BI-methodology.md`

## Key Insights
- 📉 **Sales turun 2.8% YOY di 2017**: Q2–Q3 lesu, perlu audit channel dan pricing.
- 💸 **Diskon >20% sering memperburuk profit**: 23 produk diskon tinggi rugi total $10K.
- 🏆 **Technology = kategori profit tertinggi**: margin 15.6%, disarankan stok & promosi.
- 🔍 **Central Region margin paling efisien**: meski sales terbanyak dari West.
- 📊 **Seasonality: Q4 sales naik 40%**: disarankan inventory build-up Sep–Nov.

## Recommendations
1. Audit produk loss-making dan revisi harga/strategi diskon.
2. Fokus promosi pada Technology & Central region untuk menang margin.
3. Antisipasi Q4 dengan inventory planning.
4. Lihat file `queries.sql` untuk investigasi mendalam ke produk dan diskon.

## Files Included
- `superstore_dashboard.pbix` — file Power BI utama
- `superstore_data.csv` — raw dataset
- `screenshot-dashboard-1.png` — cuplikan dashboard
- `queries.sql` — query SQL analisis
- `portfolio-insights.pdf` — versi PDF dashboard
- `BI-methodology.md` — detail tahapan teknik

## How to Use
1. Buka `.pbix` di Power BI Desktop v. Download data CSV jika mau eksplorasi ulang.
2. Cek screenshot/PDF untuk preview cepat.
3. Jalankan query di SQL editor untuk validasi data.

## License & Attribution
- Data dan repo bersifat open-source untuk tujuan pembelajaran BA/BI Entry Level.
- Sumber data dan visual dari Kaggle, Microsoft Power BI, repo GitHub.

---
