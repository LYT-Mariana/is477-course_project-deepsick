# Crime & Education: Understanding How School System Indicators Relate to Crime Rates (2015–2024)

## Contributors
- Yutong Liu   

---

## 1. Summary

### 1.1 Project Introduction
This project investigates how state-level education characteristics relate to crime rates across the United States. We integrate two official federal datasets—the FBI Uniform Crime Reporting (UCR) **Summary Reporting System (SRS)** and the National Center for Education Statistics (NCES) **Common Core of Data (CCD) SEA state-level files**—to construct a reproducible dataset that links crime metrics with public-school staffing indicators for each state and year.

Our motivation is that education and public safety are deeply connected aspects of social well-being, yet they are often addressed separately in policy and public debate. Educational opportunities, staffing levels, and school resources can influence community stability, while crime affects both student outcomes and local school systems. Rather than making causal claims, our goal is to provide a transparent, data-driven view of how these systems move together over time.

The analysis focuses on the overlapping years **2015, 2017, 2019, and 2021**, which are the only years where both FBI and NCES data are simultaneously available after cleaning. Because the CCD SEA files contain more than 350 staffing subcategories—over **95% of which exhibit extreme missingness or inconsistent reporting across states and years**—we retain only the consistently reported aggregate indicator `edu_staff_total` as our education variable. This decision is documented and justified to maintain comparability and interpretability across years.

For each state and year, we derive per-capita crime rates (e.g., violent crimes per 100,000 residents) and education staff totals. We then compute descriptive statistics, visualize temporal trends, and examine pairwise correlations to see whether differences in education indicators correspond to differences in violent and property crime rates.

To clarify the analytical scope, we frame our study around the following descriptive research questions:

- How do violent and property crime rates vary across states and over time?
- How do education staffing levels vary across states and across years?
- Are higher staffing levels associated with lower per-capita crime rates?
- How stable or noisy are these associations across the four overlapping years?

Our main contributions are:

- A **cleaned crime dataset** derived from the FBI SRS file, with territories removed and standardized per-capita crime metrics.
- A **cleaned education dataset** from the CCD SEA files, aggregating multiple staffing tables into a single, consistently reported measure (`edu_staff_total`).
- A **merged state-year dataset** (`data/merged.csv`) containing 204 state-year observations across four years.
- A set of **Python notebooks** that implement the full workflow: profiling, cleaning, integration, documentation, and exploratory analysis.
- A transparent discussion of data quality issues and limitations, especially the sparsity, definitional variation, and reporting differences in education data.

Throughout the project we emphasize association rather than causation. Administrative datasets such as SRS and CCD reflect reporting processes that vary across jurisdictions, and observed patterns may be shaped by confounding factors such as socioeconomic conditions or policy differences. By making our workflow and assumptions explicit, the project aims to support informed interpretation and future extensions rather than definitive policy prescriptions.

---

### 1.2 Ethical, Privacy, and Legal Considerations

Both the FBI SRS and NCES CCD SEA datasets are **public, aggregate, non-PII datasets**, meaning they contain no personal identifiers and pose minimal privacy risk. Nonetheless, ethical and legal considerations remain important.

#### **Data Licensing and Terms of Use**
- **FBI Crime Data Explorer** provides downloadable datasets for public analytical use with attribution.
- **NCES CCD** authorizes reuse for statistical and research purposes.  
  We adhere to these terms by maintaining attribution, avoiding re-identification attempts, and limiting use to educational analysis.

#### **Representation and Bias**
Although both datasets are authoritative, they contain structural biases:
- FBI crime statistics depend on voluntary reporting by law enforcement, which varies across agencies and years.
- CCD education staffing data are not uniformly reported; in several years, aggregate staff totals for some states appear as zero due to incomplete SEA reporting rather than an actual absence of staff.

These issues introduce noise into the merged dataset, and we explicitly avoid causal interpretations that could misrepresent the underlying social systems.

