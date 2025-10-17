## Overview

In this project, we will investigate how education levels and school system characteristics relate to crime rates across U.S. states. By integrating two official federal datasets — the **FBI Uniform Crime Reporting (UCR) Program** and the **NCES Common Core of Data (CCD)** — we aim to explore whether variations in education indicators correspond with differences in violent and property crime rates over time.

### Motivation
Education and public safety are deeply intertwined aspects of social well-being. While policymakers often treat them as separate domains, evidence suggests that educational opportunities can influence community stability and long-term crime trends. By bringing these data sources together, we aim to provide a data-driven view of how state-level education metrics align with reported crime patterns.

### Scope
We will focus on state-level data from past ten years (2015–2024) to ensure compatibility between datasets. Crime data will be obtained from the **FBI Crime Data Explorer (UCR)**, which reports annual state crime counts and rates for categories such as violent crime, property crime and burglary. Education data will be obtained from the **NCES CCD State Nonfiscal Survey**, which provides comparable annual measures of graduation rates, enrollment, teacher counts and student–teacher ratios.

These datasets will be connected by state name and reporting year to construct a combined analytical dataset. Statistical summaries, correlations, and visualizations will be used to characterize the relationship between education and crime. We will also consider potential confounders such as population size and reporting differences.

### Expected Contributions
- A reproducible dataset integrating **FBI UCR crime data** and **NCES CCD education data** by state and year.
- Visualizations showing trends and geographic variation in crime and education indicators.
- Quantitative analysis assessing the association between education and crime levels.
- A fully documented workflow covering data acquisition, integration, cleaning and analysis.

## Research Questions

This project is guided by the following research questions:

1. **How do education levels relate to crime rates across U.S. states?**  
   - Specifically, do states with higher high-school graduation rates or lower student–teacher ratios exhibit lower violent or property crime rates?

2. **How have these relationships changed over time (2015–2024)?**  
   - Are trends in education improvement associated with declining crime, or do they vary by crime type or region?

3. **Which education factors appear most strongly correlated with crime outcomes?**  
   - For example, does overall graduation rate or teacher availability show the strongest statistical relationship with violent-crime rate?

4. **Can we identify geographic clusters or regional patterns in education and crime?**  
   - Are there regions (e.g., South, Midwest, Northeast) where the association between education and crime differs noticeably?

### Analytical Framing
Each question will be approached through descriptive statistics, correlation and regression analysis, and geographic or temporal visualization.  
Our focus is on **association, not causation**: the goal is to find measurable patterns between education metrics and crime rates rather than claiming direct effects.

## Datasets

Our analysis will combine two publicly available, state-level datasets to explore the relationship between education levels and crime rates in the United States from **2015 to 2024**.

