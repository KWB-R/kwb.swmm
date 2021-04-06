#' get_lid_para_types
#'
#' @return returns tidy data frame with required parameteration for LIDs based
#' on SWMM documentation
#' @export
#' @importFrom readr read_csv
#' @importFrom tidyr pivot_longer
#' @importFrom tidyselect starts_with
#' @examples
#' get_lid_para_types()
#'
get_lid_para_types <- function() {

lid_csv <- extdata_file("lid/required_parameteristion.csv")

lid_paras <- readr::read_csv(lid_csv)
tidyr::pivot_longer(lid_paras,
                    cols = ! tidyselect::starts_with("lid_"),
                    names_to = "type",
                    values_to = "value")
}
