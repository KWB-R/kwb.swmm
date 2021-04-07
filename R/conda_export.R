#' conda_export
#'
#' @param condaenv name or path of conda environment to export
#' @param export_dir export directory (default: tempdir())
#'
#' @return creates  export_dir/environment_condaenv.yml and returns path
#' @export
#' @importFrom reticulate miniconda_path py_config use_miniconda
#'
conda_export <- function(condaenv, export_dir = tempdir()) {
  stopifnot(dir.exists(reticulate::miniconda_path()))
  stopifnot(dir.exists(export_dir))
  reticulate::use_miniconda(condaenv = condaenv, required = TRUE)
  pyconfig <- reticulate::py_config()

  ## on windows: (try this: https://github.com/rstudio/reticulate/issues/367#issuecomment-432920802)
  if(.Platform$OS.type == "windows") {
    Sys.setenv(PATH = paste(PATH = pyconfig$pythonpath,
                            Sys.getenv()["PATH"], sep=";")
    )
  }

  path_env_yml <- file.path(export_dir, paste0("environment_", condaenv, ".yml"))

  sys_name <- as.character(Sys.info()['sysname'])

  cmds <- sprintf("conda activate %s && conda env export > %s",
                  condaenv,
                  path_env_yml)

   if(sys_name == "Windows") {
    shell(cmd = cmds)
  } else {
    system2(command = cmds)
  }

  stopifnot(file.exists(path_env_yml))
  path_env_yml
}
