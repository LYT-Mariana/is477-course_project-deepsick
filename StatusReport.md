# Status Report — Interim Project Update (Milestone 3)
**Author:** Yutong Liu, Bowei Wang
**Course:** IS 477 — Data Management, Curation & Reproducibility  
**Project:** Crime & Education Data Integration and Analysis  
**Date:** November 2025  

---

# 1. Introduction
This interim status report summarizes my progress on the IS 477 course project, which focuses on integrating U.S. crime statistics with state-level education staffing data to evaluate potential relationships between educational investment and crime outcomes. Over the past several weeks, major work has been completed on data acquisition, profiling, cleaning, integration, and repository organization. The project is on track for timely completion.

This report includes project updates, an updated timeline, changes to the original plan, and a summary of individual contributions.

---

# 2. Updates on Project Plan Tasks

## 2.1 Data Acquisition (Completed)
**Planned:** Collect state-level crime and education datasets.  
**Progress:**  
- Crime data (FBI UCR) downloaded from Kaggle and stored under `data/raw/`.  
- Education data (NCES CCD State Nonfiscal) downloaded, including multiple ZIP archives containing CSV and SAS files.  
- All raw files preserved exactly as provided.

**Status: Completed**

---

## 2.2 Repository Organization (Completed)
**Progress:**  
- Implemented structured repository:  
  - `/data/raw/`  
  - `/data/cleaned/`  
  - `/notebooks/`  
- Two major notebooks created:  
  - `crime_profiling&cleaning.ipynb`  
  - `education_profiling&cleaning.ipynb`  
- Integrated dataset exported to `/data/cleaned/integrated_data.csv`.

**Status: Completed**

---

## 2.3 Data Profiling (Completed)

### Crime Dataset
- Verified expected years (2015–2021).  
- Confirmed consistent 51 states per year.  
- Inspected structure, distribution, and missingness.

### Education Dataset
- Inspected >350 columns in each file.  
- Discovered extremely high missingness: >95% of columns unusable.  
- Identified core usable fields: `fipst`, `statename`, `staff`, `year`.

**Status: Completed**

---

## 2.4 Data Cleaning (Completed)

### Crime Data Cleaning
- Converted types and standardized state names.  
- Computed per-capita crime rates:  
  `crime_rate = (count / population) * 100000`  
- Exported cleaned dataset to `data/cleaned/crime_cleaned.csv`.

### Education Data Cleaning
- Dropped 341+ unusable columns (>95% missing).  
- Kept only: `fipst`, `statename`, `staff`, `year`.  
- Removed invalid territorial entries:  
  American Samoa, Guam, Puerto Rico, Northern Marianas, U.S. Virgin Islands, etc.  
- Standardized column names and formats.  
- Exported cleaned dataset to `data/cleaned/education_cleaned.csv`.

**Status: Completed**

---

## 2.5 Data Integration (Completed)

**Progress:**  
- Common valid years: **2015, 2017, 2019, 2021**.  
- Aggregated education staffing to *state-year* level.  
- Merged with crime dataset using inner join.  
- Output merged dataset with 204 fully aligned state-year rows.  
- Saved as `data/cleaned/integrated_data.csv`.

**Status: Completed**

---

# 3. Updated Project Timeline

| Task | Original Timeline | Current Status | Updated Timeline |
|------|-------------------|----------------|------------------|
| Data Acquisition | Week 6 | ✔ Completed | — |
| Profiling & Cleaning (Crime) | Week 7 | ✔ Completed | — |
| Profiling & Cleaning (Education) | Week 7–8 | ✔ Completed | — |
| Data Integration | Week 8 | ✔ Completed | — |
| Exploratory Data Analysis (EDA) | Week 12 | Not Started | Fall Break |
| Modeling & Statistical Analysis | Week 13 | Not Started | Fall Break |
| Ethics & Provenance | Week 10 | Not Started | Fall Break |
| Final Report & Presentation | Week 15 | Not Started | Fall Break |

---

# 4. Changes to the Original Project Plan

### 1. Education Data Needed Heavy Simplification  
Over 95% of education fields were unusable, requiring extensive column removal.

### 2. Year Alignment Adjusted  
Education data only had usable entries for 2015, 2017, 2019, and 2021—analysis will focus on these years.

### 3. Analysis Phase Clarified  
The next milestone will focus on EDA, modeling, and answering research questions instead of further data-related tasks.

### 4. Automation Pushed Slightly Later  
More time was allocated to profiling and integration than expected, shifting automation to Milestone 5.

---

# 5. Individual Contribution Summary (Yutong Liu, Bowei Wang)

- Downloading and organizing raw datasets  
- Writing all profiling and cleaning notebooks  
- Implementing extraction logic for NCES ZIP archives  
- Conducting missingness and column-quality analysis  
- Creating cleaned datasets for crime and education  
- Designing standardized folder structure  
- Merging datasets into integrated form  
- Writing repository documentation  
- Producing this Status Report  
- Preparing for analysis, modeling, and final evaluation  


# 6. Next Steps

With the integrated dataset completed, the next phase of the project focuses on analysis and interpretation aligned with the research questions. Remaining work includes:

- Conduct exploratory data analysis (EDA) to summarize trends in crime rates and education staffing.  
- Build statistical and predictive models to evaluate the association between education indicators and crime outcomes.  
- Develop visualizations (scatter plots, heatmaps, trends) to clearly communicate relationships.  
- Interpret model and visualization results in the context of the research questions.  
- Conduct final evaluation and summarize key findings.  
- Prepare and submit the final project report and presentation slides.

These steps will allow the project to transition from data preparation to deriving meaningful insights.

