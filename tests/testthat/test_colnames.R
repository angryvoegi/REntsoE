library(testthat)
library(httptest)
test_that("Display name is converted correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A61A01.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  datas <- rlst
  test <- get_displayName(rlst = datas, eic = REntsoE::areaY)
  expect_equal(test[[1]], "CZ")
  expect_equal(test[[2]], "SK")
  expect_length(test, 2)
})


test_that("Colnames are set correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A61A01.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  datas <- rlst
  onlyTS <- only_ts(datas)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  final <- set_colnames(df = final, rawdat = datas)
  expect_equal(colnames(final), c("Date", "BZN|SK>BZN|CZ"))
})


test_that("Dynamic colnames are set correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A65A16.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  datas <- rlst
  onlyTS <- only_ts(datas)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  clNames <- dynamic_colnames(
    df = final, rawdat = datas,
    onlyTS_dat = onlyTS,
    codeList = codeList
  )
  expect_length(clNames, 2)
  expect_equal(clNames[1], "Date")
  expect_equal(clNames[2], "Realised Consumption")
})


test_that("Business Type is correct", {
  mockFile <- "web-api.tp.entsoe.eu/A65A16.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  datas <- rlst
  onlyTS <- only_ts(datas)
  bT <- business_types(onlyTS)
  expect_equal(bT, "A04")
})


test_that("Detect generation and consumption correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A65A16.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  datas <- rlst
  onlyTS <- only_ts(datas)
  gC <- generation_consumption(onlyTS)
  expect_equal(gC, "Consumption")
})
