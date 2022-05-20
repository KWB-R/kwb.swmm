#' Download SWMM executable (currently only for windows only!)
#'
#' @description  downloads `SWMM` executable from USEPA`s GitHub repo of
#' [https://github.com/USEPA/Stormwater-Management-Model/releases](https://github.com/USEPA/Stormwater-Management-Model/releases)
#'
#' @param tdir target directory for unzipping zip files
#' @param swmm_version desired SWMM version, one of: "5.2.0", "5.1.15", "5.1.14",
#' "5.1.13" (default: "5.2.0")
#'
#' @return path to download "runswmm.exe"
#' @export
#' @importFrom archive archive_extract
#' @importFrom rlang .data
#' @importFrom kwb.utils catAndRun
#' @importFrom fs path_norm
#' @examples
#' download_swmm_executable()
#'
download_swmm_executable <- function(tdir = tempdir(),
                                     swmm_version = "5.2.0") {
  os <- "win64"
  repo <- "https://github.com/USEPA/Stormwater-Management-Model"
  url <- sprintf(
    "%s/releases/download/v%s/swmm-solver-%s-%s.zip",
    repo,
    swmm_version,
    swmm_version,
    os
  )
  swmm_versions <- c("5.2.0", "5.1.15", "5.1.14", "5.1.13")


  if (!swmm_version %in% swmm_versions) {
    msg <-
      sprintf(
        "Selected SWMM version '%s' is not available!\nPlease use one of: %s\n",
        swmm_version,
        paste(swmm_versions, collapse = ", ")
      )
    stop(msg)
  }

  swmm_exe <- sprintf("%s/swmm-solver-%s-%s/bin/runswmm.exe",
                      fs::path_norm(tdir),
                      swmm_version,
                      os)

  if (file.exists(swmm_exe)) {
    msg <-
      "Skipping download of SWMM executable, as it was already downloaded before!"
    message(msg)
  } else {
    msg <- sprintf("Downloading and extracting SWMM folder to '%s'",
                   tdir)
    kwb.utils::catAndRun(messageText = msg,
                         expr = {
                           archive::archive_extract(archive = url,
                                                    dir = tdir)
                         })
  }

  if (!file.exists(swmm_exe)) {
    stop(sprintf(
      "SWMM executable not available at assumed path: '%s'",
      fs::path_norm(swmm_exe)
    ))
  }

  swmm_exe
}
