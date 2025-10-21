# ================================================
# Unit Tests for ARIMA Forecasting Functions
# ================================================

library(testthat)
library(forecast)
library(tseries)

# Source the main file
source("../../R/models/arima_forecast.R")

# Test data setup
test_data <- c(100, 102, 105, 103, 107, 110, 108, 112, 115, 113, 
               118, 120, 119, 123, 125, 124, 128, 130, 129, 133)
test_ts <- ts(test_data, frequency = 1)

# ================================================
# Test: test_stationarity function
# ================================================
test_that("test_stationarity returns correct structure", {
  result <- test_stationarity(test_ts)
  
  # Check that result is a list
  expect_type(result, "list")
  
  # Check that result has required components
  expect_true("statistic" %in% names(result))
  expect_true("p_value" %in% names(result))
  expect_true("is_stationary" %in% names(result))
  
  # Check types
  expect_type(result$statistic, "double")
  expect_type(result$p_value, "double")
  expect_type(result$is_stationary, "logical")
  
  # Check p_value is between 0 and 1
  expect_true(result$p_value >= 0 && result$p_value <= 1)
})

# ================================================
# Test: fit_arima_model function
# ================================================
test_that("fit_arima_model returns valid ARIMA model", {
  model <- fit_arima_model(test_ts, seasonal = FALSE)
  
  # Check model class
  expect_s3_class(model, "Arima")
  
  # Check model has coefficients
  expect_true(length(coef(model)) > 0)
  
  # Check residuals exist
  expect_true(length(residuals(model)) > 0)
})

test_that("fit_arima_model handles seasonal parameter", {
  # Test with seasonal = FALSE
  model_non_seasonal <- fit_arima_model(test_ts, seasonal = FALSE)
  expect_s3_class(model_non_seasonal, "Arima")
  
  # Test with seasonal = TRUE (should still work even with frequency = 1)
  model_seasonal <- fit_arima_model(test_ts, seasonal = TRUE)
  expect_s3_class(model_seasonal, "Arima")
})

# ================================================
# Test: generate_forecast function
# ================================================
test_that("generate_forecast returns valid forecast object", {
  model <- fit_arima_model(test_ts, seasonal = FALSE)
  forecast_result <- generate_forecast(model, h = 5)
  
  # Check forecast class
  expect_s3_class(forecast_result, "forecast")
  
  # Check forecast has correct horizon
  expect_equal(length(forecast_result$mean), 5)
  
  # Check forecast has confidence intervals
  expect_true("lower" %in% names(forecast_result))
  expect_true("upper" %in% names(forecast_result))
  
  # Check forecast values are numeric
  expect_type(as.numeric(forecast_result$mean), "double")
})

test_that("generate_forecast respects horizon parameter", {
  model <- fit_arima_model(test_ts, seasonal = FALSE)
  
  # Test different horizons
  forecast_5 <- generate_forecast(model, h = 5)
  expect_equal(length(forecast_5$mean), 5)
  
  forecast_10 <- generate_forecast(model, h = 10)
  expect_equal(length(forecast_10$mean), 10)
})

# ================================================
# Test: calculate_accuracy function
# ================================================
test_that("calculate_accuracy computes correct metrics", {
  actual <- c(100, 105, 110, 115, 120)
  predicted <- c(101, 104, 111, 114, 121)
  
  metrics <- calculate_accuracy(actual, predicted)
  
  # Check structure
  expect_type(metrics, "list")
  expect_true("MAE" %in% names(metrics))
  expect_true("RMSE" %in% names(metrics))
  expect_true("MAPE" %in% names(metrics))
  
  # Check values are positive
  expect_true(metrics$MAE >= 0)
  expect_true(metrics$RMSE >= 0)
  expect_true(metrics$MAPE >= 0)
  
  # Check MAE calculation
  expected_mae <- mean(abs(actual - predicted))
  expect_equal(metrics$MAE, expected_mae)
  
  # Check RMSE calculation
  expected_rmse <- sqrt(mean((actual - predicted)^2))
  expect_equal(metrics$RMSE, expected_rmse)
})

test_that("calculate_accuracy handles perfect predictions", {
  actual <- c(100, 105, 110, 115, 120)
  predicted <- actual  # Perfect predictions
  
  metrics <- calculate_accuracy(actual, predicted)
  
  # All metrics should be 0 for perfect predictions
  expect_equal(metrics$MAE, 0)
  expect_equal(metrics$RMSE, 0)
  expect_equal(metrics$MAPE, 0)
})

# ================================================
# Test: arima_pipeline function (integration test)
# ================================================
test_that("arima_pipeline completes successfully", {
  result <- arima_pipeline(test_data, frequency = 1, forecast_horizon = 5)
  
  # Check structure
  expect_type(result, "list")
  expect_true("model" %in% names(result))
  expect_true("forecast" %in% names(result))
  expect_true("stationarity_test" %in% names(result))
  
  # Check model
  expect_s3_class(result$model, "Arima")
  
  # Check forecast
  expect_s3_class(result$forecast, "forecast")
  expect_equal(length(result$forecast$mean), 5)
  
  # Check stationarity test
  expect_type(result$stationarity_test, "list")
})

test_that("arima_pipeline handles different frequencies", {
  # Monthly data (frequency = 12)
  monthly_data <- rep(test_data, 3)
  result_monthly <- arima_pipeline(monthly_data, frequency = 12, forecast_horizon = 6)
  expect_s3_class(result_monthly$model, "Arima")
  
  # Daily data (frequency = 1)
  result_daily <- arima_pipeline(test_data, frequency = 1, forecast_horizon = 5)
  expect_s3_class(result_daily$model, "Arima")
})

# ================================================
# Test: Error handling and edge cases
# ================================================
test_that("functions handle edge cases appropriately", {
  # Very short time series
  short_ts <- ts(c(100, 105, 110), frequency = 1)
  
  # Should still work with short series
  expect_no_error({
    model <- fit_arima_model(short_ts, seasonal = FALSE)
    forecast_result <- generate_forecast(model, h = 2)
  })
})

test_that("calculate_accuracy handles single values", {
  actual <- c(100)
  predicted <- c(101)
  
  metrics <- calculate_accuracy(actual, predicted)
  
  expect_type(metrics, "list")
  expect_true(metrics$MAE > 0)
})

cat("\n✅ All ARIMA forecasting tests completed!\n")
