# World Laid off during COVID-19

## Table of Contents
- [Project Overview](#project-overview)
- [Data Source ](#data-source)
- [Tools ](#tools)
- [Data Cleaning](#data-cleaning)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Results and Finding ](#results-and-finding)
- [Recomendations](#recomendations)
- [Limitations](#limitations)
- [References](#references)
    
### Project Overview
This project analyzes global layoffs from 2020 to 2022, focusing on the impact of the COVID-19 pandemic on the labor force across various industries and countries. The dataset includes detailed information on layoffs by company, industry, and country, providing a comprehensive view of how the global workforce was affected during this period.
- [Tablaeu Report](https://public.tableau.com/views/project_laidoff/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

![Laidoff-Project](https://github.com/user-attachments/assets/24d63c74-245d-4f09-81b2-8e1b25cc457c)

### Data Source

The dataset for this project is a publicly available collection of global layoff records from 2020 to 2022, sourced from [Alex The Analyst’s GitHub repository](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv). It contains **2,362 rows** and **9 columns**, capturing layoffs during the COVID-19 pandemic with the following attributes:

- **Company**: Name of the company reporting layoffs.
- **Location**: City or region where the layoffs occurred.
- **Industry**: Sector of the company (e.g., technology, hospitality, retail).
- **Total Laid Off**: Number of employees laid off.
- **Percentage Laid Off**: Proportion of the workforce affected.
- **Date**: Date the layoffs were reported.
- **Stage**: Company’s funding stage (e.g., Series A, Post-IPO).
- **Country**: Country where the layoffs took place.
- **Funds Raised (Millions)**: Total funds raised by the company in millions.

This dataset is well-suited for analyzing the impact of the COVID-19 pandemic on the global labor force, as it provides detailed insights into layoff trends across industries, countries, and company stages. Limitations include potential gaps in data for smaller companies or underreported layoffs in certain regions. The dataset is free to access and available in CSV format at the provided GitHub link.

### Tools

This project leverages the following tools to process, analyze, and visualize global layoff data from 2020 to 2022:

- **MySQL**: Used for data cleaning and exploratory data analysis. MySQL queries were employed to handle missing values, standardize formats, and remove duplicates in the dataset. It was also used to perform aggregations and joins to uncover trends in layoffs by company, industry, and country, providing a foundation for deeper insights into the labor force impact during the COVID-19 pandemic.

- **Tableau**: Utilized for data visualization to create interactive dashboards and charts. Tableau enabled the presentation of layoff trends, such as industry-specific layoff rates, geographic distributions, and temporal patterns, making complex data accessible and actionable for stakeholders.

These tools together facilitated a streamlined workflow from raw data processing to insightful visualizations, enabling a comprehensive analysis of global layoff patterns.

### Data Cleaning

To ensure the quality and reliability of the global layoff dataset (2020–2022) for analysis, the following data cleaning steps were performed using MySQL:

- **Checking and Removing Duplicates**: Identified and removed duplicate records by querying for identical rows across key columns (e.g., company, location, date, total_laid_off). This ensured each layoff event was counted only once, preventing skewed results.
- **Standalize Format**: Standardized data formats for consistency. The `date` column was converted to `YYYY-MM-DD`, and text fields like `company` and `industry` were trimmed and normalized to consistent casing. This improved query accuracy and visualization clarity.
- **Handling Null and Blank Values**: Addressed missing or blank values in columns like `total_laid_off`, `industry`, and `country`. Nulls were imputed with defaults (e.g., "Unknown" for industry) or excluded where appropriate, ensuring a complete dataset for analysis.

These steps produced a refined dataset of 2,362 rows, enabling accurate analysis of layoff trends during the COVID-19 pandemic.

### Exploratory Data Analysis

Exploratory data analysis (EDA) was conducted using MySQL to uncover patterns and trends in the global layoff dataset (2020–2022), providing insights into the labor force impact during the COVID-19 pandemic. The following key questions were addressed through SQL queries:

- **Statistical Summary**: Calculated the maximum number of employees laid off (`total_laid_off`) in a single event and the average percentage of workforce laid off (`percentage_laid_off`) across all records. This provided a baseline understanding of the scale and intensity of layoffs during the pandemic.
- **Highest Layoffs for Companies Out of Business**: Identified companies that went out of business (inferred from high `percentage_laid_off` or contextual data) and examined their highest employee layoffs. This highlighted the severe impact on certain firms, particularly in vulnerable sectors.
- **Total Layoffs by Groupings**: Aggregated total layoffs (`total_laid_off`) by `company`, `industry`, `year` (derived from `date`), and `country`. This revealed which industries (e.g., hospitality, retail), countries, and years (e.g., 2020 peak) experienced the heaviest workforce reductions.
- **Top 5 Companies by Layoffs per Year**: Ranked companies by total layoffs (`total_laid_off`) for each year (2020, 2021, 2022), identifying the top 5 companies with the highest layoffs annually. This showed shifts in layoff leaders over time, reflecting economic recovery or sector-specific challenges.

These analyses illuminated the scope and distribution of layoffs, identifying hardest-hit industries, countries, and companies, and informing stakeholders about labor market disruptions during the COVID-19 period.

### Data Analysis

```sql

WITH company_year (company,years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
WHERE `date` IS NOT NULL
GROUP BY company, YEAR(`date`)
), company_ranking as
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) ranking
FROM company_year
)
SELECT * FROM company_ranking
WHERE ranking < 6
;
```

### Results and Finding

The exploratory data analysis, conducted using MySQL, and visualizations, created in Tableau, revealed critical insights into global layoff trends during the COVID-19 pandemic (2020–2022). The following key findings highlight the scale and distribution of layoffs across companies, industries, and countries:

- **Maximum Layoff Event**: The largest single layoff event involved **11,000 employees**, underscoring the severity of workforce reductions in certain companies during the pandemic.
- **Highest Layoffs for a Company Out of Business**: **Katerra** (US) laid off **2,434 employees**, reflecting the devastating impact on companies that ceased operations, particularly in vulnerable sectors.
- **Top Industries by Layoffs**: **Transportation** and **Retail** were the hardest-hit industries, each with approximately **30,000 employees** laid off, indicating significant disruption in consumer-facing and logistics sectors.
- **Top Countries by Layoffs**: The **United States** led with over **166,000 employees** laid off, followed by **India** with over **31,000**, highlighting the disproportionate impact on major economies with large workforces.
- **Top Companies by Layoffs per Year**:
  - **2020**: **Uber** led with **7,525 employees** laid off, driven by reduced demand for ride-sharing during lockdowns.
  - **2021**: **ByteDance** had the highest layoffs with **3,600 employees**, reflecting shifts in the tech sector.
  - **2022**: **Meta** topped the list with **11,000 employees** laid off, signaling a post-pandemic correction in tech hiring.

These findings, visualized through interactive Tableau dashboards, illustrate the profound impact of the COVID-19 pandemic on the global labor force, identifying key industries, countries, and companies most affected. They provide actionable insights for stakeholders to address workforce recovery and economic resilience.

### Recomendations

Based on the analysis of global layoff trends during the COVID-19 pandemic (2020–2022), the following recommendations are proposed to support labor force recovery and economic resilience:

- **Support Hard-Hit Industries**: Develop targeted retraining programs for workers in **Transportation** and **Retail**, which each saw ~30,000 layoffs. Governments and businesses should focus on upskilling for roles in growing sectors like technology or logistics to address workforce displacement.
- **Strengthen Economic Safety Nets in High-Impact Countries**: Prioritize job creation and unemployment benefits in the **United States** (>166,000 layoffs) and **India** (>31,000 layoffs). Policymakers should invest in infrastructure or digital economy projects to absorb displaced workers.
- **Mitigate Risks for Vulnerable Companies**: Provide financial aid or restructuring support for companies at risk of closure, as seen with **Katerra** (2,434 layoffs). Early intervention can prevent large-scale layoffs and preserve jobs in critical sectors.
- **Monitor Tech Sector Volatility**: Given significant layoffs by tech giants like **Uber** (7,525 in 2020), **ByteDance** (3,600 in 2021), and **Meta** (11,000 in 2022), companies should adopt sustainable hiring practices to avoid boom-bust cycles, while regulators can promote workforce stability policies.
- **Enhance Crisis Preparedness**: Establish rapid-response workforce programs to address sudden large-scale layoffs, as seen with the maximum event of **11,000 employees**. Governments and industries should create contingency plans to support workers during economic shocks.

These recommendations, informed by MySQL analysis and Tableau visualizations, aim to guide stakeholders in rebuilding a resilient global labor market post-COVID-19.

### Limitations

While this project effectively demonstrates proficiency in SQL and Tableau through the analysis of global layoff trends (2020–2022), the following limitations should be noted:

- **Incomplete Data**: The dataset contains null and blank values in columns such as `total_laid_off`, `industry`, and `percentage_laid_off`, which could not be reliably imputed due to insufficient contextual information. This may lead to underreporting of layoffs in some cases, affecting the completeness of insights.
- **Lack of Business Problem**: As a portfolio project designed to showcase SQL and Tableau skills, the analysis is not driven by a specific business problem or stakeholder need. The findings and recommendations are therefore general and illustrative rather than tailored to a real-world application.
- **Scope of Analysis**: The project focuses on exploratory analysis and visualization, without advanced statistical modeling or predictive analytics, limiting its depth for certain use cases.

These limitations reflect the constraints of the dataset and the project’s purpose as a skills demonstration, but do not detract from its value as a showcase of data cleaning, analysis, and visualization capabilities.

### References

The following resources were used in the development of this global layoff analysis project (2020–2022):

- [Global Layoff Dataset](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv) by Alex The Analyst: A publicly available dataset containing 2,362 records of layoffs from 2020 to 2022, used as the primary data source for this project.
- [MySQL Documentation](https://dev.mysql.com/doc/): Official documentation for MySQL, referenced for writing queries for data cleaning and exploratory analysis.
- [Tableau Public Documentation](https://help.tableau.com/current/pro/desktop/en-us/help.htm): Official Tableau resources, consulted for creating interactive visualizations and dashboards.

These references provided the foundation for the dataset, tools, and techniques used to showcase SQL and Tableau skills in this portfolio project.
