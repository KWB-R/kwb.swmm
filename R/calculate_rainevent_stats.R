#' Calculate Rain Events
#'
#' @param results_system data frame as retrieved by \code{\link{get_results_system}}
#' @param aggregation_function function to be used for aggregation and passed to
#' \link[kwb.event]{getEventStatistics} (default: "sum")
#' @param signalThreshold passed to \link[kwb.event]{getEvents}, Value that needs
#' to be exceeded (signalComparisonOperator == "gt") or reached (signalComparisonOperator == "ge")
#' by the rain heights (or intensities) in order to be counted as a "signal".
#' default: 0
#' @param eventSeparationTime eventSeparationTime passed to \link[kwb.event]{getEvents}
#' (default: 6*3600)
#' @param ... additional arguments passed to \link[kwb.event]{getEvents}
#' @return tibble with statistics for all rain events
#' @export
#' @importFrom kwb.utils catAndRun
#' @importFrom kwb.event getEventStatistics getEvents
#' @importFrom stats setNames
#' @importFrom tidyselect all_of
#' @examples
#' \dontrun{
#' path_out_file <- "path-to-my-swmm-output-file"
#' results_system <- kwb.swmm::get_results_system(path_out = path_out_file)
#' rainevent_stats <- calculate_rainevent_stats(results_system,
#'                            aggregation_function = "sum",
#'                            signalThreshold = 0,
#'                            eventSeparationTime = 6*3600)
#' }
calculate_rainevent_stats <- function(results_system,
                                      aggregation_function = "sum",
                                      signalThreshold = 0,
                                      eventSeparationTime = 6*3600,
                                      ...) {

  rain_events <- kwb.event::getEvents(rainData = results_system[, c("datetime", "total_rainfall")],
                                      seriesName = "total_rainfall",
                                      signalThreshold = signalThreshold,
                                      eventSeparationTime = eventSeparationTime,
                                      ...)



  paras <- names(results_system)[names(results_system) != "datetime"]

  para_aggr_name <- sprintf("%s_%s", aggregation_function, paras)

  event_stats <- stats::setNames(lapply(paras, function(para) {
    para_aggrfunc <- sprintf("%s_%s", aggregation_function, para)
    msg_text <- sprintf("Calculating `%s` event stats for parameter `%s`",
                        aggregation_function,
                        para)
    kwb.utils::catAndRun(messageText = msg_text,
                         expr = {
                           kwb.event::getEventStatistics(dataFrame = results_system,
                                                         seriesName = para,
                                                         events = rain_events,
                                                         functions = aggregation_function
                           ) %>%
                             dplyr::rename(value = tidyselect::all_of(aggregation_function))
                         })}), nm =   para_aggr_name)


  event_stats_wide <-  event_stats %>%
    dplyr::bind_rows(.id = "key") %>%
  tidyr::pivot_wider(names_from = "key",
                     values_from = "value")


  rain_events %>%
    dplyr::mutate(event = dplyr::row_number()) %>%
    dplyr::left_join(event_stats_wide)

}
