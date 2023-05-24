#' @title
#' Return only "TimeSeries" objects
#'
#' @description
#' Function which only return "TimeSeries" objects
#'
#' @details
#' The response from the Entso-E API has a lot of
#' different elements called "TimeSeries". These elements
#' inlcude all the necessary information like point and
#' value. This function extracts all the elements with the
#' name "TimeSeries".
#'
#' @param rlst Raw list, converted xml response
#'
#' @return Only the lists which are named TimeSeries
only_ts <- function(rlst) {
  tmp <- rlst[which(names(rlst) == "TimeSeries")]
  return(tmp)
}

#' @title
#' Get the date from point
#'
#' @description
#' Function converts points to date&time
#'
#' @details
#' Function uses the `start` data point which is returned
#' by the API as a refference point. From that, it creates a sequence
#' with the periodicity of the response as well as the number of
#' points returned by the call. This sequence represents the dates
#' in the response.
#'
#' @param start StartInterval from the API response
#' @param n_points Number of datapoints
#' @param period Periodicity of the response
#'
#' @return Date sequence from start with length.out = n_points
#' and period = periodicity
points_to_time <- function(start, n_points, period) {
  ts_start <- start %>%
    as.POSIXct(tryFormats = c(
      "%Y-%m-%dT%H:%MZ",
      "%Y-%m-%dT%H:%M:%SZ",
      "%Y-%m-%d %H:%M",
      "%Y-%m-%d %H:%M:%S"
    ), tz = "UTC")
  period <- case_when(
    period == "PT15M" ~ "15 min",
    period == "PT30M" ~ "30 min",
    period == "PT60M" ~ "hour",
    period == "P1D" ~ "day",
    period == "P7D" ~ "1 week",
    period == "P1Y" ~ "1 year"
  )
  ts_dates <- seq(from = ts_start, by = period, length.out = n_points + 1)[-1]
  return(ts_dates)
}


#' @title
#' Apply date function to `TimeSeries` list
#'
#' @description
#' Function returns date-list from API response containing
#' only `TimeSeries` objects.
#'
#' @details
#' Function uses the points_to_time function to create the date sequence
#' It is needed to extract the different variables from the API response
#'
#' @param lst_ts TimeSeries object from the function only_ts
#'
#' @return Returns a list of the date sequence, depending on the number
#' of columns the API response had
date_from_lst <- function(lst_ts) {
  dates_lst <- lapply(lst_ts, function(x) {
    start <- x$Period$timeInterval$start[[1]]
    periodicity <- x$Period$resolution[[1]]
    position <- lapply(x$Period, function(y) y$position) %>%
      unlist() %>%
      as.numeric() %>%
      max()
    dates <- points_to_time(
      start = start, n_points = position,
      period = periodicity
    )
  })
  return(dates_lst)
}

#' @title
#' Get values from response
#'
#' @description
#' Using the `only_ts` function, this function returns only the values
#'
#' @details
#' Function pulls all the values from the response list (output from
#' `only_ts`). These values have the name point and the function returns
#' a list with the values
#'
#' @param lst_ts TimeSeries object from the function only_ts
#'
#' @return List with only values
values_from_lst <- function(lst_ts) {
  # lst_ts = dat2
  vals_lst <- lapply(lst_ts, function(x) {
    # x = lst_ts[[1]]
    points <- x$Period[names(x$Period) == "Point"]
    vals_lst <- lapply(points, function(y) {
      # y = points[[1]]
      y$quantity
    }) %>%
      unlist() %>%
      as.vector()
  })
  return(vals_lst)
}
