#' @title
#' PSR Type from Code
#'
#' @description
#' Extract the PSR Code and convert code to name
#'
#' @details
#' Function extracts the PSR Type (and Text) and generates a list
#' Is used to append to data and know what type it is (e.g. [14.1.D])
#'
#'
#' @param rlst rlst raw list, converted xml response to list
#' @param psrtype PSR Type from codeList$AssetTypeList (excel data)
#'
#' @return Returns named vector with the PSR types in order of them being
#' in the data
#' @export
type_from_list <- function(rlst, psrtype) {
  tmp <- rlst[names(rlst) == "TimeSeries"]
  vals_lst <- lapply(tmp, function(x) {
    max_point <- x$Period[names(x$Period) == "Point"] %>%
      unlist() %>%
      .[grepl("Point.position", names(.))] %>%
      as.numeric() %>%
      max()
    PSRtype <- psrtype[which(psrtype$CODE %in% unlist(x$MktPSRType)), 2]
    return(rep(PSRtype, max_point))
  })
  fin <- unlist(vals_lst) %>%
    gsub('\"', "", .)
  return(fin)
}


#' @title
#' Get parameters
#'
#' @description
#' Pull the different parameters from the original object
#'
#' @details
#' Function extracts the Process Type, Business type,
#' objkect aggregation, Measurment unit and curve type
#'
#' @param rlst rlst raw list, converted xml response to list
#'
#' @return named list with the data
#' @export
get_params <- function(rlst) {
  type <- rlst$type %>%
    unlist()
  processType <- rlst$process.processType %>%
    unlist()
  businessType <- rlst$TimeSeries$businessType %>%
    unlist()
  objectAggregation <- rlst$TimeSeries$objectAggregation %>%
    unlist()
  unit <- rlst$TimeSeries$quantity_Measure_Unit.name %>%
    unlist()
  curveType <- rlst$TimeSeries$curveType %>%
    unlist()
  fin <- list(
    type, processType, businessType, objectAggregation,
    unit, curveType
  )
  names(fin) <- c(
    "Type", "ProcessType", "BusinessType",
    "ObjectAggregation", "MeasurmentUnit",
    "CurveType"
  )
  return(fin)
}
