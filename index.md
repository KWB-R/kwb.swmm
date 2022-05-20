[![R-CMD-check](https://github.com/KWB-R/kwb.swmm/workflows/R-CMD-check/badge.svg)](https://github.com/KWB-R/kwb.swmm/actions?query=workflow%3AR-CMD-check)
[![pkgdown](https://github.com/KWB-R/kwb.swmm/workflows/pkgdown/badge.svg)](https://github.com/KWB-R/kwb.swmm/actions?query=workflow%3Apkgdown)
[![codecov](https://codecov.io/github/KWB-R/kwb.swmm/branch/main/graphs/badge.svg)](https://codecov.io/github/KWB-R/kwb.swmm)
[![Project Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/kwb.swmm)]()

R package with functions for working with EPA`s
Storm Water Management Model
[SWMM](https://www.epa.gov/water-research/storm-water-management-model-swmm).

## Installation

For installing the latest release of this R package run the following code below:

```r
# Enable repository from kwb-r
options(repos = c(
  kwbr = 'https://kwb-r.r-universe.dev',
  CRAN = 'https://cloud.r-project.org'))
  
# Download and install kwb.swmm in R
install.packages('kwb.swmm')

# Browse the kwb.swmm manual pages
help(package = 'kwb.swmm')
```
## Usage 

Checkout the [Workflow](../articles/workflow.html) article on how to use this R package.
