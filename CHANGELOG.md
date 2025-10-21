# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive test suite using testthat framework
- GitHub Actions CI/CD pipeline for automated testing
- Input validation and error handling in all functions
- Sample stock price data for examples
- Usage examples in `examples/basic_usage.R`
- CONTRIBUTING.md with contribution guidelines
- LICENSE file (MIT)
- .gitignore file for R projects
- Installation verification script (`verify_installation.R`)

### Fixed
- Bug in `arima_forecast.R` line 112: Changed Python syntax `"=" * 60` to R syntax `paste(rep("=", 60), collapse = "")`
- Added proper error handling for edge cases (empty data, single values, etc.)

### Changed
- Updated README.md to accurately reflect implemented features
- Added CI/CD badge to README
- Improved INSTALL.R with better package installation handling
- Enhanced documentation with testing and contributing sections

### Improved
- Code quality with comprehensive input validation
- Error messages for better debugging
- Function documentation with roxygen2-style comments

## [1.0.0] - 2025-10-21

### Added
- Initial implementation of ARIMA forecasting model
- Basic README with comprehensive documentation
- Example code snippets for various forecasting scenarios
- Visualization examples (arima_forecast.png, garch_volatility.png)

[Unreleased]: https://github.com/galafis/r-time-series-forecasting-finance/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/galafis/r-time-series-forecasting-finance/releases/tag/v1.0.0
