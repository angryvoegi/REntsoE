#' @title
#' Pull data from the API
#'
#' @description
#' Function to pull the data from the Entso-E API.
#'
#' @details
#' Function uses each element of this package. It build the url, pull the data and
#' converts it in the appropriate manner. The funciton is complex because different
#' types of datapoints need different treatment.
#'
#'
#'
#' @import dplyr httr tidyr xml2
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
#'
#' @return Dataframe
#'
#' @export
#' @importFrom stats reshape
pull_data <- function(documentType, processType, contract_MarketAgreement.Type,
                      outBiddingZone_Domain, auction.Type, psrType, Area_Domain,
                      in_Domain, out_Domain, registeredResource, businessType,
                      periodStart, periodEnd) {
  if (identical(Sys.getenv("ENTSOE_KEY"), "")) {
    message("Forgot to set the API key? Call it with `set_apikey`!")
    stop()
  }
  fArgs <- as.list(environment())
  message("Building URL...")
  url <- do.call(build_url, fArgs)
  message("Built URL, sendig request...")
  resp <- httr::GET(url)
  message("Got data, converting it...")
  convResp <- convert_xml(resp)
  onlyTS <- only_ts(convResp)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  if(typeof(fArgs$processType) == "symbol"){ # if pulled data does not contain processType
    fArgs$processType <- "NotIn"
  }
  if (fArgs$documentType %in% c("A65", "A72") &
      fArgs$processType %in% c("A16")) {
    colnames(final) <- dynamic_colnames(
      df = final, rawdat = convResp,
      onlyTS_dat = onlyTS,
      codeList = codeList
    )
  } else if (fArgs$documentType %in% c("A65", "A70", "A71") &
             fArgs$processType %in% c("A01", "A31", "A32", "A33")) {
    final <- split_columns(df = final, rawdat = convResp)
    colnames(final) <- dynamic_colnames(
      df = final, rawdat = convResp,
      onlyTS_dat = onlyTS,
      codeList = codeList
    )
  } else if (fArgs$documentType == "A61" &
             fArgs$processType == "A01") {
    final <- split_columns(df = final, rawdat = convResp)
    final <- set_colnames(df = final, rawdat = convResp)
  } else if (fArgs$contract_MarketAgreement.Type == "A01" &
             fArgs$documentType == "A61") {
    final <- split_columns(df = final, rawdat = convResp)
    final <- set_colnames(df = final, rawdat = convResp)

  } else if (fArgs$documentType %in% c("A73") &
             fArgs$processType %in% c("A01", "A16", "A18", "A40")) {
    final <- cbind(final,
      PSRType = type_from_list(
        rlst = convResp,
        psrtype = codeList$AssetTypeList
      )
    )
    final <- reshape(final,
      direction = "wide", idvar = "Date",
      timevar = "PSRType", varying = unique(final$PSRType)
    )
    colnames(final) <- dynamic_colnames(
      df = final, rawdat = convResp,
      onlyTS_dat = onlyTS,
      codeList = codeList
    )
  } else if (fArgs$documentType %in% c("A69", "A75") &
             fArgs$processType %in% c("A01", "A18", "A16")) {
    final <- cbind(final,
      PSRType = type_from_list(
        rlst = convResp,
        psrtype = codeList$AssetTypeList
      )
    )
    final <- reshape(final,
      direction = "wide", idvar = "Date",
      timevar = "PSRType", varying = unique(final$PSRType)
    )
    colnames(final) <- dynamic_colnames(
      df = final, rawdat = convResp,
      onlyTS_dat = onlyTS,
      codeList = codeList, PSR = T
    )
  } else if (fArgs$documentType == "A68" &
             fArgs$processType == "A33") {
    colnames(final) <- dynamic_colnames(
      df = final, rawdat = convResp,
      onlyTS_dat = onlyTS,
      codeList = codeList
    )
    final <- cbind(final,
      PSRType = type_from_list(
        rlst = convResp,
        psrtype = codeList$AssetTypeList
      )
    )
  } else {
    final <- split_columns(df = final, rawdat = convResp)
    colnames(final) <- dynamic_colnames(
      df = final, rawdat = convResp,
      onlyTS_dat = onlyTS,
      codeList = codeList
    )
    final <- append_location(final, rawdat = convResp)
  }
  final <- final %>%
    mutate_if(is.character, as.numeric)
  rownames(final) <- NULL
  return(final)
  message("Finished")
}
