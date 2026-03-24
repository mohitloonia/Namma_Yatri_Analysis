# Namma Yatri Ward Performance Analysis

##  Project Overview

This project analyzes ward-level operational and revenue performance of Namma Yatri using publicly available data.

The objective was to evaluate:

- Operational Efficiency
- Revenue Efficiency
- Cancellation and Conversion behavior
- Ward-level performance differences

## Live Project (GitHub Pages)

You can explore the interactive visualization here:

👉 [View Project on GitHub Pages](https://mohitloonia.github.io/Namma_Yatri_Analysis/)
---

##  Key Metrics Created

### 1. Service Efficiency Index (SEI)
A composite metric based on:
- Estimate Rate (40%)
- Conversion Rate (30%)
- Completion Rate (30%)

### 2. Earnings per KM
Revenue efficiency measure:
Driver Earnings / Distance Travelled

### 3. Cancellation Rate
Booking-level cancellation behavior

---

##  Visualizations Included

- Interactive Bubble Plot  
  *(Cancellation Rate vs Service Efficiency Index)*

- Top 10 Wards by SEI

- Bottom 10 Wards by SEI

- SEI vs Earnings per KM Scatter Plot

---

##  Key Insights

### 1. Operational Efficiency ≠ Revenue Efficiency

The analysis shows no strong relationship between Service Efficiency Index (SEI) and Earnings per KM.

This means:

- A ward having high operational efficiency does NOT guarantee higher earnings per kilometer.
- Drivers may assume higher SEI implies better earnings, but the data suggests revenue efficiency depends on additional factors such as pricing structure, demand patterns, and trip distance distribution.

This highlights that operational performance and revenue performance are two independent dimensions.

---

### 2. SEI vs Cancellation Behavior

A clear pattern observed:

As SEI increases, the cancellation rate generally decreases.

This indicates that wards with:
- Better conversion rates
- Better completion rates

also tend to have more stable booking behavior and lower cancellations.

Thus, SEI is strongly associated with operational stability, even if it does not directly drive revenue efficiency.




---

## 🛠 Tools Used

- R
- tidyverse
- ggplot2
- plotly
- dplyr

---

## Files in Repository

- `analysis.R` → Main analysis script
- `index.html` → Interactive visualization
- `top10_sei_clear.png`
- `bottom10_sei_clear.png`
- `earnings_per_km_vs_sei.png`
- `namma_yatri_metrics_clean.csv`

---

##  Author

Mohit Loonia  
MIT (Bengaluru)