#### **Data Quality and Transparency**
All cleaning decisions (e.g., dropping high-missing columns, removing territories, aggregating staff totals) are documented in notebooks and justified in this report. Raw files are preserved to ensure full auditability and reproducibility.

#### **Provenance and Reproducibility**
- Each NCES row contains a `source_file` tag indicating the ZIP archive from which it originated.
- All transformations are scripted in Jupyter notebooks to ensure the workflow can be repeated deterministically from the raw data.

Overall, this project prioritizes transparent decision-making, responsible use of public data, and clear communication of limitations.

---

### 1.3 Data Lifecycle Framework

This project follows the **Wiggins & Vanderhoof Data Lifecycle Model**, which structures data work into six iterative stages: *Plan, Acquire, Process, Analyze, Preserve,* and *Share*. Aligning our workflow to this model ensures transparency, methodological consistency, and reproducibility.

#### **Plan**
We begin by defining the research scope: analyzing associations between education staffing indicators and crime rates across U.S. states. This guides our selection of authoritative federal datasets with nationwide, annually reported indicators.

#### **Acquire**
Data are obtained from two trustworthy government sources:
- The FBI SRS dataset (CSV)
- NCES CCD SEA staffing files (ZIP archives containing CSVs)

Raw files are stored verbatim under `data/raw/` to preserve provenance and ensure reproducibility.

#### **Process**
Both datasets undergo detailed profiling and structured cleaning:
- FBI data require removal of invalid rows, territories, and inconsistent fields such as legacy/revised rape categories.
- NCES data require multi-year extraction, consolidation across 350+ columns, removal of columns with extreme missingness, normalization of state identifiers, and aggregation into a consistent `edu_staff_total` measure.

These transformations are scripted step-by-step, and each step is idempotent to guarantee repeatability.

#### **Analyze**
We integrate the crime and education datasets on `state` and `year`, compute per-capita crime metrics, and generate descriptive summaries, time series plots, and correlation matrices. Due to the limited number of overlapping years, analysis remains exploratory and descriptive rather than inferential.

#### **Preserve**
Cleaned datasets are stored under `data/cleaned/` with accompanying metadata. Figures, intermediate outputs, and notebooks are version-controlled through the Git repository.

#### **Share**
The final deliverables include cleaned data, transformation scripts, and this README, forming a complete, reproducible workflow that others can re-run end-to-end.

---

## 2. Data Profile

### 2.1 FBI Crime Data (Summary Reporting System)

**Source**  
FBI Crime Data Explorer – Summary Reporting System (SRS), downloaded as `estimated_crimes_1979_2024.csv`.

**Coverage and Structure**  
The raw SRS file provides annual crime counts for U.S. states, the District of Columbia, and several territories from **1979 to 2024**. Key columns include:

- `year` – calendar year of record  
- `state_abbr`, `state_name` – jurisdiction identifiers  
- `population` – estimated state population  
- `violent_crime`, `homicide`, `robbery`, `aggravated_assault` – major violent crime categories  
- `property_crime`, `burglary`, `larceny`, `motor_vehicle_theft` – property crime categories  
- `caveats`, `rape_legacy`, `rape_revised` – auxiliary or definition-sensitive fields  

The rape-related fields are dropped because the FBI transitioned from the legacy to revised definition during the 2010s. Many states report only one version, making the two fields **not comparable across states or years**. We keep only fields with complete reporting consistency.

Following cleaning, we retain **50 states + D.C.** and restrict the period to **2015–2021**, matching the years for which education data are available. We compute derived per-capita indicators:

- `violent_crime_rate` = violent_crime / population × 100,000  
- `property_crime_rate` = property_crime / population × 100,000  
- `homicide_rate`, `robbery_rate`, `aggravated_assault_rate` defined analogously  

These standardized rates ensure comparability across states with different population sizes and are stored directly in the cleaned dataset to guarantee reproducible calculations.

