#' @title
#' Split columns based on parameters
#'
#' @description
#' Function converts long to wide dataframe based on parameters.
#'
#' @details
#' With the `pivot_wider` function the data is put into wide format
#' based on the parameters. Function is mainly used if the requested
#' data has two columns (i.e. scheduled generation and scheduled consumption)
#'
#' @param df Half-finished dataframe
#' @param rawdat Raw data, as list
#'
#' @return Split dataframe
split_columns <- function(df, rawdat) {
  params <- get_params(rawdat)
  if (!is.null(params$ProcessType) & !is.null(params$ObjectAggregation)) {
    if (params$Type %in% c("A65", "A71", "A69") &
      params$ProcessType %in% c("A33", "A01", "A32", "A31") &
      params$BusinessType %in% c("A60", "A01", "A94") &
      params$ObjectAggregation %in% c("A01", "A08")) {
      df <- df %>%
        dplyr::group_by(Date) %>%
        dplyr::mutate(id = row_number(),
                      Val = as.numeric(Val)) %>%
        tidyr::pivot_wider(names_from = id, values_from = Val) %>%
        mutate_if(is.character, as.numeric)
    } else {
      df <- df %>%
        dplyr::mutate_if(is.character, as.numeric)
    }
  } else {
    df <- df %>%
      dplyr::mutate_if(is.character, as.numeric)
  }
  return(df)
}
