# Basic Data Analysis for Admission Data from UNAL

## Project - Daniel Alvarado - Introducción a la Estadística / Estadística Descriptiva y Exploratoria

- [Basic Data Analysis for Admission Data from UNAL](#basic-data-analysis-for-admission-data-from-unal)
  - [Project - Daniel Alvarado - Introducción a la Estadística / Estadística Descriptiva y Exploratoria](#project---daniel-alvarado---introducción-a-la-estadística--estadística-descriptiva-y-exploratoria)
    - [Repository Overview](#repository-overview)
  - [Data Source](#data-source)
  - [Progress as of February 15th](#progress-as-of-february-15th)
  - [Data Description](#data-description)
    - [Data Preparation](#data-preparation)
  - [Script Description](#script-description)

### Repository Overview

This repository documents our progress in descriptive and exploratory statistics - introduction to statistics courses. It includes a collection of **R scripts** that demonstrate the methods and functions we’ve developed during this project.

## Data Source

The analysis in this repository uses data from [Microdatos Admitidos y Aspirantes UNAL](https://www.datos.gov.co/Educaci-n/Microdatos-Aspirantes-y-Admitidos-en-la-UNAL/mqpd-2jhs/about_data). To replicate the analysis using the provided scripts, follow these steps:

1. Create a subdirectory named `raw` inside the `data` folder.
2. Place the dataset downloaded from the link above into the `raw` folder.

## Progress as of February 15th

As of February 15th, the following steps have been completed:

- Importing and saving the dataset into the environment.
- Checking variable types and converting them to factors or numerics (using `lapply` with vector notation).
- Creating a barplot for qualitative data variables.
- Generating a grouped data table for quantitative data.

---

## Data Description

The **population** analyzed in this project consists of:  
_Applicants for undergraduate degree programs at the National University of Colombia between 2019 and 2024._

### Data Preparation

To ensure a clean and usable dataset, the following steps were taken:

1. Filtered the data to include only applicants for undergraduate degrees.
2. Handled negative, null, or zero values in the exam scores, as these were excluded from the analysis.
3. Grouped the data by the applicants' departments of origin.

This initial preparation provides a solid foundation for further analysis.

---

## Script Description

The repository includes several R scripts, each focusing on a specific step in the analysis process:

1. **`01_data_cleaning.R`**:

   - Imports the raw data while keeping it immutable.
   - Cleans the data and saves a processed version as a CSV file in the `data/processed` folder for subsequent steps.

2. **`02_analysis.R`**:

   - Performs calculations for bins and basic statistics.
   - Prepares the data for visualization and further analysis.

3. **`03_visualization.R`**:
   - Generates various plots and visualizations using the cleaned data and calculated statistics.

---

This structure ensures a clear and logical workflow, making it easier to understand and replicate the analysis.
