library(readxl)
library(dplyr)
library(tseries)
library(vars)
library(lmtest)

# ---- safe division helper ----
safe_div <- function(a, b, eps = 1e-10) {
  out <- rep(NA_real_, length(a))
  keep <- abs(b) > eps
  out[keep] <- a[keep] / b[keep]
  out
}

# ---- VAR workflow: includes IRFs, cumulative, and fiscal multiplier ----
run_var <- function(df, y_name, x_name, label = "PRE", p = 1, irf_h = 8) {
  cat("\n================ ", label, " ================\n", sep = "")
  
  # 1) Stationarity (ADF)
  cat("\nADF tests:\n")
  suppressWarnings(print(adf.test(as.numeric(df[[y_name]]))))
  suppressWarnings(print(adf.test(as.numeric(df[[x_name]]))))
  
  # 2) Estimate VAR
  model <- VAR(df, p = p, type = "const")
  cat("\nVAR(", p, ") summary:\n", sep = "")
  print(summary(model))
  
  # 3) Stability check
  cat("\nStability (all roots < 1 => stable):\n")
  print(roots(model, modulus = TRUE))
  
  # 3b) Serial correlation check
  cat("\nResidual serial correlation (Portmanteau, lags.pt = 4):\n")
  print(serial.test(model, lags.pt = 4, type = "PT.asymptotic"))
  
  # 4) Granger causality
  cat("\nGranger: does ", x_name, " cause ", y_name, "?\n", sep = "")
  print(causality(model, cause = x_name))
  cat("\nGranger: does ", y_name, " cause ", x_name, "?\n", sep = "")
  print(causality(model, cause = y_name))
  
  # 5) Impulse responses (GFCE shock -> {GDP, GFCE})
  set.seed(123)
  irf_obj <- irf(
    model,
    impulse  = x_name,
    response = c(y_name, x_name),
    n.ahead  = irf_h,
    boot     = TRUE,
    ci       = 0.95
  )
  
  # Extract matrices
  irf_mat   <- irf_obj$irf[[x_name]]
  lower_mat <- irf_obj$Lower[[x_name]]
  upper_mat <- irf_obj$Upper[[x_name]]
  
  # Extract responses
  irf_GDP <- as.numeric(irf_mat[, y_name])
  irf_GFCE <- as.numeric(irf_mat[, x_name])
  low_GDP <- as.numeric(lower_mat[, y_name]); high_GDP <- as.numeric(upper_mat[, y_name])
  low_GFCE <- as.numeric(lower_mat[, x_name]); high_GFCE <- as.numeric(upper_mat[, x_name])
  
  # If q=0 missing, add it
  if (length(irf_GDP) == irf_h) {
    irf_GDP  <- c(0, irf_GDP)
    irf_GFCE <- c(0, irf_GFCE)
    low_GDP  <- c(0, low_GDP); high_GDP <- c(0, high_GDP)
    low_GFCE <- c(0, low_GFCE); high_GFCE <- c(0, high_GFCE)
  }
  q <- 0:irf_h
  
  # Cumulative and fiscal multiplier
  cum_GDP <- cumsum(irf_GDP)
  cum_GFCE <- cumsum(irf_GFCE)
  multiplier <- safe_div(cum_GDP, cum_GFCE)
  
  # Build output table
  out_tbl <- data.frame(
    q = q,
    irf_GDP = round(irf_GDP, 6),
    low95_GDP = round(low_GDP, 6),
    high95_GDP = round(high_GDP, 6),
    cum_GDP = round(cum_GDP, 6),
    irf_GFCE = round(irf_GFCE, 6),
    low95_GFCE = round(low_GFCE, 6),
    high95_GFCE = round(high_GFCE, 6),
    cum_GFCE = round(cum_GFCE, 6),
    fiscal_multiplier = round(multiplier, 6)
  )
  
  cat("\nIRF & Fiscal Multiplier table (", label, "): ", x_name, " shock\n", sep = "")
  print(out_tbl)
  
  # Quick summary
  last <- tail(out_tbl, 1)
  cat("\nCumulative multiplier at horizon ", irf_h, ": ",
      last$fiscal_multiplier, " (cum_GDP=", last$cum_GDP, 
      ", cum_GFCE=", last$cum_GFCE, ")\n", sep = "")
  
  invisible(list(model = model, irf = irf_obj, table = out_tbl))
}

# =========================
# PRE-COVID (Sheet2)
# =========================
data_pre <- read_excel("Macro_data.xlsx", sheet = "Sheet2")

# Growth rates (first diff of logs)
dln_GDP_pre  <- diff(data_pre$`ln(GDP)`)
dln_GFCE_pre <- diff(data_pre$`ln(GFCE)`)

df_var_pre <- data.frame(
  dln_GDP_pre  = as.numeric(dln_GDP_pre),
  dln_GFCE_pre = as.numeric(dln_GFCE_pre)
) |> na.omit()

res_pre <- run_var(
  df     = df_var_pre,
  y_name = "dln_GDP_pre",
  x_name = "dln_GFCE_pre",
  label  = "PRE",
  p      = 1,
  irf_h  = 8
)

# =========================
# POST-COVID (Sheet1)
# =========================
data_post <- read_excel("Macro_data.xlsx", sheet = "Sheet1")

dln_GDP_post  <- diff(data_post$`ln(GDP)`)
dln_GFCE_post <- diff(data_post$`ln(GFCE)`)

df_var_post <- data.frame(
  dln_GDP_post  = as.numeric(dln_GDP_post),
  dln_GFCE_post = as.numeric(dln_GFCE_post)
) |> na.omit()

res_post <- run_var(
  df     = df_var_post,
  y_name = "dln_GDP_post",
  x_name = "dln_GFCE_post",
  label  = "POST",
  p      = 1,
  irf_h  = 8
)