**Data Limitations**  
Crime reporting varies by jurisdiction. The FBI data depend on voluntary participation of state and local agencies, and reporting completeness fluctuates across years. State-level aggregates therefore reflect **administrative reporting patterns**, not necessarily true crime incidence. These limitations motivate our decision to treat the analysis as descriptive rather than causal.

**Use in Analysis**  
The cleaned crime dataset (`data/cleaned/crime_cleaned.csv`) is used to:

- Summarize crime levels and trends across states.  
- Produce per-capita crime rates for correlation analysis.  
- Serve as the outcome variables in exploratory visualizations and comparisons.

---

### 2.2 NCES Education Data (CCD SEA State-Level Files)

**Source**  
NCES Common Core of Data – SEA State-Level Nonfiscal Survey Data, downloaded for survey years:

- 2015–2016 (`15-16`)  
- 2017–2018 (`17-18`)  
- 2019–2020 (`19-20`)  
- 2021–2022 (`21-22`)  
- 2023–2024 (`23-24`)  

Each survey year includes two ZIP files representing **staffing** and **membership** tables. We extract all staffing CSVs programmatically to ensure transparent and reproducible ingestion.

**Coverage and Structure**  
The merged raw education dataset contains **62,841 rows** and **357 columns**. Relevant variables include:

- `SURVYEAR` – survey year label  
- `STABR`, `STATENAME` – state identifiers (57 unique values including territories)  
- Staffing totals (`STAFF`, `SECTCH`, `ELMTCH`, `SCHSUP`, `STUSUP`, etc.)  
- Hundreds of fine-grained race × gender × grade indicators  

However, **341 out of 357 fields exhibit more than 95% missingness**, and many staffing subcategories are reported only by certain states or only in certain years. These inconsistencies make the majority of variables **not analytically comparable across states or survey years**.

**Cleaning and Core Variable Selection**  
To maintain comparability, we drop extremely sparse columns and retain only robust, consistently reported indicators. We derive:

- `state_fips` – numeric state code  
- `state` – uppercase state name standardized across years  
- `edu_staff_total` – aggregated staff count from the `STAFF` column  
- `year` – numeric year extracted from folder labels (2015–2023)  

We remove rows with missing state identifiers, missing staff totals, or invalid territories (e.g., Puerto Rico, Guam). The cleaned dataset (`data/cleaned/education_cleaned.csv`) contains **5,786 rows**, which are later aggregated to a single record per state-year.

**Why Only `edu_staff_total` Is Used**  
Because CCD SEA reporting differs substantially across states, nearly all granular staffing categories are **not consistently defined** or **not consistently reported**. The `STAFF` field is the only aggregated staffing measure that exists across **all states and all years**, making it the only feasible, comparable education variable for our analysis.

**Important Limitation: Zero Staff Totals**  
In several survey years, some states appear with `edu_staff_total = 0`. These values do **not** indicate an absence of staff; instead, they reflect missing aggregated totals in the SEA files for that year. These zeros therefore behave as **structural missing values** and should be interpreted cautiously.

**Aggregation and Use**  
We aggregate the cleaned education data to one record per state and year by summing `edu_staff_total`. This yields **204 state-year observations** for **2015, 2017, 2019, and 2021**, which serve as our primary education indicator representing the staffing capacity of state public-school systems.

---

### 2.3 Integrated Dataset

To study education–crime relationships, we merge the two cleaned datasets by aligning identifiers and ensuring consistent temporal coverage.

**Integration Steps**

1. **State alignment:** Convert all state names to uppercase and restrict both datasets to the 50 states + D.C.  
2. **Year alignment:** Take the intersection of available years from each dataset → **{2015, 2017, 2019, 2021}.**  
3. **Aggregation:** Reduce education data to one state-year record using summed `edu_staff_total`.  
4. **Merge:** Perform an inner join on `state` and `year`.

**Resulting Dataset**  
The final merged dataset (`data/merged.csv`) includes:

- **204 rows** (51 states × 4 years)  
- **18 columns**, including population, crime counts, per-capita crime rates, and `edu_staff_total`.