### 1. FBI Summary Reporting System (SRS) – Crime Data
- **Source:** [FBI Crime Data Explorer – Summary Reporting System (SRS)](https://cde.ucr.cjis.gov/LATEST/webapp/#/pages/downloads)
- **File:** `estimated_crimes_1979_2024.csv`
- **Coverage:** 1979–2024 (we will subset to 2015–2024)
- **Description:**  
  This dataset provides state-level estimates of reported crimes compiled through the Uniform Crime Reporting (UCR) Program. Each record includes annual totals of major offense categories and population estimates for all 50 states and D.C.  
- **Key Variables:**  
  - `state_name` – State or District name  
  - `data_year` – Year of record  
  - `population` – Estimated population  
  - `violent_crime` – Total violent crimes  
  - `property_crime` – Total property crimes  
  - `murder`, `robbery`, `burglary`, `larceny`, `motor_vehicle_theft` – Specific offense counts  
- **Use in analysis:**  
  The dataset will be filtered to 2015–2024 and used to calculate per-capita crime rates (e.g., violent crimes per 100 000 residents) for each state and year.

### 2. NCES Common Core of Data (CCD) – Education Data
- **Source:** [National Center for Education Statistics (NCES) – Common Core of Data (CCD)](https://nces.ed.gov/ccd/data_tables.asp)
- **Files:**  
  - `stmem23.txt` – *State Membership* (student enrollment counts)  
  - `stf23.txt` – *State Staff* (teacher and staff counts)  
- **Coverage:** 2015–2024 (annual releases by school year)
- **Description:**  
  The CCD State Nonfiscal Public Elementary/Secondary Education Survey Data provide aggregated information on public school enrollment and staffing for each state. These files include total student membership and full-time-equivalent teacher counts, allowing computation of key education indicators.
- **Key Variables:**  
  - `STATE` – State name or abbreviation  
  - `MEMBER` – Total student enrollment  
  - `FTE` – Full-time-equivalent teacher count  
  - `SCHOOL_YEAR` – School year of record  
- **Use in analysis:**  
  The education data will be used to construct metrics such as student-teacher ratio and total enrollment per state per year.  

### Integration Plan
The two datasets will be merged on matching state and year fields (`state_name` ↔ `STATE`, `data_year` ↔ `SCHOOL_YEAR`). The combined dataset (2015–2024) will support regression and correlation analyses to assess how education indicators relate to crime rates across U.S. states.

## Team and Timeline

### Team

Our team is composed of two undergraduate students collaborating to investigate the relationship between education levels and crime rates across U.S. states (2015–2024). Each member has a distinct role to ensure smooth progress from data collection to analysis and presentation.

| Member | Role | Responsibilities |
|:--|:--|:--|
| **Yutong Liu** **Bowei Wang**| Project Manager | Oversees the project timeline, ensures each stage is completed as planned, and manages overall progress to keep the project on track. |
| **Yutong Liu** **Bowei Wang**| Data Preprocessor | Collects raw data from both sources (FBI SRS and NCES CCD), handles data integration and cleaning, and ensures consistent formatting across years. |
| **Yutong Liu** **Bowei Wang**| Data Analyst | Performs statistical analysis and modeling to evaluate relationships between education indicators and crime rates, generating insights from the integrated dataset. |
| **Yutong Liu** **Bowei Wang**| Reporter | Writes summaries and interprets results, connects findings to the research questions, and compiles the final report and presentation. |

Each member will also participate in weekly check-ins to review milestones, verify data integrity, and ensure analytical consistency.

---

### Timeline

| Week | Task | Description | Responsible |
|:--:|:--|:--|:--|
| **Week 1** | **Finalize Research Focus & Data Sources** | Define research questions, select final datasets (FBI SRS + NCES CCD), and outline project scope. | Project Manager & Entire Team |
| **Week 2** | **Data Collection & Preprocessing** | Download raw data files, clean and standardize variables, and ensure alignment between education and crime datasets. | Data Preprocessor |
| **Week 3** | **Data Integration & Feature Creation** | Merge the two datasets by state and year, compute derived metrics, and validate data accuracy. | Project Manager & Data Preprocessor |
| **Week 4** | **Analysis & Visualization** | Perform statistical and correlation analysis to explore relationships between education indicators and crime rates; produce charts and tables. | Data Analyst & Reporter |
| **Week 5** | **Reporting & Final Presentation** | Interpret analytical results, answer research questions clearly, and compile the final report and presentation slides. | Reporter & Project Manager |

---

**Communication Plan:**  
- Weekly progress meetings (virtual)  
- Shared Google Drive folder for dataset versions and Python scripts  
- GitHub repository for reproducible code and documentation  
- Chat group for daily coordination and issue tracking

## Constraints and Gaps

Although our proposed project leverages reputable public datasets, several limitations may affect the scope, accuracy and interpretability of our results.

### 1. Data Availability and Consistency
- **Temporal gaps:** The FBI and NCES datasets may not align perfectly by year; for instance, NCES data are organized by *school year* (e.g., 2023–24), while FBI data use *calendar year* (e.g., 2023). We will address this by aligning school years with the corresponding calendar year.
- **Incomplete state reporting:** Certain states or years may have missing or suppressed data due to reporting inconsistencies, especially during transitions between legacy UCR and NIBRS reporting systems.
- **Variable definitions:** Education variables such as “full-time equivalent teachers” or “membership counts” may have slight definitional changes across years, which can introduce subtle biases when measuring trends from 2015–2024.

### 2. Measurement and Methodological Constraints
- **Aggregated data:** Both datasets are state-level summaries, so our analysis cannot capture within-state disparities (e.g., difference between urban and rural areas). The results will reflect *broad correlations*, not individual or district-level causation.
- **Causality limitations:** Correlation between education levels and crime rates does not imply a causal relationship. External socioeconomic and policy factors (e.g., income, unemployment, or policing strategies) may mediate or confound observed associations.
- **Scaling differences:** The FBI and NCES datasets use different population bases (total residents vs. enrolled students), requiring normalization (e.g., per 100,000 residents or per 1,000 students) to ensure comparability.

### 3. Ethical and Interpretive Considerations
- **Representation bias:** Crime reporting rates differ across states and years due to social, economic, and political factors. These differences can reflect reporting behavior rather than actual crime incidence.
- **Responsible communication:** Since our findings may intersect with public policy discussions, we will emphasize descriptive and comparative insights rather than deterministic claims about cause and effect.

### 4. Future Data Enhancements
In future extensions, county- or district-level data could be incorporated to provide finer spatial resolution, and socioeconomic covariates (e.g., poverty rate, unemployment, median income) could help disentangle complex relationships between education and crime.

