# extdata_file -----------------------------------------------------------------

#' Get Path to File in This Package
#'
#' @param \dots parts of path passed to \code{\link{system.file}}
#' @export
extdata_file <- function(...) {
  system.file("extdata", ..., package = "kwb.swmm")
}


#' Helper function: squaremeter to hectar
#'
#' @param squaremeter squarmeter
#'
#' @return area in hectar
#' @export
#'
#' @examples
#' squaremeter_to_hectar(100)
squaremeter_to_hectar <- function(squaremeter) {
  squaremeter / 10000
}

#' Helper function: hectar to squaremeter
#'
#' @param hectar hectar
#'
#' @return area in hectar
#' @export
#'
#' @examples
#' squaremeter_to_hectar(100)
hectar_to_squaremeter <- function(hectar) {
  hectar * 10000
}

