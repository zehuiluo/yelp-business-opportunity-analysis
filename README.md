# Yelp Business Opportunity Analysis

## Project Overview
This project analyzes Yelp business data combined with demographic indicators to identify underserved restaurant markets.

Unlike simple EDA projects, this work builds a full data pipeline integrating Python, SQL, and Tableau to support scalable business analysis.

---

## Business Problem
Opening restaurants in saturated markets leads to high failure rates, while underserved areas represent growth opportunities.

The goal is to identify cities where:
- Demand is high (population)
- Supply is relatively low (restaurant density)

---

## Data Pipeline
This project implements a multi-step data pipeline:

Raw Yelp JSON → Data cleaning (Python) → Structured tables (SQL) → Analysis → Visualization (Tableau)

Tools used:
- Python (data processing)
- SQL (data structuring)
- Tableau (dashboard & visualization)

---

## Data
- Yelp dataset (subset of millions of records)
- External demographic data (population)

Key variables:
- Business location (city, state)
- Restaurant categories
- Population indicators

---

## Approach

### 1. Data Processing
- Converted raw JSON into structured format
- Filtered restaurant-related businesses
- Aggregated data at city level

### 2. Feature Engineering
- Restaurant density (restaurants per population)
- Market saturation indicators

### 3. Analysis
- Compared cities based on supply vs demand
- Identified outliers with potential opportunities
- Built visual insights for decision-making

---

## Key Insights
- Mid-sized cities show stronger opportunity than large saturated cities
- Some cities have high population but low restaurant density
- Market opportunities vary significantly by region

---

## Business Impact
- Supports restaurant expansion strategy
- Identifies high-potential markets
- Reduces risk of entering saturated locations

---

## Project Structure
yelp-business-opportunity-analysis/
│
├── notebooks/              # analysis notebook
├── data_pipeline/          # Python & SQL pipeline
├── images/                 # visualizations
├── dashboard/              # Tableau file
├── presentation/           # slides

## Tech Stack
Python, SQL, Tableau, Pandas

## Files
- `notebooks/` → analysis notebook
- `data_pipeline/` → processing logic
- `dashboard/` → Tableau visualization
- `presentation/` → business presentation
