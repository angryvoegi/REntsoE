library(httr)
library(xml2)
library(dplyr)

#' @title
#' Set your API key
#'
#' @description
#' `set_apikey` sets your API key to the environment variable
#'
#' @details
#' This function sets the API Key to the environment
#' By setting this key, the functions to pull the data
#' can rely on the environment rather than passing the key
#' each time. The key is stored in the `ENTSOE_KEY` environment
#' variable. It also checks if you already set a key.
#'
#' @param key This is the ENSTO-E API Key
#' @export
set_apikey <- function(key) {
  if (identical(Sys.getenv("ENTSOE_KEY"), "")) {
    stopifnot("Key has to be a string" = is.character(key))
    Sys.setenv("ENTSOE_KEY" = key)
  } else {
    message("Already set an API Key for the ENTSO-E platform...")
  }
}




#' @title
#' Convert XML to list
#'
#' @description
#' `convert_xml` returns a list from a xml response
#'
#' @details
#' This function converts the xml response to a list
#' From that list, the timeInterval, the period and
#' the raw data is extracted and returned as a list
#' with three sublists
#'
#' @param xml Response object from the api call
#'
#' @return list of response
#' @export
convert_xml <- function(xml) {
  # convert xml to list
  tmp <- httr::content(xml, encoding = "UTF-8") %>%
    xml2::as_list(.)
  temp <- tmp$GL_MarketDocument
  if (is.null(temp)) {
    temp <- tmp$Publication_MarketDocument
  }
  return(temp)
}


#' @title
#' Catch API errors
#'
#' @description
#' Function checks the API status code
#'
#' @details
#' Based on the API status code, the function evaluates
#' if the response is valid or not. If not, a message is
#' displayed
#'
#' @param req response from the api call
#' @export
api_error <- function(req) {
  stat_code <- req$status_code
  if (stat_code == 503) {
    cat("Service unavailable. Try again in a few minutes and check the website
          https://transparency.entsoe.eu/")
  } else if (stat_code == 404) {
    cat("Something went wrong.")
  } else if (stat_code == 400) {
    cat("Bad request.")
  }
}

