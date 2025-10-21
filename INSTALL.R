# R packages required for time series forecasting
# Run this in R console or via: Rscript INSTALL.R

# Core packages for time series analysis
packages <- c(
  'forecast',   # Time series forecasting
  'tseries',    # Time series analysis and tests
  'ggplot2',    # Visualizations
  'quantmod',   # Financial data
  'zoo',        # Time series objects
  'xts',        # Extended time series
  'testthat'    # Testing framework
)

# Install packages if not already installed
for (pkg in packages) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(sprintf("Installing package: %s\n", pkg))
    install.packages(pkg, repos = "https://cran.r-project.org")
  } else {
    cat(sprintf("✓ Package already installed: %s\n", pkg))
  }
}

cat("\n✅ All required packages are installed!\n")
