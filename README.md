# Time Series Forecasting for Financial Data with R

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white) ![Forecast](https://img.shields.io/badge/Forecast-FF6F00?style=for-the-badge)

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

Repositório para **análise e previsão de séries temporais financeiras** utilizando **R**. Atualmente implementa modelagem ARIMA para prever preços de ações e retornos, com planos de adicionar mais modelos futuramente.

### 🎯 Objetivo

Fornecer um guia prático sobre modelagem de séries temporais no domínio financeiro, demonstrando o uso de ARIMA para previsão e avaliação de modelos.

### 🌟 Por que R para Séries Temporais Financeiras?

R é amplamente utilizado para análise quantitativa em finanças:

| Característica | R | Python | Excel |
|----------------|---|--------|-------|
| **Pacotes Estatísticos** | ✅ Excelente (forecast, tseries) | ✅ Bom (statsmodels) | ❌ Limitado |
| **Visualizações** | ✅ ggplot2, plotly | ✅ matplotlib, seaborn | ❌ Básico |
| **Performance** | ✅ Rápido (C/Fortran) | ✅ Rápido (NumPy) | ❌ Lento |
| **Comunidade Financeira** | ✅ Muito forte | ✅ Crescente | ✅ Tradicional |
| **Reprodutibilidade** | ✅ RMarkdown | ✅ Jupyter | ❌ Manual |

### 📊 Exemplos de Aplicação

1. **Previsão de preços**: Projetar preços de fechamento de ações
2. **Análise de tendência**: Identificar padrões em dados financeiros
3. **Avaliação de modelos**: Comparar métricas de acurácia (MAE, RMSE, MAPE)

### 🏗️ Models Implemented

This repository currently implements **ARIMA** (AutoRegressive Integrated Moving Average) forecasting with a full test suite.

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

### 🧪 Testing

The project includes a test suite using the `testthat` framework.

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

### 🎯 Próximos Passos

- [ ] Adicionar modelos de Machine Learning (XGBoost, LSTM)
- [ ] Implementar ensemble de modelos
- [ ] Criar dashboard interativo com Shiny
- [ ] Adicionar análise de sentimento de notícias
- [ ] Implementar trading strategy baseada em forecasts

---

## 🇬🇧 Time Series Forecasting for Financial Data with R

Repository for **financial time series analysis and forecasting** using **R**. Currently implements ARIMA modeling for predicting stock prices and returns, with plans to add more models over time.

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

- ✅ Implement ARIMA forecasting models
- ✅ Perform backtesting and model evaluation
- ✅ Calculate forecast accuracy metrics (MAE, RMSE, MAPE)
- ✅ Test stationarity with the Augmented Dickey-Fuller test
- ✅ Build end-to-end forecasting pipelines in R

---

**Author:** Gabriel Demetrios Lafis  
**License:** MIT  
**Last Updated:** October 2025
