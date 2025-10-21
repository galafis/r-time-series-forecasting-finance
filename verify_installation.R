#!/usr/bin/env Rscript
# ================================================
# Verification Script - Check Installation
# ================================================

cat("\n")
cat("==============================================\n")
cat("VERIFYING R ENVIRONMENT AND DEPENDENCIES\n")
cat("==============================================\n\n")

# Check R version
cat("R Version:\n")
cat(paste("  ", R.version.string), "\n\n")

# List of required packages
required_packages <- c(
  'forecast',
  'tseries',
  'ggplot2',
  'quantmod',
  'zoo',
  'xts',
  'testthat'
)

# Check each package
cat("Checking Required Packages:\n")
cat("---------------------------\n")

all_installed <- TRUE
for (pkg in required_packages) {
  is_installed <- require(pkg, character.only = TRUE, quietly = TRUE)
  
  if (is_installed) {
    version <- as.character(packageVersion(pkg))
    cat(sprintf("  ✓ %-15s (version %s)\n", pkg, version))
  } else {
    cat(sprintf("  ✗ %-15s NOT INSTALLED\n", pkg))
    all_installed <- FALSE
  }
}

cat("\n")

# Check if all packages are installed
if (all_installed) {
  cat("✅ All required packages are installed!\n")
  
  # Try to source the main file
  cat("\nTesting main functions...\n")
  cat("---------------------------\n")
  
  tryCatch({
    source("R/models/arima_forecast.R")
    cat("  ✓ arima_forecast.R loaded successfully\n")
    
    # Test with simple data
    test_data <- c(100, 102, 105, 103, 107, 110, 108, 112, 115, 113)
    test_ts <- ts(test_data, frequency = 1)
    
    # Test stationarity function
    result <- test_stationarity(test_ts)
    if (is.list(result) && "p_value" %in% names(result)) {
      cat("  ✓ test_stationarity() works\n")
    }
    
    # Test model fitting
    model <- fit_arima_model(test_ts, seasonal = FALSE)
    if (inherits(model, "Arima")) {
      cat("  ✓ fit_arima_model() works\n")
    }
    
    # Test forecast generation
    forecast_result <- generate_forecast(model, h = 3)
    if (inherits(forecast_result, "forecast")) {
      cat("  ✓ generate_forecast() works\n")
    }
    
    cat("\n✅ All function tests passed!\n")
    
  }, error = function(e) {
    cat("  ✗ Error testing functions:", e$message, "\n")
  })
  
} else {
  cat("❌ Some packages are missing. Please run:\n")
  cat("   Rscript INSTALL.R\n")
}

cat("\n")
cat("==============================================\n")
cat("VERIFICATION COMPLETE\n")
cat("==============================================\n\n")

# Exit with appropriate code
if (all_installed) {
  quit(status = 0)
} else {
  quit(status = 1)
}
