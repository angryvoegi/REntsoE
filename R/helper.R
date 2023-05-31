library(httr)
library(xml2)
library(dplyr)

#' @title
#' Set your API key
#'
#' @description
#' `set_apikey` sets your API key to the environment variable *ENTSOE_KEY*.
#'
#' @details
#' This function sets the API Key to the environment
#' By setting this key, the functions to pull the data
#' can rely on the environment rather than passing the key
#' each time. The key is stored in the `ENTSOE_KEY` environment
#' variable. It also checks if you already set a key.
#'
#' @param key The ENSTO-E API Key
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
#' `convert_xml` returns a list from a XML response.
#'
#' @details
#' This function converts the XML response to a list
#' From that list, the timeInterval, the period and
#' the raw data is extracted and returned as a list
#' with three sub-lists.
#'
#' @param xml Response object from the api call
#'
#' @return List of response
#' @importFrom httr content
#' @importFrom xml2 as_list
convert_xml <- function(xml) {
  tmp <- httr::content(xml, encoding = "UTF-8") %>%
    xml2::as_list()
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
#' Function checks the API status code.
#'
#' @details
#' Based on the API status code, the function evaluates
#' if the response is valid or not. If not, a message is
#' displayed.
#'
#' @param req Response from the API call
api_error <- function(req) {
  stat_code <- req$status_code
  if (stat_code == 503) {
    cat("Service unavailable. Try again in a few minutes and check the website
          https://transparency.entsoe.eu/")
    return(NA)
  } else if (stat_code == 404) {
    cat("Something went wrong.")
    return(NA)
  } else if (stat_code == 400) {
    cat("Bad request.")
    return(NA)
  } else if (stat_code == 200) {
    cat("Good request.")
  }
}

