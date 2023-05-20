library(testthat)
test_that("Correct location from mRID", {
  vcr::use_cassette("pull_dataA71", {
    url <- build_url(
      documentType = "A71", processType = "A33",
      in_Domain = "10YCZ-CEPS-----N",
      periodStart = "201912312300", periodEnd = "202012312300")
    resp <- httr::GET(url)
    rlst <- convert_xml(resp)
  })
  datas <- rlst
  locs <- get_Locations(rawdat = datas, eicLoc = REntsoE::eicLoc)
  expect_equal(locs[1], "EPLE")
  expect_length(locs, 29)
})


test_that("Location gets appended to the data", {
  vcr::use_cassette("pull_dataA71", {
    url <- build_url(
      documentType = "A71", processType = "A33",
      in_Domain = "10YCZ-CEPS-----N",
      periodStart = "201912312300", periodEnd = "202012312300")
    resp <- httr::GET(url)
    rlst <- convert_xml(resp)
  })
  datas <- rlst
  onlyTS <- only_ts(datas)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  colnames(final) <- dynamic_colnames(
    df = final, rawdat = datas,
    onlyTS_dat = onlyTS,
    codeList = codeList
  )
  final <- append_location(final, rawdat = datas)
  expect_equal(ncol(final), 3)
  expect_equal(final[1, 3], "EPLE")
})
