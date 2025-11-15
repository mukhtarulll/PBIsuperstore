# Metodologi Business Intelligence
## Proyek: Retail Superstore BI Dashboard

### 1. Penentuan Tujuan Bisnis & Scope Proyek
Tahap awal adalah merumuskan pertanyaan kunci bisnis yang ingin dijawab melalui analisis data. Untuk proyek ini:
- Bagaimana tren penjualan dan profit dari waktu ke waktu?
- Produk dan kategori mana yang memiliki margin tertinggi dan terendah?
- Bagaimana dampak strategi diskon terhadap profitabilitas?
- Region mana yang paling efisien dan mana yang perlu perbaikan?

Scope dibatasi pada analisis penjualan, profit, margin, dan pengaruh diskon terhadap performa produk dan region untuk periode 2014–2017.

### 2. Pengumpulan & Praproses Data
**Sumber Data:**
- Dataset "Superstore" dari Kaggle dalam format CSV
- Total 9,994 baris transaksi retail US (2014–2017)
- Kolom utama: Order Date, Category, Sub-Category, Product Name, Sales, Profit, Discount, Region, dll.

**Praproses di Power Query:**
- Ubah tipe data Order Date dan Ship Date dari text menjadi Date dengan locale US (format M/D/YYYY)
- Set tipe data Sales, Profit, Discount menjadi Decimal Number
- Set Quantity menjadi Whole Number
- Pastikan Postal Code tetap Text (untuk menjaga leading zero)
- Cek dan tangani nilai null: replace dengan 0 untuk kolom numerik
- Hapus kolom yang tidak diperlukan: Row ID, Country (jika semua "United States")

**Pembuatan Tabel Calendar:**
Buat tabel dimensi waktu dengan DAX untuk mendukung time intelligence:
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
Tambahkan kolom sort helper "Month-Year Sort" untuk memastikan urutan kronologis, bukan alfabetis.

### 3. Perancangan Model Data
**Star Schema:**
- **Tabel Fakta:** Orders (transaksi, produk, tanggal, segmentasi pelanggan)
- **Tabel Dimensi:** Calendar (atribut waktu lengkap)
- Atribut lain seperti Region, Category, Sub-Category tetap sebagai kolom di Orders

**Relationship:**
- One-to-many dari Calendar[Date] → Orders[Order Date]
- Cardinality: 1:* (One to Many)
- Cross filter direction: Single
- Mark tabel Calendar sebagai Date Table

**Calculated Column:**
Buat kolom Discount Range untuk analisis visual:
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

### 4. Validasi Data (SQL Verification)
Untuk memastikan kualitas data dan hasil analisis, lakukan validasi dengan SQL:
- Import dataset ke database lokal (SQLite, PostgreSQL, atau tool serupa)
- Jalankan query untuk cek konsistensi agregasi
- Bandingkan hasil query SQL dengan hasil dashboard Power BI

Contoh query validasi tersedia di file `queries.sql`.

### 5. Pembangunan KPI & Analitik (DAX)
**Measures Utama:**
Semua measure disimpan dalam tabel `_Measures` untuk organisasi yang lebih baik.

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

**Measure Khusus:**
```dax
High Discount Low Margin Products = 
CALCULATE(
    DISTINCTCOUNT(Orders[Product Name]),
    Orders[Discount] > 0.2,
    Orders[Profit] < 0
)
```

### 6. Visualisasi dan Dashboarding
**Struktur Dashboard:**
Dashboard satu halaman dengan komponen:

**KPI Cards:**
- Total Sales, Total Profit, Profit Margin %
- YOY Growth (Sales & Profit)
- Total Orders, Average Order Value
- Average Discount, High Discount Low Margin Products

**Visualisasi Analitik:**
- Line chart: Sales & Profit trend by Year dengan drill-down ke Month-Year
- Stacked bar chart: Profit by Category and Product
- Clustered bar chart: Sales by Region and City
- Clustered column chart: Profit & Sales by Discount Range
- Horizontal bar chart: Top 10 dan Bottom 10 Products by Profit
- Scatter plot: Sales vs Profit by Category (bubble size = Average Discount)

**Interaktivitas:**
- Slicer untuk Year, Region, Category
- Cross-filtering antar visual
- Drill-down hierarchy: Year → Quarter → Month
- Data labels aktif di semua chart
- Consistent color scheme

### 7. Penarikan Insight dan Dokumentasi
**Insight Utama:**
- Sales turun 2.8% YOY di 2017, terutama di Q2–Q3
- 23 produk dengan diskon >20% masih mengalami kerugian
- Technology adalah kategori dengan margin tertinggi (15.6%)
- Central region memiliki efisiensi margin terbaik meski volume tertinggi dari West
- Pola seasonality menunjukkan Q4 konsisten 40% lebih tinggi dari rata-rata

**Rekomendasi Bisnis:**
1. Audit produk loss-making dan revisi strategi pricing/diskon
2. Fokuskan promosi dan inventory pada kategori Technology
3. Terapkan best practice operasional Central region ke region lain
4. Antisipasi lonjakan Q4 dengan inventory planning mulai September–November
5. Review kebijakan diskon: cap maksimal 15% untuk produk low-margin
