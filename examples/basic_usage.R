#!/usr/bin/env Rscript
# ================================================
# Example: Using ARIMA Forecasting with Sample Data
# ================================================

# Load required libraries
suppressPackageStartupMessages({
  library(forecast)
  library(ggplot2)
})

# Source the ARIMA forecasting functions
source("R/models/arima_forecast.R")

cat("\n")
cat("============================================\n")
cat("EXAMPLE: ARIMA Forecasting with Sample Data\n")
cat("============================================\n\n")

# Example 1: Simple synthetic data
cat("Example 1: Synthetic Time Series\n")
cat("---------------------------------\n")

# Generate sample data (random walk with trend)
set.seed(123)
n <- 100
trend <- seq(100, 150, length.out = n)
noise <- rnorm(n, 0, 3)
sample_data <- trend + cumsum(noise)

# Run ARIMA pipeline
cat("\nRunning ARIMA pipeline...\n")
results <- arima_pipeline(
  data = sample_data,
  frequency = 1,
  forecast_horizon = 10
)

cat("\nModel Information:\n")
cat("Model Order:", paste(results$model$arma[1:3], collapse = ", "), "\n")
cat("AIC:", results$model$aic, "\n")
cat("BIC:", results$model$bic, "\n")

cat("\nForecast (next 10 periods):\n")
print(round(as.numeric(results$forecast$mean), 2))

cat("\n")

# Example 2: Real stock data (if file exists)
stock_file <- "data/sample_stock_prices.csv"
if (file.exists(stock_file)) {
  cat("\nExample 2: Stock Price Data\n")
  cat("---------------------------\n")
  
  # Read stock data
  stock_data <- read.csv(stock_file)
  prices <- stock_data$Close
  
  cat(sprintf("Loaded %d observations from %s\n", 
              length(prices), stock_file))
  
  # Run ARIMA forecast
  stock_results <- arima_pipeline(
    data = prices,
    frequency = 1,
    forecast_horizon = 5
  )
  
  cat("\nNext 5 days forecast:\n")
  print(round(as.numeric(stock_results$forecast$mean), 2))
  
  # Calculate accuracy on training data
  fitted_values <- fitted(stock_results$model)
  train_accuracy <- calculate_accuracy(
    actual = prices[1:length(fitted_values)],
    predicted = as.numeric(fitted_values)
  )
  
} else {
  cat("\nNote: Sample stock data file not found at:", stock_file, "\n")
}

cat("\n")
cat("============================================\n")
cat("✅ Examples completed successfully!\n")
cat("============================================\n\n")
