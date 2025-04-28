# 🏭 BeerBo Data Analyst Technical Challenge

This repository contains my completed technical challenge for BeerBo Printing. The objective was to conduct a detailed statistical analysis of manufacturing performance data from a beer bottle label printing company using SQL and Python.

---

## 📊 Project Overview

The analysis was performed on three datasets:

- **ProductionMetric.csv**: Captures production line activity (downtime, good/reject counts, run time)
- **Quality.csv**: Logs rejected units and reasons, linked to production events
- **DeviceProperty.csv**: Metadata about each device/line (type, plant, cycle time)

---

## 🔍 Key Analytical Goals

- Identify patterns in planned vs. unplanned downtime
- Calculate reject rates and analyze top quality issues
- Compare performance by line, shift, and team
- Merge and enrich data using all 3 sources
- Visualize operational KPIs and derive insights

---

## 🧠 Tools Used

- **SQL Server**: Querying, joining datasets, calculating KPIs
- **Python**: Pandas, Matplotlib, Seaborn for statistical analysis & visualization
- **Jupyter Notebook / VS Code**: Development environment
- **MS Word / Docx**: Summary report generation

---

## 📈 Visualizations

Included in the analysis:
- Bar Chart: Reject Rate by Device
- Boxplot: Unplanned Downtime by Device
- Histogram: Good Count Distribution
- Line Chart: Reject Rate vs. Output Efficiency
- Summary Statistics Tables

##📏 Statistical Testing Results (NEW)
To evaluate whether the differences observed between Teams, Shifts, and Lines were statistically significant, one-way ANOVA tests were performed.

Shifts (shift_display_name vs good_count):

P-value ≈ 0.0074

Interpretation: There is a statistically significant difference in production output across Shifts (p < 0.05).

Teams (team_display_name vs good_count):

P-value ≈ 0.1247

Interpretation: No statistically significant difference in production output between Teams (p > 0.05).

Lines:

Line-level statistical analysis was not performed, as the provided data did not contain a distinct Line identifier.



