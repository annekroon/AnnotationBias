# Pipeline Documentation

This document describes each notebook in the pipeline, including its purpose,
required inputs, and produced outputs. Notebooks must be executed in order.

---

## 00_get-Xaccounts-MPs.ipynb

Purpose:
Compile and clean a list of Dutch Members of Parliament and their associated
X/Twitter accounts.

Output:
- data/X_data/tweedekamerleden.csv

This file serves as the master lookup table for MP identifiers and accounts.

---

## 01_get_twitter_data.ipynb

Purpose:
Collect tweet-level data for Dutch MPs using the TWi-XL API and construct
immigration-focused subsets for annotation and analysis.

Input:
- data/X_data/MPs_twitter_usernames.txt

Outputs:
- data/X_data/full_twitter_data.csv  
  (all collected tweets with metadata)
- data/X_data/immigratie_tweets_non_stratefied.csv  
  (immigration-related subset before stratification)
- data/X_data/final_stratified_immigration.csv  
  (final stratified immigration sample)

---

## 02_prepare_data_for_analysis.ipynb

Purpose:
Merge tweet data, AnnoTinder annotations, and Qualtrics survey data into
analysis-ready datasets.

Inputs:
- AnnoTinder annotation exports (6 CSV files, sets 1–6)
- Qualtrics survey exports:
  - start_survey.csv
  - before.csv
  - after.csv
- Tweet data:
  - data/X_data/final_stratified_immigration.csv

Outputs (each written as .csv, .parquet, and .pkl):
- data/final_merged_dataset_for_analysis.*
- data/final_merged_dataset_for_analysis_without_failing_attention_check.*
- data/final_merged_dataset_for_analysis_without_failing_attention_check_without_straightliners.*

These datasets form the basis for all downstream analyses.

---

## 03_attrition_check.ipynb

Purpose:
Assess survey attrition within the consented participant cohort.

Key steps:
- Anchor cohort on the Qualtrics BEFORE survey
- Map consent (dsc) from the AFTER survey
- Apply start-date cutoff
- Derive baseline demographics and attitudinal variables
- Compare:
  - Dropout (no dsc) vs With dsc
  - Dropouts vs Completers
- Statistical tests:
  - Welch t-tests (continuous variables)
  - Chi-square tests (categorical variables)
  - Holm correction for multiple testing
- Upload outputs to the Research Drive via WebDAV

Inputs:
- data/Qualtrics_data_exports/before.csv
- data/Qualtrics_data_exports/after.csv
- annotated_any indicator (from prior steps)
- config.PROJECT_ROOT
- rd_utils

Outputs:
- LaTeX tables in output/tables/
- Parquet datasets in output/derived/

---

## 04_sample_descriptives.ipynb

Purpose:
Produce descriptive statistics for the active annotation sample.

Active sample definition:
Participants with at least one annotation on:
- stellingen.misinformation
- stellingen.sentiment
- stellingen.toxic

Procedure:
- Collapse data to one row per participant
- Compute means/SDs for continuous variables
- Compute counts and percentages for categorical variables

Output:
- output/tables/active_participants_demographics_EN.tex

---

## 05_irr_reliability.ipynb

Purpose:
Assess inter-annotator reliability using Krippendorff’s alpha (ordinal).

Features:
- Main analysis on the 5-point ordinal annotation scale
- Robustness analysis using a coarsened 3-category scale
- Subset analyses by:
  - Source visibility (shown vs masked)
  - Instruction condition (none / general / tailored)
- Item-level bootstrap percentile confidence intervals
- BCa confidence intervals as robustness checks

Input:
- data/final_merged_dataset_for_analysis.parquet

Outputs (Research Drive, output/tables/):
- LaTeX IRR tables
- CSV summary files
- Interpretation text files
- Optional presentation-style tables

---

## 06_hypotheses_testing.ipynb

Purpose:
Test the core hypotheses using cross-classified mixed-effects models.

Model structure:
- Outcomes: sentiment, misinformation, toxicity
- Random intercepts for annotators (coders)
- Variance components for tweets (items)

Key interactions:
- Congruence × Implicit Bias
- Source Visibility × Congruence
- Instruction Type × Congruence

Additional steps:
- Factor releveling and grand-mean centering
- Listwise deletion via patsy formulas
- Extraction of variance components and ICCs
- Generation of appendix figures with predicted effects and 95% confidence intervals

Outputs:
- output/tables/<outcome>_models_xclass.tex
- output/tables/<outcome>_models_xclass_tidy.csv
- output/figures/<outcome>_appendix_congruence_panels.png
