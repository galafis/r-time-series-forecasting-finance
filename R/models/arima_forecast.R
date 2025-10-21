# ================================================
# ARIMA Time Series Forecasting
# Author: Gabriel Demetrios Lafis
# Description: ARIMA models for financial time series forecasting
# ================================================

library(forecast)
library(tseries)
library(ggplot2)

#' Perform stationarity test (Augmented Dickey-Fuller)
#' 
#' @param ts_data Time series data
#' @return List with test results
test_stationarity <- function(ts_data) {
  # Input validation
  if (!is.ts(ts_data) && !is.numeric(ts_data)) {
    stop("Input must be a time series or numeric vector")
  }
  
  if (length(ts_data) < 3) {
    stop("Time series must have at least 3 observations")
  }
  
  adf_test <- adf.test(ts_data, alternative = "stationary")
  
  result <- list(
    statistic = adf_test$statistic,
    p_value = adf_test$p.value,
    is_stationary = adf_test$p.value < 0.05
  )
  
  cat("Augmented Dickey-Fuller Test\n")
  cat("============================\n")
  cat(sprintf("Test Statistic: %.4f\n", result$statistic))
  cat(sprintf("P-value: %.4f\n", result$p_value))
  cat(sprintf("Is Stationary: %s\n", ifelse(result$is_stationary, "YES", "NO")))
  cat("\n")
  
  return(result)
}

#' Fit ARIMA model with automatic parameter selection
#' 
#' @param ts_data Time series data
#' @param seasonal Boolean indicating if seasonal component exists
#' @return Fitted ARIMA model
fit_arima_model <- function(ts_data, seasonal = FALSE) {
  # Input validation
  if (!is.ts(ts_data) && !is.numeric(ts_data)) {
    stop("Input must be a time series or numeric vector")
  }
  
  if (length(ts_data) < 10) {
    warning("Time series is very short. Model may not be reliable.")
  }
  
  cat("Fitting ARIMA model...\n")
  
  # Automatic ARIMA model selection
  model <- auto.arima(
    ts_data,
    seasonal = seasonal,
    stepwise = FALSE,
    approximation = FALSE,
    trace = TRUE
  )
  
  cat("\nModel Summary:\n")
  print(summary(model))
  
  # Check residuals
  cat("\nResidual Diagnostics:\n")
  checkresiduals(model)
  
  return(model)
}

#' Generate forecasts from ARIMA model
#' 
#' @param model Fitted ARIMA model
#' @param h Forecast horizon
#' @return Forecast object
generate_forecast <- function(model, h = 30) {
  # Input validation
  if (!inherits(model, "Arima")) {
    stop("Model must be an Arima object")
  }
  
  if (h <= 0) {
    stop("Forecast horizon must be positive")
  }
  
  cat(sprintf("\nGenerating %d-step ahead forecast...\n", h))
  
  forecast_result <- forecast(model, h = h)
  
  # Plot forecast
  plot(forecast_result, main = "ARIMA Forecast", 
       xlab = "Time", ylab = "Value")
  
  return(forecast_result)
}

#' Calculate forecast accuracy metrics
#' 
#' @param actual Actual values
#' @param predicted Predicted values
#' @return List of accuracy metrics
calculate_accuracy <- function(actual, predicted) {
  # Input validation
  if (!is.numeric(actual) || !is.numeric(predicted)) {
    stop("Actual and predicted values must be numeric")
  }
  
  if (length(actual) != length(predicted)) {
    stop("Actual and predicted values must have the same length")
  }
  
  if (length(actual) == 0) {
    stop("Cannot calculate accuracy for empty vectors")
  }
  
  errors <- actual - predicted
  
  mae <- mean(abs(errors))
  rmse <- sqrt(mean(errors^2))
  mape <- mean(abs(errors / actual)) * 100
  
  metrics <- list(
    MAE = mae,
    RMSE = rmse,
    MAPE = mape
  )
  
  cat("\nForecast Accuracy Metrics:\n")
  cat("==========================\n")
  cat(sprintf("MAE:  %.4f\n", mae))
  cat(sprintf("RMSE: %.4f\n", rmse))
  cat(sprintf("MAPE: %.2f%%\n", mape))
  
  return(metrics)
}

#' Complete ARIMA forecasting pipeline
#' 
#' @param data Numeric vector of time series data
#' @param frequency Frequency of the time series (e.g., 12 for monthly)
#' @param forecast_horizon Number of periods to forecast
#' @return List containing model and forecast
arima_pipeline <- function(data, frequency = 1, forecast_horizon = 30) {
  # Input validation
  if (!is.numeric(data)) {
    stop("Data must be a numeric vector")
  }
  
  if (length(data) < 10) {
    stop("Time series must have at least 10 observations")
  }
  
  if (frequency < 1) {
    stop("Frequency must be at least 1")
  }
  
  if (forecast_horizon <= 0) {
    stop("Forecast horizon must be positive")
  }
  
  cat(paste(rep("=", 60), collapse = ""), "\n")
  cat("ARIMA TIME SERIES FORECASTING PIPELINE\n")
  cat(paste(rep("=", 60), collapse = ""), "\n\n")
  
  # Create time series object
  ts_data <- ts(data, frequency = frequency)
  
  # Plot original series
  plot(ts_data, main = "Original Time Series", 
       xlab = "Time", ylab = "Value")
  
  # Test stationarity
  stationarity <- test_stationarity(ts_data)
  
  # Fit ARIMA model
  model <- fit_arima_model(ts_data, seasonal = (frequency > 1))
  
  # Generate forecast
  forecast_result <- generate_forecast(model, h = forecast_horizon)
  
  # Return results
  result <- list(
    model = model,
    forecast = forecast_result,
    stationarity_test = stationarity
  )
  
  cat("\nPipeline completed successfully!\n")
  
  return(result)
}

# Example usage
if (interactive()) {
  # Generate sample data (random walk with trend)
  set.seed(42)
  n <- 200
  trend <- seq(100, 150, length.out = n)
  noise <- rnorm(n, 0, 5)
  sample_data <- trend + cumsum(noise)
  
  # Run pipeline
  results <- arima_pipeline(sample_data, frequency = 1, forecast_horizon = 30)
  
  # Access results
  print(results$model)
  print(results$forecast)
}
