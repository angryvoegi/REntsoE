#' @title
#' Build URL
#'
#' @description
#' Dynamically build the right URL for your request
#'
#' @details
#' This function builds the url to get the data.
#' Different types of data have different arguments in the function.
#' With that in mind, arguments can be missing based on the
#' desired data.
#'
#' @param documentType Corresponding to the data point
#' @param processType Which process should be pulled
#' @param contract_MarketAgreement.Type Type of Contract
#' @param outBiddingZone_Domain Country from which the data should be pulled
#' @param auction.Type Type of auction, buy or sell
#' @param psrType Tpy of generation, e.g. wind, solar, nuclear etc.
#' @param Area_Domain Domain Area
#' @param in_Domain From where
#' @param out_Domain To where
#' @param registeredResource Which generation unit
#' @param businessType Identification of the nature of timeseries
#' @param periodStart Starting point
#' @param periodEnd End point
#' @param key Should the API-Key be included (mainly for testing purpose)?
#'
#' @return
#' String of url to make request
#' @importFrom stats na.omit
build_url <- function(documentType, processType, contract_MarketAgreement.Type,
                      outBiddingZone_Domain, auction.Type, psrType, Area_Domain,
                      in_Domain, out_Domain, registeredResource, businessType,
                      periodStart, periodEnd, key = TRUE) {
  base_url <- "https://web-api.tp.entsoe.eu/api?"
  base_df <- data.frame(matrix(nrow = 13, ncol = 1))
  rownames(base_df) <- c(
    "documentType", "processType", "contract_MarketAgreement.Type",
    "outBiddingZone_Domain", "auction.Type", "psrType", "Area_Domain",
    "in_Domain", "out_Domain", "registeredResource", "businessType",
    "periodStart", "periodEnd"
  )
  fArgs <- within(as.list(environment()), rm(base_df, base_url))
  boolRem <- lapply(fArgs, function(x) class(x) == "name")
  fArgsClean <- data.frame(fArgs[!unname(unlist(boolRem))])
  fin <- merge(base_df, t(fArgsClean), by = "row.names", all.x = TRUE)[, -2] %>%
    na.omit()
  fin <- paste(apply(fin, 1, paste, collapse = "="), collapse = "&")
  if(key) {
    token <- Sys.getenv("ENTSOE_KEY")
    fin <- paste(base_url, fin, "&securityToken=", token, sep = "")
    if(is.na(token) || token == ""){
      message("No API token found. Set your token with the function `set_apikey`.")
      stop()
    }
  }
  return(fin)
}
