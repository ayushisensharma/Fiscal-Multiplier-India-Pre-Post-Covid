# The Fiscal Multiplier in India: Empirical Evidence from Post-COVID Stimulus

## 📌 Overview

This project examines the effectiveness of fiscal policy in India by estimating the **fiscal multiplier** before and after the COVID-19 pandemic.

The study investigates whether changes in **Government Final Consumption Expenditure (GFCE)** translated into changes in **Real GDP growth**, and whether this relationship changed during the post-COVID period.

The analysis uses empirical time-series methods (VAR, Granger causality, impulse response functions) to understand the transmission of fiscal policy in the Indian economy.

---

## 🎯 Research Question

**How did the effectiveness of government spending in influencing economic output change between the pre-COVID and post-COVID periods in India?**

The study compares the relationship between GDP growth and government consumption expenditure across two periods:

- **Pre-COVID:** FY2015–2019
- **Post-COVID:** FY2020–2024

---

## 📊 Data

The analysis uses quarterly macroeconomic data for India.

### Variables

**Real GDP** — Inflation-adjusted (constant price, base year 2011–12) value of economic output.

**Government Final Consumption Expenditure (GFCE)** — Government spending on goods and services, including salaries, defence, health, and education. Note: GFCE excludes capital expenditure, since the focus here is on the type of spending that dominated the COVID response (health, social support, subsidies) rather than capital formation.

Both variables are transformed to **first differences of their logarithms** (Δln), which approximates percentage growth and helps address the non-stationarity caused by their long-run upward trends.

### Data Source

- Reserve Bank of India (RBI), Handbook of Statistics on Indian Economy

---

## 🧮 Methodology

**1. Stationarity check (ADF test).** Before modeling, the Augmented Dickey-Fuller test is run on both Δln(GDP) and Δln(GFCE) for each sub-period. Non-stationary series would produce spurious regressions, so this step confirms both series are stationary after differencing. With a small sample (~20 quarterly observations per period), the optimal lag length is 1.

**2. VAR(1) estimation.** GDP and GFCE are modeled jointly using a reduced-form Vector Autoregression, since fiscal and economic activity are interdependent and 
affect each other with a lag:

Δln(GDP_t) = b0 + b1·Δln(GDP_t-1) + b2·Δln(GFCE_t-1)

Δln(GFCE_t) = a0 + a1·Δln(GDP_t-1) + a2·Δln(GFCE_t-1)

Separate VAR(1) models are estimated for the pre- and post-COVID periods to test whether the fiscal-output relationship structurally changed.

**3. Diagnostics.**
- **Stability:** roots of the characteristic polynomial must be < 1 for impulse responses to be valid.
- **Portmanteau test:** checks residuals for serial correlation (H₀: no serial correlation).

**4. Granger causality.** Tests whether past GFCE growth has predictive power over future GDP growth (and vice versa) in each period.

**5. Impulse Response Functions (IRF).** Traces how GDP growth responds over 8 quarters (2 years) to a one-standard-deviation shock in GFCE growth, holding everything else constant.

**6. Fiscal multiplier.** Computed as the ratio of cumulative GDP response to cumulative GFCE response at each horizon *t*:
Multiplier_t = cumulative GDP response_t / cumulative GFCE response_t

---

## 🔑 Key Findings

### 1. The fiscal multiplier was negative in both periods

- **Pre-COVID cumulative multiplier (Q8): −0.098**
- **Post-COVID cumulative multiplier (Q8): −0.041**

In both periods, an increase in GFCE was associated with a decline in GDP over the 8-quarter horizon rather than an expansion. Likely explanations discussed in the full report: GFCE (unlike capital expenditure) has a weaker demand multiplier; rising public borrowing may have crowded out private investment via higher interest rates; and implementation lags mean spending in one quarter doesn't show up in output until later.

### 2. The fiscal–output relationship weakened after COVID-19

- **Pre-COVID:** GFCE growth significantly Granger-caused GDP growth (p = 0.0002), and there was also a significant instantaneous relationship (p = 0.012).
- **Post-COVID:** This relationship was no longer significant — GFCE growth could not significantly predict future GDP growth (p = 0.135), and the instantaneous link also disappeared (p = 0.173).

This points to a **structural regime shift**: government consumption spending and output growth became effectively decoupled after COVID, with post-COVID GDP dynamics more likely driven by non-fiscal factors (exports, private investment recovery, global demand).

### 3. The post-COVID multiplier was smaller in magnitude

Pre-COVID :−0.098

Post-COVID :−0.041

Although still negative, the multiplier's magnitude roughly halved — the drag from government spending on output became less pronounced, even as the *predictive* relationship (Granger causality) vanished entirely.

### 4. Both models passed diagnostic checks

Stability tests (all polynomial roots < 1) and Portmanteau tests (no significant residual autocorrelation) held in both periods, confirming the results reflect genuine changes in the economic relationship rather than model misspecification.