**Integration Limitations**  
- Only four overlapping survey years exist, producing a **non-continuous time series** for education variables.  
- Differences in reporting granularity across FBI and NCES systems may introduce alignment noise.  
- Zero-staff rows inherited from CCD SEA constitute structural missing values that limit interpretability.

Despite these constraints, the merged dataset offers a reproducible and transparent foundation for descriptive analysis of education–crime associations.

---

## 3. Data Quality

### 3.1 Crime Data Quality

Overall, the FBI crime dataset is comparatively clean and reliable for quantitative analysis. Most core variables exhibit high completeness and clear semantic definitions:

- Core columns (`population`, `violent_crime`, `property_crime`, `homicide`, `robbery`, `aggravated_assault`, `burglary`, `larceny`, `motor_vehicle_theft`) have **0% missing values** for the years we analyze.
- The `caveats` column is **97% missing** and contains heterogeneous textual notes rather than structured information; it is removed.
- `rape_legacy` and `rape_revised` exhibit **mutually exclusive reporting** due to the FBI’s definitional transition starting in 2013. Because states adopt the revised definition at different times, keeping either field would produce inconsistent series. We drop both and rely on the broader and consistently defined `violent_crime` category.
- 38 rows contain missing `state_name`, corresponding to national totals, empty rows, or administrative artifacts. These are dropped to avoid double-counting and ensure each row corresponds to one identifiable jurisdiction.

After cleaning and restricting to the 50 states + D.C. and years 2015–2021, the dataset contains 357 valid records; intersecting with education years yields **204 state-year rows**.

**Data Validity and Structural Checks**  
- We detect **no duplicated state–year pairs**, ensuring stable joins.
- No negative crime counts or population values appear.
- All per-capita crime rates are computed using the FBI’s population estimates, which are themselves model-based and may introduce uncertainty, but these denominators are standard for comparative criminological analysis.

**Remaining Limitations**  
- FBI reporting is voluntary at the agency level, and some states may have fluctuating participation over time.  
- State-level aggregates can therefore reflect reporting coverage as much as actual crime incidence.

These limitations prevent causal interpretation but do not materially harm descriptive, cross-sectional comparisons.

---

### 3.2 Education Data Quality

The NCES SEA staffing data present substantial data quality challenges due to heterogeneity in reporting practices across states and years.

**Key Quality Issues Identified:**

- The merged dataset includes **57 distinct agency codes**, combining states, territories, and special agencies (e.g., Bureau of Indian Education). Only 51 correspond to our target state-level units.
- Of 357 columns, **341 (95%+) exhibit over 95% missingness**, largely representing fine-grained race × grade × gender staffing counts reported inconsistently across jurisdictions.
- Core identifiers (`STABR`, `STATENAME`) are well populated, as are several high-level staffing counts (e.g., `STAFF`, `SECTCH`, `ELMTCH`), but many totals differ in definition depending on the state.

**Cleaning Actions and Justification**  
To ensure comparability:

- All high-missing and inconsistently defined variables are removed.
- Only aggregated staffing totals with stable reporting across all years are retained.
- Territories and special agencies are excluded.
- A derived numeric `year` variable is added to ensure temporal alignment.

**Residual Limitations**

Despite cleaning, several quality concerns remain:

1. **Zero Staff Totals**  
   Some states report `STAFF = 0` in survey years 2017, 2019, or 2021. These values do **not** represent true zero staffing; instead, they result from SEA-level reporting omission or suppression. They function as **structural missing values** and should be interpreted accordingly.

2. **Reporting Inconsistency Across States**  
   SEA staffing definitions differ subtly across states (e.g., inclusion/exclusion of contracted personnel), reducing the semantic comparability of staff totals.

3. **Limited Variable Breadth**  
   Because only `edu_staff_total` is sufficiently complete, our representation of education systems is narrow. Staffing context such as enrollment, student–teacher ratios, or administrative breakdowns cannot be analyzed.

Even with these limitations, the cleaned dataset maintains internal consistency, allowing for meaningful descriptive comparisons at the state-year level.

