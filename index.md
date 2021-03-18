[![R-CMD-check](https://github.com/KWB-R/kwb.swmm/workflows/R-CMD-check/badge.svg)](https://github.com/KWB-R/kwb.swmm/actions?query=workflow%3AR-CMD-check)
[![pkgdown](https://github.com/KWB-R/kwb.swmm/workflows/pkgdown/badge.svg)](https://github.com/KWB-R/kwb.swmm/actions?query=workflow%3Apkgdown)
[![codecov](https://codecov.io/github/KWB-R/kwb.swmm/branch/main/graphs/badge.svg)](https://codecov.io/github/KWB-R/kwb.swmm)
[![Project Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/kwb.swmm)]()

R package with functions for working with EPA`s
Storm Water Management Model
[SWMM](https://www.epa.gov/water-research/storm-water-management-model-swmm).

## Installation

For details on how to install KWB-R packages checkout our [installation tutorial](https://kwb-r.github.io/kwb.pkgbuild/articles/install.html).

```r
### Optionally: specify GitHub Personal Access Token (GITHUB_PAT)
### See here why this might be important for you:
### https://kwb-r.github.io/kwb.pkgbuild/articles/install.html#set-your-github_pat

# Sys.setenv(GITHUB_PAT = "mysecret_access_token")

# Install package "remotes" from CRAN
if (! require("remotes")) {
  install.packages("remotes", repos = "https://cloud.r-project.org")
}

# Install KWB package 'kwb.swmm' from GitHub
remotes::install_github("KWB-R/kwb.swmm")
```
