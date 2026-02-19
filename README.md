# PCA_400IM

Principal Component Analysis (PCA) and SVM classification of 400m Individual Medley swimming performance data.

## Overview

This repository contains MATLAB scripts for analyzing 400m individual medley (IM) race data. It uses PCA to identify the key performance variables that contribute most to total race time, and SVM classification to distinguish between competition levels (e.g., Men's Finals vs. Women's Preliminaries).

## Scripts

### `w400im.m` — PCA Analysis

Performs Principal Component Analysis on 400m IM race data including:
- **Swimming velocity** (sv) for each 50m segment
- **Stroke tempo** (st) for each 50m segment
- **Stroke length** (sl) for each 50m segment
- **Stroke count** (sc) for each 50m segment

Outputs:
- Contribution of each variable to total race time via PC1 loadings.
- Bar chart of sorted variable contributions.

### `wm400im.m` — SVM Classification

Uses K-means clustering + SVM with RBF kernel to:
- Cluster swimmers into two groups based on total time.
- Label clusters as "MenFinal" (faster) and "WomenPrelim" (slower).
- Train/test an SVM classifier and report accuracy.

## Requirements

- MATLAB R2019b or later
- Statistics and Machine Learning Toolbox

## Setup

Place your Excel data files in the `data/` directory:

```
PCA_400IM/
├── data/
│   ├── w400im.xlsx    # Data for PCA analysis
│   └── 400im.xlsx     # Data for SVM classification
├── w400im.m
└── wm400im.m
```

## Usage

```matlab
% Run PCA analysis
w400im

% Run SVM classification
wm400im
```
