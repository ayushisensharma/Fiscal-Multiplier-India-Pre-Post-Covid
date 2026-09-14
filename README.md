# The Fiscal Multiplier in India: Empirical Evidence from Post-COVID Stimulus

## 📌 Overview

This project examines the effectiveness of fiscal policy in India by estimating the **fiscal multiplier** before and after the COVID-19 pandemic.

The study investigates whether changes in **Government Final Consumption Expenditure (GFCE)** translated into changes in **Real GDP growth**, and whether this relationship changed during the post-COVID period.

The analysis combines empirical time-series methods with the **IS-LM framework** to understand the transmission of fiscal policy in the Indian economy.

---

## 🎯 Research Question

**How did the effectiveness of government spending in influencing economic output change between the pre-COVID and post-COVID periods in India?**

The study compares the relationship between GDP growth and government consumption expenditure across two periods:

- **Pre-COVID:** 2015–2019
- **Post-COVID:** 2020–2024

---

## 📊 Data

The analysis uses quarterly macroeconomic data for India.

### Variables

**Real GDP**

Measures the inflation-adjusted value of economic output.

**Government Final Consumption Expenditure (GFCE)**

Measures government spending on goods and services, including areas such as salaries, defence, health and education.

The study uses the change in the logarithm of GDP and GFCE. Taking the first difference of log values provides an approximation of percentage growth.

### Data Source

The primary data source is the:

- Reserve Bank of India (RBI)
- Handbook of Statistics on Indian Economy

---

## 🧮 Methodology

The analysis follows a time-series approach to estimate the fiscal multiplier.

### 1. Log Transformation and Differencing

GDP and GFCE have strong trends over time and may be non-stationary.

## 🔑 Key Insights

###1. Fiscal multiplier was negative in both periods

The estimated cumulative fiscal multiplier remained negative in both the pre-COVID and post-COVID periods.

- **Pre-COVID (Q8): -0.0979**
- **Post-COVID (Q8): -0.0411**

This indicates that, within the estimated models, an increase in GFCE was associated with a decline in GDP over the 8-quarter horizon. :contentReference[oaicite:0]{index=0} :contentReference[oaicite:1]{index=1}

---
---

### 2. Fiscal-output relationship weakened after COVID-19

The most important finding is the change in the relationship between government spending and GDP.

During the **pre-COVID period**, GFCE growth significantly Granger-caused GDP growth, indicating that past government spending contained predictive information about future GDP growth. :contentReference[oaicite:2]{index=2}

In the **post-COVID period**, this relationship was no longer statistically significant. The Granger causality test produced a p-value of 0.135, meaning the null hypothesis could not be rejected. :contentReference[oaicite:3]{index=3}

**Interpretation:** The connection between government consumption expenditure and economic growth became substantially weaker after COVID-19.

---

### 3. The post-COVID multiplier was less negative

Although the multiplier remained negative, its magnitude became smaller:

```text
Pre-COVID       -0.0979
                    ↓
Post-COVID      -0.0411
```text
Δlog(GDP)
Δlog(GFCE)
