
#' Helper function: converts l/s into mm/h
#'
#' @param values values in liter per second
#'
#' @return values in mm per hour
#' @export
#'
#' @examples
#' lps_to_mmPerHour(1)
lps_to_mmPerHour <- function(values) {
  values * 3.6
}
