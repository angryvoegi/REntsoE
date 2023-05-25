library(testthat)
test_that("Correct location from mRID", {
  mockFile <- "web-api.tp.entsoe.eu/A71A33.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  locs <- get_Locations(rawdat = rlst, eicLoc = REntsoE::eicLoc)
  expect_equal(locs[1], "EPLE")
  expect_length(locs, 29)
})


test_that("Location gets appended to the data", {
  mockFile <- "web-api.tp.entsoe.eu/A71A33.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  onlyTS <- only_ts(rlst)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  colnames(final) <- dynamic_colnames(
    df = final, rawdat = rlst,
    onlyTS_dat = onlyTS,
    codeList = codeList
  )
  final <- append_location(final, rawdat = rlst)
  expect_equal(ncol(final), 3)
  expect_equal(final[1, 3], "EPLE")
})
