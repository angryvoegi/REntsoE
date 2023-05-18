test_that("Response is only ts", {
  url <- build_url(
    documentType = "A65", processType = "A16",
    outBiddingZone_Domain = "10YCZ-CEPS-----N",
    periodStart = "201912312300", periodEnd = "202012312300"
    )
  resp <- httr::GET(url)
  test <- only_ts(convert_xml(resp))
  expect_true(names(test) == "TimeSeries")
})

test_that("Date is generated correctly", {
  dates <- points_to_time(start = "2019-12-31T23:00Z",
                          n_points = 2,
                          period = "P1D")
  expect_length(dates, 2)
  expect_equal(as.POSIXct(dates[1]), as.POSIXct("2020-01-01 23:00:00 UTC", tz = "UTC"))
})

test_that("Dates generated from response", {
  url <- build_url(
    documentType = "A65", processType = "A16",
    outBiddingZone_Domain = "10YCZ-CEPS-----N",
    periodStart = "201912312300", periodEnd = "202012312300"
  )
  resp <- httr::GET(url)
  test <- only_ts(convert_xml(resp))
  dates <- date_from_lst(test)
  expect_length(dates$TimeSeries, 8784)
  expect_equal(as.POSIXct(dates$TimeSeries[1]), as.POSIXct("2020-01-01 00:00:00 UTC", tz = "UTC"))
})