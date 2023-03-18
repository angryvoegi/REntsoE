## Function nimmt die Anzahl Spalten welche nicht Date oder PSR sind
## mit dieser Anzahl wird die Anzahl zu wiederholender units angegeben
get_unit <- function(df, ts_dat){
  n_dataPoints <- length(colnames(df)) - sum(grepl("Date|PSR", colnames(final)))
  lapply(ts_dat, function(x){
    n_out <- lapply(x$Period, function(y){
      y$position
    }) %>%
      unlist() %>%
      as.numeric() %>%
      max()
    measur_unit <- x$quantity_Measure_Unit.name
    rep(measur_unit, n_out/n_dataPoints)
  }) %>%
    unlist()
}
# get_unit(final, onlyTS)
# final$unit <- get_unit(final, onlyTS)
#
#
# final %>%
#   dplyr::group_by(Date) %>%
#   dplyr::mutate(id = row_number()) %>%
#   tidyr::pivot_wider(names_from = id, values_from = Val) %>%
#   mutate_if(is.character, as.numeric)
