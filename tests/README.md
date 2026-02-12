# Tests

This directory contains the test suite for the time series forecasting project.

## Structure

```
tests/
├── run_tests.R                     # Main test runner
└── testthat/
    └── test_arima_forecast.R       # Tests for ARIMA functions
```

## Running Tests

### Run All Tests

```bash
# From project root
Rscript tests/run_tests.R
```

### Run Specific Test File

```bash
Rscript -e "library(testthat); test_file('tests/testthat/test_arima_forecast.R')"
```

### Run Tests from R Console

```r
library(testthat)
test_dir("tests/testthat")
```

## Test Coverage

### test_arima_forecast.R

Tests for all ARIMA forecasting functions:

1. **test_stationarity()**
   - Returns correct structure
   - Validates output types
   - P-value is between 0 and 1

2. **fit_arima_model()**
   - Returns valid ARIMA model
   - Handles seasonal parameter
   - Works with different data types

3. **generate_forecast()**
   - Returns valid forecast object
   - Respects horizon parameter
   - Includes confidence intervals

4. **calculate_accuracy()**
   - Computes correct metrics (MAE, RMSE, MAPE)
   - Handles perfect predictions
   - Handles single values

5. **arima_pipeline()**
   - Completes successfully (integration test)
   - Handles different frequencies
   - Returns all expected components

6. **Edge Cases**
   - Short time series
   - Single values
   - Empty vectors
   - Invalid inputs

## Test Statistics

- **Total Tests**: 15+
- **Test Files**: 1
- **Coverage Areas**: 5 main functions + pipeline
- **Edge Cases**: 5+

## Writing New Tests

When adding new functionality, follow this structure:

```r
# Load dependencies
library(testthat)
source("../../R/models/your_file.R")

# Test: function_name does something
test_that("function_name does something", {
  # Setup
  input <- c(1, 2, 3)
  
  # Execute
  result <- your_function(input)
  
  # Assert
  expect_type(result, "list")
  expect_true("key" %in% names(result))
  expect_equal(result$value, expected_value)
})
```

## Test Guidelines

1. **Descriptive Names**: Use clear test descriptions
2. **AAA Pattern**: Arrange, Act, Assert
3. **One Assertion per Test**: Focus each test
4. **Edge Cases**: Test boundary conditions
5. **Error Cases**: Test error handling

## Troubleshooting

### Tests Pass But Code Still Has Issues

- Add more edge case tests
- Check test assertions are correct
- Consider integration tests

### Test Timeout

- Reduce data size in tests
- Use mock data instead of real data
- Set reasonable timeout values

## Future Test Additions

As the project grows, add tests for:
- SARIMA models (when implemented)
- GARCH models (when implemented)
- Performance benchmarks
- Data preprocessing functions
- Visualization functions

## Test Results

Expected output when all tests pass:

```
✓ | OK F W S | Context
✓ | 15       | test_arima_forecast

══ Results ═══════════════════════════════════════
Duration: X.X s

OK:       15
Failed:   0
Warnings: 0
Skipped:  0

✅ All ARIMA forecasting tests completed!
```

## Contributing Tests

When contributing:
1. Write tests for new features
2. Ensure all tests pass
3. Maintain test coverage above 80%
4. Follow existing test patterns
5. Document test purpose

See [CONTRIBUTING.md](../CONTRIBUTING.md) for more details.
