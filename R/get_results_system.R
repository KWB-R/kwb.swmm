#' Get Results for System
#'
#' @param path_out path to SWMM output file
#' @param vIndex indexes of system wide indexes to be imported. By default
#' all indexes will be imported (default: 1:14). If only selected vIndex`s should
#' be imported have a look at the documentation of \link[swmmr]{read_out}
#'
#' @return tibble with selected system variables
#' @export
#' @importFrom swmmr read_out
#' @importFrom data.table as.data.table rbindlist
#' @importFrom dplyr rename
#' @importFrom tidyr pivot_wider

get_results_system <- function(path_out,
                               vIndex = 1:14) {

  # read out results itype 3 (= system) and all available vIndexes

  swmmr::read_out(path_out_file, iType = 3, vIndex = vIndex)[[1]] %>%
    lapply(function(output) {
      output %>%
        data.table::as.data.table() %>%
        dplyr::rename(datetime = "index",
                      value = "V1")
    }
    ) %>%
    data.table::rbindlist(idcol = "key") %>%
    tidyr::pivot_wider(names_from = "key", values_from = "value")
}
