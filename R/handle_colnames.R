## For Transmission mainly
#' @name
#' Get short display names
#'
#' @description
#' Function pulls the name of the location from the eic code.
#'
#'
#' @param rlst Rlst raw list, converted xml response to list
#' @param eic Data frame with the area codes (areaY from the Entso-E website)
#'
#' @return Short display name of the country/region/area
get_displayName <- function(rlst, eic) {
  inDomain <- rlst$TimeSeries$in_Domain.mRID[[1]]
  outDomain <- rlst$TimeSeries$out_Domain.mRID[[1]]
  short_in <- eic[eic[, 1] == inDomain, 2]
  short_out <- eic[eic[, 1] == outDomain, 2]
  return(list(short_in, short_out))
}

#' @title
#' Set colnames of final data frame
#'
#' @description
#' Function sets colnames based on the returned parameters.
#'
#' @details
#' With the function `get_params` all parameters from the raw data
#' is pulled. From that, the function determines the appropriate
#' colnames. The function checks if the input is in the correct
#' format (data frame).
#'
#' @param df Data frame with date, value and possible more information
#' @param rawdat Converted XML response to list
#'
#' @return Returns data frame with set colnames
#' @importFrom dplyr case_when
set_colnames <- function(df, rawdat) {
  params <- get_params(rawdat)
  if ("data.frame" %in% class(df)) {
    if (!is.null(params$ProcessType) & !is.null(params$ObjectAggregation)) {
      tmp <- dplyr::case_when(
        params$Type == "A71" &
          params$ProcessType == "A01" &
          params$BusinessType == "A01" &
          params$ObjectAggregation == "A01" &
          ncol(df) == 3 ~ list(c("Date", "Scheduled Generation", "Scheduled Consumption")),
        params$Type == "A65" &
          params$ProcessType == "A01" &
          params$BusinessType == "A04" &
          params$ObjectAggregation == "A01" &
          ncol(df) == 2 ~ list(c("Date", "Day-ahead Total Load Forecast")),
        params$Type == "A65" &
          params$ProcessType == "A16" &
          params$BusinessType == "A04" &
          params$ObjectAggregation == "A01" ~ list(c("Date", "Actual Total Load")),
        params$Type == "A65" &
          params$ProcessType %in% c("A31", "A32", "A33") &
          params$BusinessType == "A60" &
          params$ObjectAggregation == "A01" ~ list(c("Date", "Min Total Load", "Max Total Load")),
        params$Type == "A70" &
          params$ProcessType == "A33" &
          params$BusinessType == "A91" &
          params$ObjectAggregation == "A01" ~ list(c("Date", "Forecast margin")),
        # Installed capacity per production unit
        params$Type == "A68" &
          params$ProcessType == "A33" &
          params$BusinessType == "A37" &
          params$ObjectAggregation == "A08" ~ list(c("Date", "Value")),
        # Installed Generation Capacity per Unit
        params$Type == "A71" &
          params$ProcessType == "A33" &
          params$BusinessType == "A37" &
          params$ObjectAggregation == "A06" ~ list(c("Date", "Installed Capacity at the beginning of the year")),
        TRUE ~ list(c(colnames(df)))
      ) %>% unlist()
    } else {
      # Transmission
      tmp <- dplyr::case_when(
        params$Type == "A61" &
          is.null(params$ProcessType) &
          is.null(params$ObjectAggregation) &
          params$BusinessType == "A27" ~ list(c("Date", paste("BZN|", get_displayName(rawdat, areaY)[[2]],
          ">BZN|", get_displayName(rawdat, areaY)[[1]],
          sep = ""
        ))),
        TRUE ~ list(c(colnames(df)))
      ) %>% unlist()
    }
    colnames(df) <- tmp
  } else {
    "Data not in the correct format. Make sure you converted the response correctly"
  }
  return(df)
}



#' @title
#' Create dynamic colnames
#'
#' @description
#' Function dynamically creates colnames. Used for each
#' unique data point.
#'
#' @details
#' Append the processtype (e.g. intraday total) to the colnames. This
#' is done with the `get_params` function.
#'
#' @param df Final data frame (without proper colnames)
#' @param rawdat Converted XML response to list
#' @param codeList CodeList (data frame that comes with this package)
#' @param onlyTS_dat List of data containing only the time series data
#' @param PSR If PSR is true, old colnames and process names are pasted together to
#' form the new colnames
#'
#' @return Vector with correct colnames
dynamic_colnames <- function(df, rawdat, onlyTS_dat, codeList, PSR = FALSE) {
  params <- get_params(rawdat)[c("BusinessType", "ProcessType")]
  process_index <- which(codeList$ProcessTypeList$CODE %in% params[[2]])
  proc_name <- codeList$ProcessTypeList[
    process_index,
    "DEFINITION"
  ]
  business_index <- which(codeList$BusinessTypeList$CODE %in% business_types(onlyTS_dat))
  bus_name <- codeList$BusinessTypeList[
    business_index,
    "DEFINITION"
  ]
  type <- generation_consumption(ts_dat = onlyTS_dat)
  if (PSR) {
    col_names <- colnames(df)[-1]
    full_name <- c("Date", paste(proc_name, col_names))
  } else {
    if (grepl("generation|Generation|consumption|Consumption", bus_name)) {
      full_name <- c("Date", paste(proc_name, bus_name))
    } else {
      full_name <- c("Date", paste(paste(proc_name, bus_name), type))
    }
  }
  return(full_name)
}


#' @title
#' Get Business Types
#'
#' @description
#' Function gets the businesstype from raw data.
#'
#' @details
#' Function is subject to change. Lifecycle is experimental.
#'
#' @param ts_dat Response converted to onlyTS
#'
#' @return Vector of business types
business_types <- function(ts_dat) {
  all_bsn_types <- lapply(ts_dat, function(x) {
    x$businessType
  }) %>%
    unlist() %>%
    unique()
  return(all_bsn_types)
}


#' @title
#' Add "Generation" and/or "Consumption" to colnames
#'
#' @description
#' Function searches for the name "BiddingZone_Domain.mRID" and returns
#' if the data point is generation or consumption
#'
#' @details
#' For each "TimeSeries" object the function evaluates if the parameter
#' `outBiddingZone_Domain.mRID` or `inBiddingZone_Domain.mRID` is present.
#' This needs to be done to determine for some data points if the returned
#' data is for generation or consumption. The function also checks if the last
#' word of the colnames already is generation or consumption
#'
#' @param ts_dat Response converted to onlyTS
#'
#' @return Vector with unique values
generation_consumption <- function(ts_dat) {
  vec <- lapply(ts_dat, function(x) {
    tmp <- grep("BiddingZone_Domain.mRID", names(x))
    ind <- c()
    if (grepl("^in", names(x)[tmp])) {
      ind <- c(ind, "Generation")
    } else {
      ind <- c(ind, "Consumption")
    }
  })
  vec <- unlist(vec) |> unique()
  return(vec)
}