---

### 3.3 Integration Quality

We evaluate integration quality along three dimensions: identifier alignment, temporal consistency, and completeness after merging.

#### **1. Identifier Alignment**
- State names and abbreviations are normalized to uppercase across both datasets.
- All non-state entities (e.g., territories, specialized agencies) are removed.
- After filtering, both datasets contain **exactly 51 states** (50 states + D.C.), enabling a consistent one-to-one join structure.

#### **2. Temporal Consistency**
- FBI data follow calendar years; NCES SEA data follow survey years (e.g., “2015–2016”).  
  We consistently map survey-year folders to the **first calendar year** (e.g., `15-16 → 2015`), which is appropriate given the annual granularity of our analysis.
- We restrict attention to the intersection of available years: **2015, 2017, 2019, 2021**, all of which appear in both datasets.

#### **3. Missingness After Merge**
- The merged dataset contains **no missing values** in the retained fields.
- We verify that each state-year pair appears exactly once.
- The final dataset contains **204 rows** (51 states × 4 years), forming a complete, rectangular panel.

**Integration Limitations**
- The education data’s structural zeros propagate into the merged dataset, constraining interpretation of cross-year trends.
- Because only four years overlap, the integrated dataset represents **discrete snapshots** rather than a continuous time series.
- Differences in how federal agencies define and aggregate indicators may introduce subtle interoperability issues.

Overall, while education data sparsity limits the analytic depth, the merged dataset is internally consistent, well-aligned across keys and years, and suitable for transparent exploratory analysis.

---

## 4. Findings

### 4.1 Temporal Trends

Using the merged dataset, we compute statewide averages of per-capita crime rates and education staff totals by year.

- **Property crime rates** exhibit a clear and consistent downward trend from 2015 to 2021. The decline appears in nearly every state, suggesting a broad national shift rather than isolated regional changes.
- **Violent crime rates** remain comparatively stable. While some states experience localized increases or decreases, the national average shows only modest fluctuations, especially relative to property crime.
- **Education staff totals** are high only in 2015 and drop to near-zero for 2017, 2019, and 2021. This pattern reflects **reporting discontinuities** in CCD SEA files rather than any real staffing change. Because the SEA aggregates were not consistently reported in later years, the education time series cannot be interpreted as a true temporal trend.

These findings highlight a meaningful improvement in property crime over time, stable violent crime, and substantial limitations in the education data that prevent longitudinal analysis of staffing patterns.

---

### 4.2 Correlation Patterns

We compute a correlation matrix for the main variables: violent crime rate, property crime rate, homicide rate, robbery rate, aggravated assault rate, and `edu_staff_total`.

**Internal Crime Correlations**
- Crime rates are **strongly positively correlated** with one another.  
  For example, aggravated assault rate correlates above 0.9 with violent crime rate, reflecting the fact that aggravated assault comprises a large share of violent crime.
- Property crime rate also shows moderate positive correlations with violent crime metrics, consistent with shared socioeconomic and demographic drivers.

**Education–Crime Correlations**
- The aggregated education staff total exhibits **near-zero correlations** with all crime rates:  
  - Violent crime rate ≈ –0.01  
  - Property crime rate ≈ 0.12  
  - Robbery rate and homicide rate also near zero

Taken at face value, this suggests **no detectable linear association** between total staffing levels and crime rates at the state-year level.  

However, this interpretation is limited by:

1. Structural missingness in staff totals after 2015  
2. The narrow scope of `edu_staff_total` (one variable describing an entire education system)  
3. Aggregation at the state-year level, which may obscure more meaningful local or district-level relationships  

Thus, the absence of strong correlations should not be understood as evidence of no relationship between education systems and crime—only that the CCD SEA staffing measure available to us is too sparse and aggregated to capture such patterns.

---

### 4.3 Geographic Patterns

Although our analysis is primarily numeric rather than spatial, several geographic observations emerge:

