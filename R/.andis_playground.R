

### general tests---------------------------

#setwd("C:/Aendu_lokal/SWMM_WB/Input_Files")

paths_list <- list(
  model_dir =  "C:/Aendu_lokal/SWMM_WB/Input_Files",
  model_name = "Testgebiet_LID_andi",
  model_inp = "<model_dir>/<model_name>.inp",
  model_out = "<model_dir>/<model_name>.out",
  model_rpt = "<model_dir>/<model_name>.rpt",
  swmm_dir = "C:/_UserProg/EPA SWMM 5.1.015",
  swmm_exe = "<swmm_dir>/swmm5.exe"
)

paths <- kwb.utils::resolveAll(paths_list)

inp <- swmmr::read_inp(paths$model_inp)

swmmr::write_inp(inp, file = paths$model_inp)


swmmr::run_swmm(inp = paths$model_inp,
                rpt = paths$model_rpt,
                out = paths$model_out,
                exec = paths$swmm_exe)

out <- swmmr::read_out(file = paths$model_out, iType = 1, object_name = c("J1", "J2", "J3", "J4"), vIndex = 5)


#### lets optimize 1----------------------

## set paths
  paths_list <- list(
    model_dir =  "C:/Temp",
    model_name = "Testgebiet_imp",
    model_inp = "<model_dir>/<model_name>.inp",
    model_out = "<model_dir>/<model_name>.out",
    model_rpt = "<model_dir>/<model_name>.rpt",
    swmm_dir = "C:/_UserProg/EPA SWMM 5.1.015",
    swmm_exe = "<swmm_dir>/swmm5.exe",
    climate_dir = "C:/Aendu_lokal/SWMM_WB/Input_Files"
  )

  paths <- kwb.utils::resolveAll(paths_list)

##read R file
  inp <- swmmr::read_inp(paths$model_inp)

##run with varying conduit depths
  # number of runs
    n <- 1000

  #result file
    result_vol <- data.frame("run" = c(1:n),
                         "J1" = NA,
                         "J2" = NA,
                         "J3" = NA,
                         "J4" = NA)
    parameter_inp <- data.frame("run" = c(1:n),
                                "C1" = NA,
                                "C2" = NA,
                                "C3" = NA,
                                "C4" = NA)

  # base depth
    base_depth <- 0.8
    sigma_depth <- 0.35

  # do the monty
    for (i in 1:n) {

      #select conduit depths

      for (c in 1:length(inp$xsections$Link)) {
        inp$xsections$Geom1[c] <- rnorm(n = 1, mean = base_depth, sd = sigma_depth)
        parameter_inp[i, c+1] <- inp$xsections$Geom1[c]
      }

      #write new input file
      swmmr::write_inp(inp, file = paths$model_inp)

      #run swmm
      withr::with_dir(new = paths$climate_dir,
                      code = {swmmr::run_swmm(inp = paths$model_inp,
                                              rpt = paths$model_rpt,
                                              out = paths$model_out,
                                              exec = paths$swmm_exe)
                      }
      )

      #read output (surface flooding of junctions)
      out <- swmmr::read_out(file = paths$model_out,
                             iType = 1,
                             object_name = c("J1", "J2", "J3", "J4"),
                             vIndex = 5)

      #calculate and store overflow volume in m3
      for (junction in c("J1", "J2", "J3", "J4")) {


        result_vol[[junction]][i] <- sum(out[[junction]]$surface_flooding
                                           * 15 * 60)/1000

      }
    print(i)
    }


