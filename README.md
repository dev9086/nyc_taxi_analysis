# NYC Taxi Revenue & Demand Analysis — March 2026

End-to-end data analysis of NYC Yellow and Green Cab trip records using Python and PostgreSQL.
The project answers seven business questions about revenue, demand, cab performance, and tipping behaviour,
backed by inferential statistics, A/B testing, and machine learning models.

---

## Data Source

**NYC Taxi & Limousine Commission (TLC) Trip Record Data**
https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

- 6,433 real trip records from March 2026
- 14 raw columns: pickup/dropoff timestamps, fare, tip, tolls, total, cab color,
  payment type, pickup/dropoff zone and borough, passenger count, distance
- Real missing values: 44 rows with null payment, 26 with null pickup zone

---

## Tech Stack

| Layer | Tool |
|---|---|
| Data download | urllib (live from TLC mirror) |
| Cleaning & EDA | Python, Pandas, NumPy |
| Statistics | SciPy |
| Visualisation | Matplotlib, Seaborn |
| Database | PostgreSQL (psycopg2, SQLAlchemy) |
| ML — Classification | Scikit-learn RandomForestClassifier |
| ML — Regression | XGBoost |

---

## Repository Structure

```
nyc-taxi-analysis/
├── notebooks/
│   └── analysis.ipynb        full analysis — all cells executed with outputs
├── sql/
│   ├── schema.sql            CREATE TABLE for taxi_trips
│   └── analysis_queries.sql  all 7 business questions with full SQL and written answers
├── requirements.txt
├── .gitignore
└── README.md
```

---

## Notebook Sections

| Section | What it covers |
|---|---|
| Data Loading | Live download from NYC TLC, `df.head()` |
| Data Overview | `df.info()`, null count and percentage |
| Descriptive Statistics | `describe()`, extended percentiles, skewness, kurtosis, variance |
| Data Cleaning | Null drops, zone fills, fare sanity check, derived columns |
| Outlier Analysis | IQR fences per column, boxplots, 99th-percentile cap |
| EDA | Distributions, correlation heatmap, fare vs distance, hourly demand, tipping rate |
| Inferential Statistics | Pearson, Spearman, two t-tests, one-way ANOVA, chi-square, Cohen's d, 95% CI |
| A/B Testing | Yellow vs green (two-tailed t-test) + card vs cash (one-tailed t-test) |
| PostgreSQL — Load Data | psycopg2 connection, schema creation, data insert into taxi_trips |
| SQL Analysis | 7 business questions answered via SQL with charts |
| ML — Classification | Random Forest predicts tip/no tip, confusion matrix, feature importance |
| ML — Regression | XGBoost predicts tip amount on tipped rides, RMSE/MAPE, residuals |

---

## SQL Questions & Answers

All queries are in `sql/analysis_queries.sql` with full SQL and written answers below each.

| # | Question | Key Finding |
|---|---|---|
| Q1 | Which boroughs generate the most revenue? | Manhattan leads by volume; Queens has the highest average fare per trip (airport rides) |
| Q2a | What hours see the highest demand? | Peak at 18:00–20:00; lowest at 03:00–06:00 |
| Q2b | Which days are busiest? | Friday and Saturday by trip count and revenue |
| Q3 | Yellow vs green cab — who earns more? | Yellow accounts for ~85% of revenue by volume; green logs longer distances |
| Q4 | Does payment method affect tipping? | Card users tip on ~95% of rides; cash users on under 5% |
| Q5 | Is fare consistent with distance? | Linear for 0–15 miles (r = 0.87); JFK flat fare flattens the curve beyond 15 miles |
| Q6 | Which pickup zones drive the most revenue? | JFK Airport, LaGuardia, Midtown Manhattan dominate |
| Q7 | What share of rides produce a tip? | Manhattan ~92% tipping rate; Bronx and Brooklyn under 40% |

---

## A/B Testing Summary

### Test 1 — Yellow vs Green Cab (Total Fare)

- H0: Mean fare is equal across cab types
- H1: Mean fare differs
- Test: Two-sample independent t-test, α = 0.05
- Result: Reject H0 — statistically significant difference in average total fare

### Test 2 — Credit Card vs Cash (Tip Amount)

- H0: Mean tip is equal across payment methods
- H1: Card rides generate higher tips (one-tailed)
- Test: One-tailed t-test, α = 0.05
- Result: Reject H0 — credit card payment significantly increases tip amount (Cohen's d indicates large effect)

---

## ML Performance

| Model | Task | Result |
|---|---|---|
| Random Forest | Tip / No Tip classification | ~96% accuracy |
| XGBoost | Tip amount regression | RMSE ~$1.36 |

**Top predictive features:** payment method, fare, distance, trip duration.
Payment method alone explains most of the variance in tipping — card users are auto-prompted,
cash users are not.

---

## Setup

```bash
git clone https://github.com/<your-username>/nyc-taxi-analysis
cd nyc-taxi-analysis
pip install -r requirements.txt
```

Update database credentials in `notebooks/analysis.ipynb` under **PostgreSQL — Load Data**:

```python
hostname = 'localhost'
database = 'your_database'
username = 'your_username'
pwd      = 'your_password'
port_id  = 5432
```

Run `sql/schema.sql` to create the `taxi_trips` table, then run the notebook top to bottom.
Data downloads automatically — no manual file upload needed.
