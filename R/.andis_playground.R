

paths_list <- list(
  model_dir =  "C:/Users/amatzi/Documents/github-repos/kwb.swmm/inst/extdata/models/workshop",
  model_name = "Testgebiet_imp",
  model_inp = "<model_dir>/<model_name>.inp",
  model_out = "<model_dir>/<model_name>.out",
  model_rpt = "<model_dir>/<model_name>.rpt",
  swmm_dir = "C:/_UserProg/EPA SWMM 5.1.015",
  swmm_exe = "<swmm_dir>/swmm5.exe"
)

paths <- kwb.utils::resolveAll(paths_list)

swmmr::run_swmm(inp = paths$model_inp,
                rpt = paths$model_rpt,
                out = paths$model_out,
                exec = paths$swmm_exe)


paths_list <- list(
  model_dir =  kwb.swmm::extdata_file("models/green-roof_neubrandenburg"),
  model_name = "neubrand",
  model_inp = "<model_dir>/<model_name>.inp",
  model_out = "<model_dir>/<model_name>.out",
  model_rpt = "<model_dir>/<model_name>.rpt",
  swmm_dir = "C:/_UserProg/EPA SWMM 5.1.015",
  swmm_exe = "<swmm_dir>/swmm5.exe"
)

paths <- kwb.utils::resolveAll(paths_list)

