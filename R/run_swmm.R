#' Run SWMM
#'
#' @description allows to run SWMM model in model folder, i.e. it is possible
#' to define paths to climate data in swmm_model.inp with relative paths (if these
#' are contained in the same folder or a subfolder of the `model_dir`)
#' @param model_dir model directory with 'model.inp'
#' @param model_inp name of model input fike 'model.inp'
#' @param exe path to SWMM executabvle
#' @param ... additional arguments passed to \code{shell}
#' @return runs SWMM
#' @export
#' @importFrom kwb.utils removeExtension
run_swmm <- function(model_dir,
                     model_inp,
                     exe,
                     ...) {

if(!file.exists(exe)) {
  stop(sprintf("SWMM excecutable path '%s' does not exist",
                                   exe))
}

model_inp <- basename(model_inp)
model_path <- file.path(model_dir, model_inp)

if(!file.exists(model_path)) {
  stop(sprintf("Model input path '%s' does not exist", model_path))
}

inp <-  kwb.utils::removeExtension(model_inp)
model_out <- paste0(inp, ".out")
model_rpt <- paste0(inp, ".rpt")

cmd <- sprintf('cd "%s" && "%s" "%s" "%s" "%s"',
               model_dir,
               exe,
               model_inp,
               model_rpt,
               model_out)

shell(cmd)
}

