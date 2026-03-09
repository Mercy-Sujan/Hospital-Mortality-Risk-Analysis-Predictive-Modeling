# Hospital Mortality Risk Analysis & Predictive Modeling

![R](https://img.shields.io/badge/R-Statistical%20Analysis-blue) ![PowerBI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow) ![Accuracy](https://img.shields.io/badge/Model%20Accuracy-92%25-brightgreen) ![Domain](https://img.shields.io/badge/Domain-Healthcare-red)

## 📌 Overview
Multi-source hospital patient data analysis to identify key **ICU mortality risk factors** and improve clinical decision support. This project combines statistical modeling with interactive dashboards to deliver actionable insights for hospital resource allocation.

## 🎯 Business Question
*Which patient and clinical factors most strongly predict ICU mortality — and how can these insights improve hospital resource prioritization?*

## 🛠️ Tools & Technologies
| Category | Tools |
|---|---|
| Language | R (dplyr, ggplot2, caret, tidyverse) |
| Modeling | Logistic Regression, Decision Tree, KNN |
| Dimensionality Reduction | PCA |
| Visualization | Power BI (interactive dashboards) |
| Evaluation | Confusion Matrix, Precision-Recall, ROC-AUC |

## 📊 Key Results
- ✅ **~92% classification accuracy** across all three models
- ✅ Identified top ICU mortality predictors via PCA and feature selection
- ✅ Interactive Power BI dashboard visualizing ICU trends and risk indicators
- ✅ Actionable insights delivered for hospital resource allocation and response prioritization

## 🔍 Project Workflow
1. **Data Integration** — cleaned and merged multi-source clinical datasets using R
2. **EDA** — distribution analysis, missing value treatment, outlier detection
3. **Feature Selection** — identified high-impact predictors using correlation analysis and PCA
4. **Modeling** — built and compared Logistic Regression, Decision Tree, and KNN classifiers
5. **Evaluation** — assessed models using confusion matrix, precision-recall, and ROC metrics
6. **Dashboard** — developed Power BI visualizations for ICU trends and mortality risk factors

## 📁 Repository Structure
```
hospital-mortality-prediction/
│
├── data/
│   └── README.md              # Data description (clinical data not included for privacy)
│
├── notebooks/
│   ├── 01_data_cleaning.R
│   ├── 02_eda_analysis.R
│   ├── 03_feature_selection.R
│   └── 04_modeling_evaluation.R
│
├── dashboards/
│   └── ICU_Mortality_Dashboard.pbix
│
├── visualizations/
│   └── (charts and model performance plots)
│
└── README.md
```

## 📊 Model Performance Summary
| Model | Accuracy | Notes |
|---|---|---|
| Logistic Regression | ~92% | Strongest interpretability |
| Decision Tree | ~92% | Best for feature importance |
| KNN | ~91% | Baseline comparison |

## 💡 Key Takeaways
- Age, prior diagnoses, and ICU admission type are top mortality predictors
- PCA effectively reduced dimensionality while retaining predictive power
- Power BI dashboards enable non-technical clinical staff to act on model insights

---
*Project completed as part of MS Business Analytics — Hofstra University*
