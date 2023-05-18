test_that("Correct location from mRID", {
  url <- build_url(
     documentType = "A71", processType = "A33",
     in_Domain = "10YCZ-CEPS-----N",
     periodStart = "201912312300", periodEnd = "202012312300"
  )
  resp <- httr::GET(url)
  test <- convert_xml(resp)
  locs <- get_Locations(rawdat = test, eicLoc = REntsoE::eicLoc)
  expect_equal(locs[1], "EPLE")
  expect_length(locs, 29)
})

test_that("Location gets appended to the data", {
  url <- build_url(
    documentType = "A71", processType = "A33",
    in_Domain = "10YCZ-CEPS-----N",
    periodStart = "201912312300", periodEnd = "202012312300"
  )
  resp <- httr::GET(url)
  convResp <- convert_xml(resp)
  onlyTS <- only_ts(convResp)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  colnames(final) <- dynamic_colnames(
    df = final, rawdat = convResp,
    onlyTS_dat = onlyTS,
    codeList = codeList
  )
  final <- append_location(final, rawdat = convResp)
  expect_equal(ncol(final), 3)
  expect_equal(final[1, 3], "EPLE")
})
