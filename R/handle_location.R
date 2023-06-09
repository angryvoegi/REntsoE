#' @title
#' Get location from mRID
#'
#' @description
#' Function takes the mRID from the pulled data and matches
#' it with the `eicLoc` data frame to get the real name.
#'
#' @details
#' Takes all the unique Resource mRIDs from the raw data
#' and matches them to the eicLoc table, extracting the name
#' of the power plan.
#'
#' @param rawdat Converted XML response to list
#' @param eicLoc Data frame that comes with the package (see eicLoc)
#'
#' @return Returns a vector with the locations
get_Locations <- function(rawdat, eicLoc) {
  tmp <- rawdat[names(rawdat) == "TimeSeries"]
  rawLoc <- lapply(tmp, function(x) {
    x$registeredResource.mRID[[1]]
  }) %>% unlist()
  fin <- eicLoc[match(rawLoc, eicLoc$mRID), "Name"]
  return(fin)
}

#' @title
#' Add location to data frame
#'
#' @description
#' Function calls the `get_Locations` function to get the country/location name.
#'
#' @details
#' Adds a column to the finished data frame, appending the corresponding locations.
#'
#' @param df Final data frame with the aggregated data
#' @param rawdat Locations as text not EIC
#'
#' @return Data frame
append_location <- function(df, rawdat) {
  col_names <- colnames(df)
  df <- cbind(df, data.frame(Location = get_Locations(rawdat, eicLoc = eicLoc)))
  return(df)
}