- States with the largest populations (e.g., California, Texas, Florida) naturally have the highest **crime counts**, but not necessarily the highest **crime rates** after adjusting for population. Smaller states such as Alaska or New Mexico sometimes exhibit higher per-capita rates.
- Many states show parallel declines in property crime, suggesting national-level drivers (e.g., economic shifts, policy trends, demographic changes) rather than isolated state policies.
- Because education staff totals are populated only in 2015, regional comparisons in education staffing are limited. Beyond that year, the SEA files do not provide reliable variation across states.

Taken together, our findings show:

- A **clear national decline in property crime**,  
- **Stable violent crime**,  
- **Consistent internal structure** across crime indicators, and  
- **No strong evidence of association** between the CCD staffing totals and crime rates given data limitations.

The results underscore the importance of data quality and consistency when studying cross-domain relationships and highlight the need for richer, more granular, and more consistently reported education indicators for future analysis.

---

## 5. Future Work

This project is best viewed as a first step toward integrating education and crime data. Several extensions could substantially improve both the robustness and interpretability of the results:

1. **Richer Education Indicators**  
   Instead of relying solely on staff totals, future work could incorporate:
   - Enrollment counts and student–teacher ratios (MEMBER and teacher FTE data from additional CCD tables).  
   - Graduation rates, dropout rates, and test scores from other NCES datasets.  
   These variables would provide a more direct measure of “education quality” and outcomes.

2. **Socioeconomic Controls**  
   Crime and education are both influenced by broader structural factors such as income, unemployment, urbanization, racial segregation, and policy differences. Adding state-level covariates from the Census or American Community Survey would enable multivariate modeling and help distinguish direct relationships from confounding.

3. **Finer Spatial Resolution**  
   State-level aggregation masks important within-state variation. Using county- or district-level data (e.g., UCR county data combined with CCD district files) could reveal spatial clusters where education and crime are more tightly linked.

4. **Improved Temporal Alignment**  
   Future work could align school-year and calendar-year data more carefully (for example, by mapping a school year partially across two calendar years or using lagged variables). This might capture delayed effects of education changes on crime rates.

5. **Causal Modeling and Robustness Checks**  
   With richer data, one could explore:
   - Fixed-effects panel regression to control for unobserved state characteristics.  
   - Difference-in-differences or event-study designs around major policy changes.  
   - Sensitivity analyses to test how robust findings are to different modeling choices.

6. **Workflow and Documentation Enhancements**  
   Finally, the computational workflow could be further automated using tools like Snakemake or Makefiles, and the project could be packaged for public reuse (for example, as a reproducible repository with a DOI).

By documenting both what works well and where the data fall short, this project sets up a foundation that can be extended into more detailed, policy-relevant research.

---

## 6. Reproducing the Project

### 6.1 Repository Structure

The project repository is organized as follows:

```text
data/
  raw/
    crime_data/
      estimated_crimes_1979_2024.csv
    education_data/
      15-16/
      17-18/
      19-20/
      21-22/
      23-24/
  cleaned/
    crime_cleaned.csv
    education_cleaned.csv
    merged.csv

notebooks/
  crime_profiling&cleaning.ipynb
  education_profiling&cleaning.ipynb
  data_integration.ipynb
  analysis.ipynb

ProjectPlan.md
StatusReport.md
README.md
requirements.txt
```

---

### 6.2 Obtaining the Raw Data

#### Crime Data (FBI UCR SRS)

Download:

estimated_crimes_1979_2024.csv

Place it into:

data/raw/crime_data/

---

#### Education Data (NCES CCD SEA)

Download the SEA ZIP archives for:

- 2015–2016  
- 2017–2018  
- 2019–2020  
- 2021–2022  
- 2023–2024  

Place each year’s ZIPs into the matching folders:

data/raw/education_data/15-16/  
data/raw/education_data/17-18/  
data/raw/education_data/19-20/  
data/raw/education_data/21-22/  
data/raw/education_data/23-24/  

The notebook handles extraction.

---

