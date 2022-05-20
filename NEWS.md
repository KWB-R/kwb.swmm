# [kwb.swmm 0.1.0](https://github.com/KWB-R/kwb.swmm/releases/tag/v0.1.0) <small>2022-05-20</small>

* **Functions**

  + `download_swmm_executable()`: downloads `SWMM` executable from USEPA`s GitHub 
  repo of [https://github.com/USEPA/Stormwater-Management-Model/releases](https://github.com/USEPA/Stormwater-Management-Model/releases)
  
  + `run_swmm()`: compared to `swmmr::run_swmm()`it allows to use allows to run 
  SWMM model in model folder, i.e. it is possible to define paths to climate data 
  in swmm_model.inp with relative paths (if these are contained in the same folder 
  or a subfolder of the `model_dir`)
  
  + `get_results()` function for importing SWMM results into R
  
  + `calculate_rainevent_stats()` for aggregation of imported `results` based 
  on user-defined column (default: `total_runoff`), `function` (default: `sum`) and 
  `event separation time`
  
  + `get_lid_para_types()`: returning tidy tibble with expected/possible system elements
  for different low impact development elements

* [Workflow](../articles/workflow.html) on how to use this R package  

# kwb.swmm 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.

* see https://style.tidyverse.org/news.html for writing a good `NEWS.md`


