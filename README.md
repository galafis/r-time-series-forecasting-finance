# Time Series Forecasting for Financial Data with R

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white) ![Tidyverse](https://img.shields.io/badge/Tidyverse-1E90FF?style=for-the-badge) ![Forecast](https://img.shields.io/badge/Forecast-FF6F00?style=for-the-badge) ![Prophet](https://img.shields.io/badge/Prophet-4267B2?style=for-the-badge)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

### 🚀 Quick Start

**Complete guide**: See [QUICKSTART.md](QUICKSTART.md) for a detailed 5-minute setup guide.

**Fast track:**
```bash
# 1. Clone repository
git clone https://github.com/galafis/r-time-series-forecasting-finance.git
cd r-time-series-forecasting-finance

# 2. Install dependencies
Rscript INSTALL.R

# 3. Run example
Rscript examples/basic_usage.R
```

---

## 🇧🇷 Previsão de Séries Temporais Financeiras com R

Repositório completo e profissional para **análise e previsão de séries temporais financeiras** utilizando **R**. Implementa modelos estatísticos clássicos (ARIMA, GARCH) e modernos (Prophet, LSTM) para prever preços de ações, volatilidade e retornos.

### 🎯 Objetivo

Fornecer um guia prático e completo sobre modelagem de séries temporais no domínio financeiro, cobrindo desde aquisição de dados até backtesting e avaliação de modelos em produção.

### 🌟 Por que R para Séries Temporais Financeiras?

R é a linguagem preferida para análise quantitativa em finanças:

| Característica | R | Python | Excel |
|----------------|---|--------|-------|
| **Pacotes Estatísticos** | ✅ Excelente (forecast, tseries) | ✅ Bom (statsmodels) | ❌ Limitado |
| **Visualizações** | ✅ ggplot2, plotly | ✅ matplotlib, seaborn | ❌ Básico |
| **Performance** | ✅ Rápido (C/Fortran) | ✅ Rápido (NumPy) | ❌ Lento |
| **Comunidade Financeira** | ✅ Muito forte | ✅ Crescente | ✅ Tradicional |
| **Reprodutibilidade** | ✅ RMarkdown | ✅ Jupyter | ❌ Manual |

### 📊 Casos de Uso Reais

1. **Hedge Funds**: Previsão de retornos de ações para estratégias quantitativas
2. **Bancos**: Modelagem de volatilidade para cálculo de VaR (Value at Risk)
3. **Fintechs**: Previsão de fluxo de caixa e receita
4. **Trading**: Sinais de compra/venda baseados em forecasts
5. **Risk Management**: Análise de cenários e stress testing

### 🏗️ Models Implemented

This repository currently implements **ARIMA** (AutoRegressive Integrated Moving Average) forecasting with comprehensive testing and CI/CD.

**Currently Available:**
1. ✅ **ARIMA** - AutoRegressive Integrated Moving Average (fully implemented and tested)

**Planned for Future Releases:**
2. ⏳ **SARIMA** - Seasonal ARIMA
3. ⏳ **GARCH** - Generalized AutoRegressive Conditional Heteroskedasticity
4. ⏳ **Prophet** - Facebook's forecasting tool
5. ⏳ **ETS** - Exponential Smoothing State Space
6. ⏳ **VAR** - Vector AutoRegression
7. ⏳ **TBATS** - Trigonometric seasonality, Box-Cox transformation, ARMA errors, Trend, Seasonal
8. ⏳ **Neural Network** - LSTM para séries temporais

### 📂 Estrutura do Repositório

```
r-time-series-forecasting-finance/
├── R/
│   └── models/
│       └── arima_forecast.R          # Modelo ARIMA completo com testes
├── tests/
│   ├── run_tests.R                   # Test runner
│   └── testthat/
│       └── test_arima_forecast.R     # Testes unitários ARIMA
├── data/
│   └── sample_stock_prices.csv       # Dados de exemplo
├── examples/
│   └── basic_usage.R                 # Exemplos de uso
├── images/
│   ├── arima_forecast.png            # Visualização de forecast
│   └── garch_volatility.png          # Visualização de volatilidade
├── INSTALL.R                         # Instalação de pacotes
├── CONTRIBUTING.md                   # Guia de contribuição
├── LICENSE                           # Licença MIT
└── README.md
```

### 🚀 Instalação e Configuração

#### 1. Pré-requisitos

- R version 4.0 or higher
- RStudio (recommended but optional)

**Instalar R:**
```bash
# Ubuntu/Debian
sudo apt-get install r-base r-base-dev

# macOS
brew install r

# Windows: Download from https://cran.r-project.org/
```

#### 2. Clonar o Repositório

```bash
git clone https://github.com/galafis/r-time-series-forecasting-finance.git
cd r-time-series-forecasting-finance
```

#### 3. Instalar Pacotes Necessários

```bash
# Método automático (recomendado)
Rscript INSTALL.R

# Ou instale manualmente no R console
R
```

```r
install.packages(c(
  "forecast",      # Modelos ARIMA, ETS
  "tseries",       # Testes de séries temporais
  "ggplot2",       # Visualizações
  "quantmod",      # Dados financeiros (opcional)
  "xts",           # Séries temporais estendidas
  "zoo",           # Objetos de séries temporais
  "testthat"       # Framework de testes
))
```

#### 4. Verificar Instalação

```bash
# Executar testes para verificar que tudo está funcionando
Rscript tests/run_tests.R
```

#### 5. Executar Exemplo

```bash
# Executar exemplo básico
Rscript examples/basic_usage.R
```

### 💻 Código Principal: Modelo ARIMA

```r
# ============================================
# ARIMA FORECASTING FOR FINANCIAL TIME SERIES
# ============================================

library(forecast)
library(tseries)
library(ggplot2)

# Função principal de forecasting ARIMA
arima_forecast <- function(data, periods = 30, confidence = 0.95) {
  
  # 1. Verificar estacionariedade
  adf_test <- adf.test(data)
  cat("ADF Test p-value:", adf_test$p.value, "\n")
  
  if (adf_test$p.value > 0.05) {
    cat("Series is non-stationary. Differencing...\n")
    data_diff <- diff(data)
  } else {
    data_diff <- data
  }
  
  # 2. Identificar ordem do modelo (auto.arima)
  model <- auto.arima(
    data,
    seasonal = FALSE,
    stepwise = TRUE,
    approximation = FALSE,
    trace = TRUE
  )
  
  cat("\nSelected Model:\n")
  print(summary(model))
  
  # 3. Diagnóstico do modelo
  checkresiduals(model)
  
  # 4. Fazer previsão
  forecast_result <- forecast(model, h = periods, level = confidence * 100)
  
  # 5. Plotar resultados
  plot(forecast_result, main = "ARIMA Forecast with Confidence Intervals")
  
  # 6. Retornar resultados
  return(list(
    model = model,
    forecast = forecast_result,
    accuracy = accuracy(model)
  ))
}

# Exemplo de uso com dados reais
library(quantmod)

# Baixar dados do Yahoo Finance
getSymbols("AAPL", from = "2020-01-01", to = Sys.Date())
prices <- Cl(AAPL)  # Closing prices

# Converter para série temporal
ts_data <- ts(prices, frequency = 252)  # 252 trading days

# Executar forecast
results <- arima_forecast(ts_data, periods = 30)

# Acessar resultados
cat("\nForecast for next 30 days:\n")
print(results$forecast)

cat("\nModel Accuracy:\n")
print(results$accuracy)
```

### 📈 Modelo GARCH para Volatilidade

```r
# ============================================
# GARCH MODEL FOR VOLATILITY FORECASTING
# ============================================

library(rugarch)
library(quantmod)

garch_volatility_forecast <- function(returns, periods = 30) {
  
  # 1. Especificar modelo GARCH(1,1)
  spec <- ugarchspec(
    variance.model = list(
      model = "sGARCH",
      garchOrder = c(1, 1)
    ),
    mean.model = list(
      armaOrder = c(1, 1),
      include.mean = TRUE
    ),
    distribution.model = "std"  # Student's t distribution
  )
  
  # 2. Estimar modelo
  fit <- ugarchfit(spec, returns)
  
  cat("GARCH Model Summary:\n")
  print(fit)
  
  # 3. Fazer previsão de volatilidade
  forecast_vol <- ugarchforecast(fit, n.ahead = periods)
  
  # 4. Plotar volatilidade prevista
  plot(forecast_vol, which = 1)
  
  # 5. Retornar resultados
  return(list(
    model = fit,
    forecast = forecast_vol,
    sigma = sigma(fit)  # Volatilidade condicional
  ))
}

# Exemplo de uso
getSymbols("^GSPC", from = "2020-01-01")  # S&P 500
returns <- dailyReturn(Cl(GSPC))

# Forecast volatilidade
vol_results <- garch_volatility_forecast(returns, periods = 30)
```

### 🔮 Facebook Prophet

```r
# ============================================
# FACEBOOK PROPHET FOR FINANCIAL FORECASTING
# ============================================

library(prophet)
library(dplyr)

prophet_forecast <- function(data, periods = 30) {
  
  # 1. Preparar dados no formato do Prophet
  df <- data.frame(
    ds = index(data),
    y = as.numeric(data)
  )
  
  # 2. Criar e treinar modelo
  model <- prophet(
    df,
    daily.seasonality = TRUE,
    weekly.seasonality = TRUE,
    yearly.seasonality = TRUE,
    changepoint.prior.scale = 0.05  # Flexibilidade de tendência
  )
  
  # 3. Criar dataframe de datas futuras
  future <- make_future_dataframe(model, periods = periods)
  
  # 4. Fazer previsão
  forecast <- predict(model, future)
  
  # 5. Plotar resultados
  plot(model, forecast)
  prophet_plot_components(model, forecast)
  
  # 6. Retornar resultados
  return(list(
    model = model,
    forecast = forecast,
    performance = prophet_performance(model, df)
  ))
}

# Função auxiliar para avaliar performance
prophet_performance <- function(model, df) {
  # Cross-validation
  cv_results <- cross_validation(
    model,
    initial = 365,
    period = 30,
    horizon = 30,
    units = "days"
  )
  
  # Calcular métricas
  metrics <- performance_metrics(cv_results)
  
  return(metrics)
}
```

### 🧪 Backtesting e Avaliação

```r
# ============================================
# BACKTESTING FRAMEWORK
# ============================================

backtest_model <- function(data, model_func, train_size = 0.8, horizon = 30) {
  
  n <- length(data)
  split_point <- floor(n * train_size)
  
  # Split data
  train <- data[1:split_point]
  test <- data[(split_point + 1):n]
  
  # Train model
  model <- model_func(train)
  
  # Make predictions
  predictions <- forecast(model, h = length(test))
  
  # Calculate metrics
  mae <- mean(abs(test - predictions$mean))
  rmse <- sqrt(mean((test - predictions$mean)^2))
  mape <- mean(abs((test - predictions$mean) / test)) * 100
  
  # Plot actual vs predicted
  plot(test, type = "l", col = "black", lwd = 2, 
       main = "Backtest: Actual vs Predicted",
       ylab = "Value", xlab = "Time")
  lines(predictions$mean, col = "red", lwd = 2)
  legend("topleft", legend = c("Actual", "Predicted"), 
         col = c("black", "red"), lwd = 2)
  
  # Return metrics
  return(list(
    mae = mae,
    rmse = rmse,
    mape = mape,
    predictions = predictions
  ))
}

# Exemplo de uso
results <- backtest_model(
  data = ts_data,
  model_func = function(x) auto.arima(x),
  train_size = 0.8,
  horizon = 30
)

cat("Backtest Results:\n")
cat("MAE:", results$mae, "\n")
cat("RMSE:", results$rmse, "\n")
cat("MAPE:", results$mape, "%\n")
```

### 🧪 Testing

The project includes a comprehensive test suite using the `testthat` framework.

**Run all tests:**
```bash
Rscript tests/run_tests.R
```

**Test coverage:**
- ✅ Stationarity testing
- ✅ Model fitting
- ✅ Forecast generation
- ✅ Accuracy calculations
- ✅ Pipeline integration
- ✅ Error handling and edge cases

### 🤝 Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Quick Start for Contributors:**
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run tests: `Rscript tests/run_tests.R`
5. Commit: `git commit -m 'Add amazing feature'`
6. Push: `git push origin feature/amazing-feature`
7. Open a Pull Request

### 📊 Métricas de Avaliação

| Métrica | Fórmula | Interpretação |
|---------|---------|---------------|
| **MAE** | `mean(abs(actual - predicted))` | Erro médio absoluto |
| **RMSE** | `sqrt(mean((actual - predicted)^2))` | Raiz do erro quadrático médio |
| **MAPE** | `mean(abs((actual - predicted) / actual)) * 100` | Erro percentual médio |
| **R²** | `1 - SS_res / SS_tot` | Variância explicada |
| **AIC** | `2k - 2ln(L)` | Critério de informação |
| **BIC** | `k*ln(n) - 2ln(L)` | Critério bayesiano |

### 🎓 Conceitos Técnicos

#### Estacionariedade

Uma série temporal é **estacionária** se:
- Média constante ao longo do tempo
- Variância constante ao longo do tempo
- Autocorrelação depende apenas do lag

**Testes:**
```r
# Augmented Dickey-Fuller Test
adf.test(data)

# KPSS Test
kpss.test(data)

# Phillips-Perron Test
pp.test(data)
```

#### Diferenciação

```r
# Primeira diferença
diff_1 <- diff(data, differences = 1)

# Segunda diferença
diff_2 <- diff(data, differences = 2)

# Diferença sazonal
diff_seasonal <- diff(data, lag = 12)
```

#### ACF e PACF

```r
# Autocorrelation Function
acf(data, lag.max = 40)

# Partial Autocorrelation Function
pacf(data, lag.max = 40)
```

### 💡 Melhores Práticas

1. **Sempre teste estacionariedade** antes de modelar
2. **Use validação cruzada temporal** (não aleatória)
3. **Combine múltiplos modelos** (ensemble)
4. **Monitore performance** em produção
5. **Atualize modelos** regularmente
6. **Documente premissas** e limitações
7. **Considere fatores externos** (eventos, notícias)

### 🔗 Recursos Adicionais

- [Forecasting: Principles and Practice (Hyndman)](https://otexts.com/fpp3/)
- [Time Series Analysis (CRAN Task View)](https://cran.r-project.org/web/views/TimeSeries.html)
- [Quantitative Finance with R](https://www.quantmod.com/)
- [Prophet Documentation](https://facebook.github.io/prophet/)

### 📚 Project Documentation

- **[QUICKSTART.md](QUICKSTART.md)** - 5-minute setup guide
- **[DOCUMENTATION.md](DOCUMENTATION.md)** - Complete API documentation
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Contribution guidelines
- **[CHANGELOG.md](CHANGELOG.md)** - Version history

### 🎯 Próximos Passos

- [ ] Adicionar modelos de Machine Learning (XGBoost, LSTM)
- [ ] Implementar ensemble de modelos
- [ ] Criar dashboard interativo com Shiny
- [ ] Adicionar análise de sentimento de notícias
- [ ] Implementar trading strategy baseada em forecasts

---

## 🇬🇧 Time Series Forecasting for Financial Data with R

Complete and professional repository for **financial time series analysis and forecasting** using **R**. Implements classical statistical models (ARIMA, GARCH) and modern approaches (Prophet, LSTM) to predict stock prices, volatility, and returns.

### 🚀 Quick Start

```r
# Install packages
source("INSTALL.R")

# Load libraries
library(forecast)
library(quantmod)

# Get data
getSymbols("AAPL", from = "2020-01-01")
prices <- Cl(AAPL)

# Forecast
model <- auto.arima(prices)
forecast_result <- forecast(model, h = 30)
plot(forecast_result)
```

### 🎓 Key Learnings

- ✅ Implement ARIMA, SARIMA, GARCH models
- ✅ Use Facebook Prophet for forecasting
- ✅ Perform backtesting and model evaluation
- ✅ Calculate financial risk metrics
- ✅ Build production-ready forecasting pipelines
- ✅ Apply time series cross-validation

---

**Author:** Gabriel Demetrios Lafis  
**License:** MIT  
**Last Updated:** October 2025
