# Employee Activity ETL Project

## Overview

This project is an ETL pipeline built for integrating multiple data sources.
The sources include Timesheets, Event Calendar and Absence Log.

The goal is to clean and transform the data and load it into a star schema.
After that, the data can be used for analysis and reporting.

---

## Data Sources

The project uses the following types of data:

* Timesheets data with worked hours
* Absence log data from a CSV file
* Event calendar data for tracking activities

The data sources have different formats and structures.
They are combined into a single consistent model.

---

## Data Model

The final model is a star schema.

It contains:

* FACT_ACTIVITY as the main fact table
* DIM_EMPLOYEE for employee details
* DIM_DEPARTMENT for department information
* DIM_DATE for time analysis

The fact table stores both worked hours and absence days.

---

## ETL Process

The ETL process is split into multiple steps.

1. Create staging and target tables
2. Load and validate absence data
3. Create dimension and fact tables
4. Populate dimensions
5. Load the fact table
6. Create a view for reporting

Each step is implemented in a separate SQL script.