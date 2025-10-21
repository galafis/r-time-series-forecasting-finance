# Project Documentation

## Overview

This project provides a production-ready implementation of ARIMA time series forecasting for financial data using R. The codebase is fully tested, documented, and includes CI/CD integration.

## Architecture

### Core Components

1. **ARIMA Forecasting Module** (`R/models/arima_forecast.R`)
   - Stationarity testing (ADF test)
   - Automatic ARIMA model selection
   - Forecast generation
   - Accuracy metrics calculation
   - Complete forecasting pipeline

2. **Test Suite** (`tests/`)
   - Unit tests for all functions
   - Integration tests for pipeline
   - Edge case handling
   - 15+ test cases

3. **CI/CD Pipeline** (`.github/workflows/r-tests.yml`)
   - Automated testing on push/PR
   - R environment setup
   - Dependency installation
   - Test execution

### Project Structure

```
r-time-series-forecasting-finance/
├── R/                          # Source code
│   └── models/
│       └── arima_forecast.R   # ARIMA implementation
├── tests/                      # Test suite
│   ├── run_tests.R            # Test runner
│   └── testthat/              # Test files
├── data/                       # Sample data
├── examples/                   # Usage examples
├── images/                     # Visualizations
├── .github/workflows/          # CI/CD
├── INSTALL.R                   # Dependency installer
├── verify_installation.R       # Installation checker
├── CONTRIBUTING.md             # Contribution guide
├── CHANGELOG.md                # Version history
├── LICENSE                     # MIT License
└── README.md                   # Main documentation
```

## Functions API

### `test_stationarity(ts_data)`

Tests if a time series is stationary using the Augmented Dickey-Fuller test.

**Parameters:**
- `ts_data`: Time series data (numeric vector or ts object)

**Returns:**
- List with `statistic`, `p_value`, and `is_stationary`

**Example:**
```r
result <- test_stationarity(ts(c(100, 102, 105, 103, 107)))
```

### `fit_arima_model(ts_data, seasonal = FALSE)`

Fits an ARIMA model with automatic parameter selection.

**Parameters:**
- `ts_data`: Time series data
- `seasonal`: Boolean for seasonal component

**Returns:**
- Fitted Arima model object

**Example:**
```r
model <- fit_arima_model(ts_data, seasonal = FALSE)
```

### `generate_forecast(model, h = 30)`

Generates forecasts from a fitted ARIMA model.

**Parameters:**
- `model`: Fitted Arima model
- `h`: Forecast horizon (number of periods)

**Returns:**
- forecast object with predictions and confidence intervals

**Example:**
```r
forecast_result <- generate_forecast(model, h = 10)
```

### `calculate_accuracy(actual, predicted)`

Calculates forecast accuracy metrics.

**Parameters:**
- `actual`: Actual values (numeric vector)
- `predicted`: Predicted values (numeric vector)

**Returns:**
- List with MAE, RMSE, and MAPE

**Example:**
```r
metrics <- calculate_accuracy(actual, predicted)
```

### `arima_pipeline(data, frequency = 1, forecast_horizon = 30)`

Complete ARIMA forecasting pipeline.

**Parameters:**
- `data`: Numeric vector of time series data
- `frequency`: Time series frequency (e.g., 12 for monthly)
- `forecast_horizon`: Number of periods to forecast

**Returns:**
- List with `model`, `forecast`, and `stationarity_test`

**Example:**
```r
results <- arima_pipeline(data, frequency = 1, forecast_horizon = 30)
```

## Testing

### Running Tests

```bash
# Run all tests
Rscript tests/run_tests.R

# Run specific test file
Rscript -e "library(testthat); test_file('tests/testthat/test_arima_forecast.R')"
```

### Test Coverage

The test suite covers:
- Function input validation
- Correct output structure
- Edge cases (short series, perfect predictions, etc.)
- Error handling
- Integration (full pipeline)

## Development

### Setting Up Development Environment

1. Clone repository:
   ```bash
   git clone https://github.com/galafis/r-time-series-forecasting-finance.git
   cd r-time-series-forecasting-finance
   ```

2. Install dependencies:
   ```bash
   Rscript INSTALL.R
   ```

3. Verify installation:
   ```bash
   Rscript verify_installation.R
   ```

4. Run tests:
   ```bash
   Rscript tests/run_tests.R
   ```

### Code Style Guidelines

- Use roxygen2-style documentation
- Add input validation to all functions
- Write tests for new functions
- Follow R naming conventions
- Keep functions focused and modular

### Git Workflow

1. Create feature branch: `git checkout -b feature/name`
2. Make changes and test
3. Commit with clear messages
4. Push and create PR
5. Wait for CI to pass
6. Request review

## CI/CD Pipeline

The GitHub Actions workflow:
1. Checks out code
2. Sets up R environment
3. Installs system dependencies
4. Installs R packages
5. Runs test suite
6. Reports results

## Security

- All dependencies from CRAN (trusted source)
- No secrets or credentials in code
- GITHUB_TOKEN has minimal permissions
- Input validation prevents injection attacks
- Regular dependency updates recommended

## Performance Considerations

- ARIMA fitting can be computationally intensive
- Large datasets may require significant time
- Consider using `stepwise=TRUE` for faster fitting
- Parallel processing not yet implemented

## Future Enhancements

Planned features (not yet implemented):
- SARIMA (Seasonal ARIMA)
- GARCH (volatility modeling)
- Prophet (Facebook's forecasting)
- ETS (Exponential Smoothing)
- Ensemble methods
- Interactive dashboard (Shiny)
- Real-time data integration
- Parallel processing support

## Troubleshooting

### Common Issues

**Issue:** Tests fail with "package not found"
**Solution:** Run `Rscript INSTALL.R` to install dependencies

**Issue:** "non-stationary series" warning
**Solution:** This is expected for some data; the model handles it automatically

**Issue:** Forecast seems unrealistic
**Solution:** Check data quality, consider data transformation, or try different model parameters

## Support

- Issues: GitHub Issues
- Discussions: GitHub Discussions
- Email: See CONTRIBUTING.md

## License

MIT License - see LICENSE file for details

## Citation

If you use this project in your research, please cite:

```
Gabriel Demetrios Lafis (2025). Time Series Forecasting for Financial Data with R.
GitHub repository: https://github.com/galafis/r-time-series-forecasting-finance
```
