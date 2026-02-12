# Contributing to Time Series Forecasting for Financial Data

Thank you for your interest in contributing! This guide will help you get started.

## 🚀 Getting Started

1. **Fork the repository** and clone it locally
2. **Install dependencies**: Run `Rscript INSTALL.R`
3. **Create a branch** for your feature: `git checkout -b feature/your-feature-name`
4. **Make your changes** following our coding standards
5. **Test your changes**: Run `Rscript tests/run_tests.R`
6. **Commit your changes**: Use clear, descriptive commit messages
7. **Push to your fork** and **submit a pull request**

## 📋 Contribution Guidelines

### Code Style

- Follow R coding conventions
- Use meaningful variable and function names
- Add comments for complex logic
- Document all functions with roxygen2-style comments:
  ```r
  #' Function description
  #' 
  #' @param param_name Parameter description
  #' @return Return value description
  ```

### Testing

- Write tests for all new functions
- Ensure all existing tests pass before submitting
- Aim for high test coverage
- Tests should be in `tests/testthat/test_*.R`

### Documentation

- Update README.md if you add new features
- Add code examples for new functions
- Keep documentation clear and concise

## 🐛 Bug Reports

When reporting bugs, please include:

1. **Description**: Clear description of the bug
2. **Steps to reproduce**: How to trigger the bug
3. **Expected behavior**: What should happen
4. **Actual behavior**: What actually happens
5. **Environment**: R version, OS, package versions
6. **Code sample**: Minimal reproducible example

## 💡 Feature Requests

We welcome feature suggestions! Please:

1. Check if the feature already exists or is planned
2. Describe the feature and its use case
3. Explain why it would be valuable
4. Provide examples if possible

## 📝 Pull Request Process

1. Update documentation for any changed functionality
2. Add tests for new features
3. Ensure all tests pass
4. Request review from maintainers

### PR Checklist

- [ ] Code follows project style guidelines
- [ ] Tests added/updated and passing
- [ ] Documentation updated
- [ ] Commit messages are clear
- [ ] Branch is up to date with main

## 🤝 Code of Conduct

Be respectful, inclusive, and professional in all interactions.

## ❓ Questions

If you have questions, please:
- Check existing issues and discussions
- Open a new issue with the "question" label
- Reach out to maintainers

Thank you for contributing! 🎉
