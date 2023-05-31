#' @title
#' Convert to yearly
#'
#' @description
#' Function takes the finished data frame and converts it to a yearly
#' ts. There are three different aggregation methods.
#'
#' @details
#' A new column is added (year) derived from the date column.
#' The `type` argument specifies the type of the aggregation.
#' With the added columns, a aggregation is made.
#'
#' @param df Finished data frame returned from `pull_data`
#' @param type Method of aggregation. One can choose between `mean`, `median` and
#' `sum`.
#'
#' @return
#' Converted data frame
#' @export
#'
#' @importFrom stats median
#' @importFrom lubridate year
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
#' Function takes the finished data frame and converts it to a monthly
#' ts. There are three different aggregation methods.
#'
#' @details
#' Two new columns are added (year, month) derived from the date column.
#' The `type` argument specifies the type of the aggregation.
#' With the added columns, a aggregation is made.
#'
#' @param df Finished data frame returned from `pull_data`
#' @param type Method of aggregation. One can choose between `mean`, `median` and
#' `sum`
#'
#' @export
#' @importFrom stats median
#' @importFrom lubridate year month
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
#' Function takes the finished data frame and converts it to a weekly
#' ts. There are three different aggregation methods.
#'
#' @details
#' A new column is added (week) derived from the date column.
#' The `type` argument specifies the type of the aggregation.
#' With the added columns, a aggregation is made.
#'
#' @param df Finished data frame returned from `pull_data`
#' @param type Type of aggregation. One can choose between `mean`, `median` and
#' `sum`
#'
#' @export
#' @importFrom stats median
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
#' Function takes the finished data frame and converts it to a daily
#' ts. There are three different aggregation methods.
#'
#' @details
#' The `type` argument specifies the type of the aggregation.
#' With the date column, the data is being aggregated.
#'
#' @param df Finished data frame returned from `pull_data`
#' @param type Type of aggregation. One can choose between `mean`, `median` and
#' `sum`
#'
#' @export
#' @importFrom stats median
to_daily <- function(df, type = c("mean", "median", "sum")){
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
