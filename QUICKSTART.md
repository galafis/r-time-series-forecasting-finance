# Quick Start Guide

Get started with time series forecasting in just 5 minutes!

## Prerequisites

- R version 4.0 or higher
- Internet connection (for package installation)

## Step 1: Install R

### Linux (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install r-base r-base-dev
```

### macOS
```bash
brew install r
```

### Windows
Download and install from [CRAN](https://cran.r-project.org/)

## Step 2: Clone the Repository

```bash
git clone https://github.com/galafis/r-time-series-forecasting-finance.git
cd r-time-series-forecasting-finance
```

## Step 3: Install Dependencies

```bash
Rscript INSTALL.R
```

This will install all required R packages:
- forecast (ARIMA models)
- tseries (statistical tests)
- ggplot2 (visualization)
- zoo, xts (time series objects)
- testthat (testing)

## Step 4: Verify Installation

```bash
Rscript verify_installation.R
```

You should see:
```
✅ All required packages are installed!
✅ All function tests passed!
```

## Step 5: Run Your First Forecast

### Option A: Use the Example Script

```bash
Rscript examples/basic_usage.R
```

This will:
1. Generate synthetic time series data
2. Fit an ARIMA model
3. Create forecasts
4. Display results

### Option B: Interactive R Session

Start R:
```bash
R
```

Run forecasting code:
```r
# Load the functions
source("R/models/arima_forecast.R")

# Create sample data
data <- c(100, 102, 105, 103, 107, 110, 108, 112, 115, 113, 
          118, 120, 119, 123, 125, 124, 128, 130, 129, 133)

# Run the pipeline
results <- arima_pipeline(
  data = data,
  frequency = 1,
  forecast_horizon = 5
)

# View forecast
print(results$forecast)

# View model summary
summary(results$model)
```

### Option C: Use Real Stock Data

```r
source("R/models/arima_forecast.R")

# Read sample stock data
stock_data <- read.csv("data/sample_stock_prices.csv")
prices <- stock_data$Close

# Forecast next 5 days
results <- arima_pipeline(
  data = prices,
  frequency = 1,
  forecast_horizon = 5
)

# View predictions
cat("Next 5 days forecast:\n")
print(round(results$forecast$mean, 2))
```

## Step 6: Run Tests (Optional)

Verify everything works:
```bash
Rscript tests/run_tests.R
```

## Common First-Time Issues

### Issue: "command not found: R"
**Solution:** R is not installed or not in PATH. Install R first.

### Issue: Package installation fails
**Solution:** Install system dependencies:
```bash
# Ubuntu/Debian
sudo apt-get install libcurl4-openssl-dev libssl-dev libxml2-dev

# macOS
brew install openssl curl
```

### Issue: Permission denied
**Solution:** Run with appropriate permissions or install in user library.

## Next Steps

1. **Learn the basics**: Read [DOCUMENTATION.md](DOCUMENTATION.md)
2. **Explore examples**: Check files in `examples/` directory
3. **Understand the model**: Read `R/models/arima_forecast.R`
4. **Try with your data**: Load your own time series data
5. **Contribute**: See [CONTRIBUTING.md](CONTRIBUTING.md)

## Getting Help

- **Documentation**: See [DOCUMENTATION.md](DOCUMENTATION.md)
- **Issues**: [GitHub Issues](https://github.com/galafis/r-time-series-forecasting-finance/issues)
- **Examples**: Check the `examples/` directory

## Quick Reference

### Key Functions

| Function | Purpose |
|----------|---------|
| `test_stationarity()` | Test if series is stationary |
| `fit_arima_model()` | Fit ARIMA model |
| `generate_forecast()` | Generate predictions |
| `calculate_accuracy()` | Calculate error metrics |
| `arima_pipeline()` | Complete forecasting workflow |

### Key Files

| File | Purpose |
|------|---------|
| `INSTALL.R` | Install dependencies |
| `verify_installation.R` | Check setup |
| `examples/basic_usage.R` | Usage examples |
| `tests/run_tests.R` | Run test suite |

## Success!

You're now ready to forecast time series data! 🎉

For more advanced usage, see [DOCUMENTATION.md](DOCUMENTATION.md) and the main [README.md](README.md).
