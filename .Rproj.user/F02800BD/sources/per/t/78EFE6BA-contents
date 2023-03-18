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
#' @usage
#' Actual Total Load [6.1.A]:
#' pull_data(
#'  documentType = "A65", processType = "A16",
#'  outBiddingZone_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Day-Ahead Total Load Forecast [6.1.B]:
#' pull_data(
#'  documentType = "A65", processType = "A01",
#'  outBiddingZone_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Week-Ahead Total Load Forecast [6.1.C]:
#' pull_data(
#'  documentType = "A65", processType = "A31",
#'  outBiddingZone_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Month-Ahead Total Load Forecast [6.1.D]:
#' pull_data(
#'  documentType = "A65", processType = "A32",
#'  outBiddingZone_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Year-Ahead Total Load Forecast [6.1.E]:
#' pull_data(
#'  documentType = "A65", processType = "A33",
#'  outBiddingZone_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Year-Ahead Forecast Margin [8.1]:
#' pull_data(
#'  documentType = "A70", processType = "A33",
#'  outBiddingZone_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Forecasted Capacity [11.1.A]:
#' pull_data(
#'  documentType = "A61", contract_MarketAgreement.Type = "A01",
#'  in_Domain = "10YCZ-CEPS-----N", out_Domain = "10YSK-SEPS-----K",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Installed Generation Capacity Aggregated [14.1.A]:
#' pull_data(
#'  documentType = "A68", processType = "A01",
#'  in_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Installed Generation Capacity per Unit [14.1.B]:
#' pull_data(
#'  documentType = "A71", processType = "A33",
#'  in_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Day-ahead Aggregated Generation [14.1.C]:
#' pull_data(
#'  documentType = "A71", processType = "A01",
#'  in_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Day-ahead Generation Forecasts for Wind and Solar [14.1.D]:
#' pull_data(
#'  documentType = "A68", processType = "A33",
#'  in_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Current Generation Forecasts for Wind and Solar [14.1.D]:
#' pull_data(
#'  documentType = "A69", processType = "A18",
#'  in_Domain = "10YFI-1--------U",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Intraday Generation Forecasts for Wind and Solar [14.1.D]:
#' pull_data(
#'  documentType = "A69", processType = "A40",
#'  in_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Actual Generation Output per Generation Unit [16.1.A]:
#' pull_data(
#'  documentType = "A73", processType = "A16",
#'  in_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300",
#'  registered_resource = "27W-GU-EDETG2--X" (optional!)
#' )
#'
#' Aggregated Filling Rate of Water Reservoirs and Hydro Storage Plants [16.1.D]:
#' pull_data(
#'  documentType = "A72", processType = "A16",
#'  in_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
#'
#' Aggregated Generation per Type [16.1.B&C]:
#' pull_data(
#'  documentType = "A75", processType = "A16",
#'  in_Domain = "10YCZ-CEPS-----N",
#'  periodStart = "201912312300", periodEnd = "202012312300"
#' )
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
pull_data <- function(documentType, processType, contract_MarketAgreement.Type,
                      outBiddingZone_Domain, auction.Type, psrType, Area_Domain,
                      in_Domain, out_Domain, registeredResource, businessType,
                      periodStart, periodEnd) {
  if (identical(Sys.getenv("ENTSOE_KEY"), "")) {
    print("Forgot to set the API key? Call it with `set_apikey`!")
    stop()
  }
  fArgs <- as.list(environment())
  print("Building URL...")
  url <- do.call(build_url, fArgs)
  print("Built URL, sendig request...")
  resp <- httr::GET(url)
  print("Got data, converting it...")
  convResp <- convert_xml(resp)
  onlyTS <- only_ts(convResp)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
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
  return(final)
  print("Finished")
}
