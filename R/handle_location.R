#' @title
#' Get location from mRID
#'
#' @description
#' Function takes the mRID from the pulled data and matches
#' it with the `eicLoc` dataframe to get the real name
#'
#' @details
#' Takes all the unique Resource mRIDs from the raw data
#' and matches them to the eicLoc table, extracting the name
#' of the power plan
#'
#' @usage
#' get_Locations(rawdat, eicLoc = eicLoc)
#'
#' @param rawdat Converted XML response to list
#' @param eicLoc Dataframe that comes with the package (see eicLoc)
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
#' Add location to dataframe
#'
#' @description
#' Function calls the `get_Locations` function to get the country/location name
#'
#' @details
#' Adds a column to the finished dataframe, appending the corresponding locations
#'
#' @usage
#' append_location(finishedDF, rawdat = rawdat)
#'
#' @param df Final dataframe with the aggregated data
#' @param rawdat Locations as text not EIC
#'
#' @return Dataframe
append_location <- function(df, rawdat) {
  col_names <- colnames(df)
  df <- cbind(df, data.frame(Location = get_Locations(rawdat, eicLoc = eicLoc)))
  return(df)
}
