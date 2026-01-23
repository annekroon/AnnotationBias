# Annotation Bias 

This repository contains a reproducible data pipeline for collecting, annotating,
and analyzing X/Twitter posts by Dutch Members of Parliament, combined with crowd-annotation data. The code supports the analyses reported in:

*The Politics of Annotation: How Ideology, Implicit Bias, and Task Design Shape
Crowd Judgments of Political Tweets*

---

## Pipeline Overview

The notebooks must be run sequentially:

00_get-Xaccounts-MPs.ipynb  
→ 01_get_twitter_data.ipynb  
→ 02_prepare_data_for_analysis.ipynb  
→ 03_attrition_check.ipynb  
→ 04_sample_descriptives.ipynb  
→ 05_irr_reliability.ipynb  
→ 06_hypotheses_testing.ipynb  

Each step writes intermediate datasets to disk that are reused downstream.

---

## Repository and Data Structure

This repository contains code and documentation only.
All large data files and analytical outputs are stored on the
UvA Research Drive and accessed programmatically via WebDAV.

The pipeline assumes the following directory structure on the
Research Drive (not tracked in this repository):

- `data/`
  - `X_data/` – tweet-level datasets
  - `AnnoTinder_data_exports/` – annotation exports
  - `Qualtrics_data_exports/` – survey exports
- `output/`
  - `tables/` – LaTeX and CSV tables
  - `figures/` – figures for the appendix
  - `derived/` – derived parquet datasets

Paths to the Research Drive and WebDAV credentials are defined
in `config.py`.

---

## Computational Environment

The analyses were run in Python 3.10.12
Package versions are documented in `requirements.txt` / `environment.yml`

---

## Configuration and Credentials

External services (e.g., X/Twitter via TWi-XL API, WebDAV Research Drive access)
require credentials that are **not tracked** in this repository.

All secrets are expected to be defined in:
- `config.py` (not committed)

Paths, API keys, and WebDAV credentials must be provided by the user.


---

## How to Reproduce

1. Install the required Python environment.
2. Populate `config.py` with valid paths and credentials.
3. Run notebooks sequentially from `00_` to `06_`.
4. All tables and figures used in the paper are written to `output/`.

For details on inputs, outputs, and analytical logic, see `docs/pipeline.md`.



