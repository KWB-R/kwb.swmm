# extdata_file -----------------------------------------------------------------

#' Get Path to File in This Package
#'
#' @param \dots parts of path passed to \code{\link{system.file}}
#' @export
extdata_file <- function(...) {
  system.file("extdata", ..., package = "kwb.swmm")
}


#' Convert squaremeter to hectar
#'
#' @param squaremeter squaremeter
#'
#' @return returns hectars
#' @export
#'
#' @examples
#' squaremeter_to_hectar(10000)
#'
squaremeter_to_hectar <- function(squaremeter) {
  squaremeter / 10000
}

