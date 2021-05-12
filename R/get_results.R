#' Helper function: get metadata for selected elements
#' @param name of element to select. one of: c("subcatchments", "nodes", "links", "system")
#' @param path_out path to SWMM output file
#' @return tibble with columns "name", "itype", "vindex" and corresponding IDs required for \link[swmmr]{read_out}
#' @export
#' @importFrom  tibble tibble
#' @examples
#' get_itype(name = "subcatchments")
get_meta <- function(name,
                     path_out) {

  elements <- swmmr::get_out_content(path_out)

  n_pollutants <- length(elements$pollutants$names)

  possible_elements <- c("subcatchments", "nodes", "links", "system")
  elements <- tibble::tibble(name = possible_elements,
                             vindex = c(7 +  n_pollutants,
                                        5 +  n_pollutants,
                                        4 +  n_pollutants,
                                        14),
                             itype = 0:3)

  stopifnot(name %in%  possible_elements)

  elements[elements$name == name, ]

}

#' Helper function: get parameters from result list
#' @param result_list result_list
#' @return tibble with columns "name", "itype", "vindex" and corresponding IDs required for \link[swmmr]{read_out}
#' @export
#' @importFrom data.table as.data.table rbindlist
#' @importFrom dplyr rename
#' @importFrom tidyr pivot_wider
#' @return tibble with parameters in "wide" format
#' @keywords internal
#' @noRd
read_results_parameters <- function(result_list) {
  result_list %>%
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


#' Get Results for System
#'
#' @param path_out path to SWMM output file
#' @param vIndex indexes of system wide indexes to be imported. By default
#' all indexes will be imported (default: NULL). If only selected vIndex`s should
#' be imported have a look at the documentation of \link[swmmr]{read_out}
#' @return tibble with selected system variables
#' @importFrom swmmr read_out
#' @keywords internal
#' @noRd

get_results_system <- function(path_out,
                               vIndex = NULL) {


  meta <- get_meta("system", path_out)

  if(is.null(vIndex)) {
    vIndex <- seq_len(meta$vindex)
  }

  stopifnot(vIndex %in% seq_len(meta$vindex))

  swmmr::read_out(path_out, iType = meta$itype, vIndex = vIndex)[[1]] %>%
    read_results_parameters()

}

#' Get Results for Elements
#'
#' @param path_out path to SWMM output file
#' @param type output type, select from c("subcatchments" "nodes", "links"),
#' default: "system"
#' @param object_name object_name
#' @param vIndex indexes of system wide indexes to be imported. By default
#' all indexes will be imported (default: 1:14). If only selected vIndex`s should
#' be imported have a look at the documentation of \link[swmmr]{read_out}
#'
#' @return tibble with selected system variables
#' @importFrom swmmr read_out
#' @keywords internal
#' @noRd


get_results_elements <- function(path_out,
                                 type = "links",
                                 object_name = NULL,
                                 vIndex = NULL) {

  meta <- get_meta(type, path_out)

  object_names_available <- swmmr::get_out_content(paths$model_out)[[type]]$names

  if(is.null(object_name)) {
    object_name <- object_names_available
  }
  if(is.null(vIndex)) {
    vIndex <- seq_len(meta$vindex)
  }

  stopifnot(vIndex %in% seq_len(meta$vindex))
  stopifnot(object_name %in% object_names_available)

  stats::setNames(lapply(swmmr::read_out(path_out,
                  iType = meta$itype,
                  object_name = object_name,
                  vIndex = vIndex), function(object) {
                    read_results_parameters(object)
                  }),
                  nm = object_name)
}

#' Get Results
#'
#' @param path_out path to SWMM output file
#' @param type output type, select from c("subcatchments" "nodes", "links" or "system"),
#' default: "system"
#' @param object_name Sets the objects of which time series data is returned.
#' if NULL all objects will be returned (default: NULL)
#' @param vIndex indexes of system wide indexes to be imported. By default
#' all indexes will be imported (default: NULL). If only selected vIndex`s should
#' be imported have a look at the documentation of \link[swmmr]{read_out}
#' @return for "system" a tibble with selected system variables, for all other "type"
#' a list with sublists for each "object_name"
#' @export
#' @importFrom swmmr get_out_content read_out
#' @importFrom data.table as.data.table rbindlist
#' @importFrom dplyr rename
#' @importFrom tidyr pivot_wider
#' @examples
#' \dontrun{
#' path_out_file <- "path-to-my-swmm-output-file"
#' results_subcatchments <- kwb.swmm::get_results(path_out_file, type = "subcatchments")
#' results_links <- kwb.swmm::get_results(path_out_file, type = "links")
#' results_nodes <- kwb.swmm::get_results(path_out_file, type = "nodes")
#' results_system <- kwb.swmm::get_results(path_out_file, type = "system")
#' }

get_results <- function(path_out,
                        type = "system",
                        object_name = NULL,
                        vIndex = NULL) {

  stopifnot(type %in% c("subcatchments", "nodes", "links", "system"))

  meta <- get_meta(type, path_out)

  if(is.null(vIndex)) {
    vIndex <- seq_len(meta$vindex)
  }

  stopifnot(vIndex %in% seq_len(meta$vindex))

  if(type == "system") {
    get_results_system(path_out, vIndex = vIndex)
  } else {
    get_results_elements(path_out,
                         type = meta$name,
                         object_name = object_name,
                         vIndex = vIndex)
  }
}


