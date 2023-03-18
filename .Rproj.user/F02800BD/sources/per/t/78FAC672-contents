#' @title
#' Convert to yealy
#'
#' @description
#' Function takes tha pulled data (dataframe) and converts it to yearly.
#'
#' @details
#' A new column is added (year) derived from the date column.
#' The `type` argument specifies the type of the aggregation.
#' With the added columns, a aggregation is made.
#'
#' @param df Dataframe pulled from the API
#' @param type Type of aggregation. One can choose between `mean`, `median` and
#' `sum`.
#'
#' @return
#' Converted dataframe
#' @export
#'
#' @import lubridate
#'
#' @usage
#' to_yearly(pull_data(
#'  documentType = "A65", processType = "A16",
#'  outBiddingZone_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"), "median")
to_yearly <- function(df, type = c("mean", "median", "sum")){
  type <- match.arg(type)
  cls_names <- colnames(df)[-1]
  df <- df %>%
    mutate(year = lubridate::year(Date)) %>%
    group_by(year) %>%
    summarise_if(is.numeric, lst(mean, median, sum)) %>%
    `colnames<-`(c("Year", as.vector(outer(cls_names, c("mean", "median", "sum"), paste, sep=" ")))) %>%
    select_if(grepl(paste(type, "$|Year", sep = ""), names(.)))
  return(df)
}

#' @title
#' Convert to Monthly
#'
#' @description
#' Function takes the pulled data (dataframe) and converts it to monthly.
#'
#' @details
#' Two new columns are added (year, month) derived from the date column.
#' The `type` argument specifies the type of the aggregation.
#' With the added columns, a aggregation is made.
#'
#' @param df Dataframe pulled from the API
#' @param type Type of aggregation. One can choose between `mean`, `median` and
#' `sum`
#'
#' @export
#'
#' @import lubridate
#'
#' @usage
#' to_monthly(pull_data(
#'  documentType = "A65", processType = "A16",
#'  outBiddingZone_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"), "median")
to_monthly <- function(df, type = c("mean", "median", "sum")){
  type <- match.arg(type)
  cls_names <- colnames(df)[-1]
  df <- df %>%
    mutate(year = lubridate::year(Date),
           month = lubridate::month(Date)) %>%
    group_by(year, month) %>%
    summarise_if(is.numeric, lst(mean, median, sum)) %>%
    `colnames<-`(c("Year", "Month",
                   as.vector(outer(cls_names, c("mean", "median", "sum"), paste, sep=" ")))) %>%
    select_if(grepl(paste(type, "$|Year|Month", sep = ""), names(.))) %>%
    mutate(Date = as.Date(paste(Year, "-", Month, "-01", sep = ""))) %>%
    ungroup() %>%
    select(-c("Year", "Month")) %>%
    relocate("Date")
  return(df)
}

#' @title
#' Convert to Weekly
#'
#' @description
#' Function takes the pulled data (dataframe) and converts it to weekly.
#'
#' @details
#' A new column is added (week) derived from the date column.
#' The `type` argument specifies the type of the aggregation.
#' With the added columns, a aggregation is made.
#'
#' @param df Dataframe pulled from the API
#' @param type Type of aggregation. One can choose between `mean`, `median` and
#' `sum`
#'
#' @export
#'
#' @import lubridate
#'
#' @usage
#' to_weekly(pull_data(
#'  documentType = "A65", processType = "A16",
#'  outBiddingZone_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"), "median")
to_weekly <- function(df, type = c("mean", "median", "sum")){
  type <- match.arg(type)
  cls_names <- colnames(df)[-1]
  df <- df %>%
    mutate(week = as.Date(as.character(cut(Date, "week")))) %>%
    group_by(week) %>%
    summarise_if(is.numeric, lst(mean, median, sum)) %>%
    `colnames<-`(c("Week", as.vector(outer(cls_names, c("mean", "median", "sum"), paste, sep=" ")))) %>%
    select_if(grepl(paste(type, "$|Week", sep = ""), names(.)))
  return(df)
}

#' @title
#' Convert to Daily
#'
#' @description
#' Function takes the pulled data (dataframe) and converts it to daily
#'
#' @details
#' The `type` argument specifies the type of the aggregation.
#' With the date column, the data is being aggregated.
#'
#' @param df Dataframe pulled from the API
#' @param type Type of aggregation. One can choose between `mean`, `median` and
#' `sum`
#'
#' @export
#'
#' @usage
#' to_daily(pull_data(
#'  documentType = "A65", processType = "A16",
#'  outBiddingZone_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"), "median")
to_daily <- function(df, type = c("mean", ",median", "sum")){
  type <- match.arg(type)
  cls_names <- colnames(df)[-1]
  df <- df %>%
    mutate(Date = format(df$Date, "%Y-%m-%d")) %>%
    group_by(Date) %>%
    summarise_if(is.numeric, lst(mean, median, sum)) %>%
    `colnames<-`(c("Date", as.vector(outer(cls_names, c("mean", "median", "sum"), paste, sep=" ")))) %>%
    select_if(grepl(paste(type, "$|Date", sep = ""), names(.))) %>%
    mutate(Date = as.Date(Date))
  return(df)
}
