test_that("Check if data frame is pivoted correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A65A01.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  onlyTS <- only_ts(rlst)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  test <- split_columns(df = final, rawdat = rlst)
  expect_equal(ncol(test), 2)
  expect_equal(colnames(test), c("Date", "Val"))
})
