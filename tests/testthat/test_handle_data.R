test_that("Check if data frame is pivoted correctly", {
  url <- build_url(
    documentType = "A65", processType = "A01",
    outBiddingZone_Domain = "10YCZ-CEPS-----N",
    periodStart = "201912312300", periodEnd = "202012312300"
  )
  resp <- httr::GET(url)
  convResp <- convert_xml(resp)
  onlyTS <- only_ts(convResp)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  test <- split_columns(df = final, rawdat = convResp)
  expect_equal(ncol(test), 2)
  expect_equal(colnames(test), c("Date", "Val"))
})