### 6.3 Running the Workflow

Run the notebooks **in order**:

---

#### 1. Education Profiling & Cleaning  
File: `notebooks/education_profiling&cleaning.ipynb`

This step:

- Extracts all SEA CSVs from ZIP archives  
- Merges ~62k rows across 357 columns  
- Drops >95% missing columns  
- Keeps identifiers + `edu_staff_total`  
- Filters to valid states + valid years  
- Saves cleaned education data to:

data/cleaned/education_cleaned.csv

---

#### 2. Crime Profiling & Cleaning  
File: `notebooks/crime_profiling&cleaning.ipynb`

- Loads FBI SRS dataset  
- Removes invalid or non-state rows  
- Drops unused or inconsistent fields  
- Computes per-capita crime rates  
- Saves cleaned crime data to:

data/cleaned/crime_cleaned.csv

---

#### 3. Data Integration  
File: `notebooks/data_integration.ipynb`

- Loads cleaned datasets  
- Identifies overlapping years: 2015, 2017, 2019, 2021  
- Aggregates education staff totals  
- Standardizes state names  
- Performs merge on `state` + `year`  
- Saves integrated dataset:

data/cleaned/merged.csv

---

#### 4. Analysis & Visualization  
File: `notebooks/analysis.ipynb`

- Loads merged dataset  
- Generates descriptive statistics  
- Produces time-series plots  
- Computes correlation matrix + heatmap  
- Supports findings section of the report  

---

### 6.4 Expected Outputs

After running all notebooks, you should have:

data/cleaned/
  crime_cleaned.csv
  education_cleaned.csv
  merged.csv

Notebooks produce all figures and summary tables used in the report.

---

## 7. References

- FBI Crime Data Explorer – Summary Reporting System (SRS)  
  https://cde.ucr.fbi.gov/LATEST/webapp/#/pages/downloads  

- NCES Common Core of Data – State Education Agency Files  
  https://nces.ed.gov/ccd/data_tables.asp  

- McKinney, W. (2010). *Data Structures for Statistical Computing in Python*.

- Hunter, J. D. (2007). *Matplotlib: A 2D Graphics Environment*.  

- Waskom, M. (2020). *seaborn: statistical data visualization*.  

---

## Appendix — Metadata / Data Dictionary

### Metadata Summary for Merged Dataset

Below is the data dictionary for `merged.csv`, which contains **204 state-year observations**.

| Column                   | Type   | Description                                                       |
|--------------------------|--------|-------------------------------------------------------------------|
| `year`                   | int    | Calendar year of observation (2015, 2017, 2019, 2021).           |
| `state_abbr`             | string | Two-letter USPS state abbreviation.                              |
| `state`                  | string | Uppercase state name used as join key.                           |
| `population`             | int    | Estimated state population from FBI SRS.                         |
| `violent_crime`          | int    | Total violent crimes (FBI definition).                           |
| `homicide`               | int    | Murder and non-negligent manslaughter.                           |
| `robbery`                | int    | Total robberies.                                                 |
| `aggravated_assault`     | int    | Total aggravated assaults.                                       |
| `property_crime`         | int    | Total property crimes.                                           |
| `burglary`               | int    | Burglary offenses.                                               |
| `larceny`                | int    | Larceny-theft offenses.                                          |
| `motor_vehicle_theft`    | int    | Motor vehicle theft offenses.                                    |
| `violent_crime_rate`     | float  | Violent crimes per 100,000 residents.                            |
| `property_crime_rate`    | float  | Property crimes per 100,000 residents.                           |
| `homicide_rate`          | float  | Homicides per 100,000 residents.                                 |
| `robbery_rate`           | float  | Robberies per 100,000 residents.                                 |
| `aggravated_assault_rate`| float  | Aggravated assaults per 100,000 residents.                       |
| `edu_staff_total`        | float  | Aggregated SEA staffing totals for each state-year.              |

This schema reflects the final integrated dataset used in analysis and supports consistent interpretation and reuse.
