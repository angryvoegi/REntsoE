library(testthat)
library(vcr)
test_that("Check if data frame is pivoted correctly", {
  vcr::use_cassette("pull_dataA6501", {
    url <- build_url(
      documentType = "A65", processType = "A01",
      outBiddingZone_Domain = "10YCZ-CEPS-----N",
      periodStart = "201912312300", periodEnd = "202012312300")
    resp <- httr::GET(url)
    rlst <- convert_xml(resp)
  })
  datas <- rlst
  onlyTS <- only_ts(datas)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  test <- split_columns(df = final, rawdat = datas)
  expect_equal(ncol(test), 2)
  expect_equal(colnames(test), c("Date", "Val"))
})
