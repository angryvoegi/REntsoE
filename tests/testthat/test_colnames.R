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

test_that("Detect generation and consumption correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A65A16.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  datas <- rlst
  onlyTS <- only_ts(datas)
  gC <- generation_consumption(onlyTS)
  expect_equal(gC, "Consumption")
})

test_that("Colnames A71A33 are set correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A71A33.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  onlyTS <- only_ts(rlst)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  fin <- set_colnames(df = final, rawdat = rlst)
  expect_equal(colnames(fin)[1], "Date")
  expect_equal(colnames(fin)[2], "Installed Capacity at the beginning of the year")
})

test_that("Colnames wind and solar are set correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A68A33.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  onlyTS <- only_ts(rlst)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  fin <- set_colnames(df = final, rawdat = rlst)
  expect_equal(colnames(fin)[1], "Date")
  expect_equal(colnames(fin)[2], "Value")
})

test_that("Colnames year ahead forecast margin are set correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A70A33.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  onlyTS <- only_ts(rlst)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  fin <- set_colnames(df = final, rawdat = rlst)
  expect_equal(colnames(fin)[1], "Date")
  expect_equal(colnames(fin)[2], "Forecast margin")
})

test_that("Colnames week ahead total load are set correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A65A31.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  onlyTS <- only_ts(rlst)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  final <- split_columns(final, rlst)
  fin <- set_colnames(df = final, rawdat = rlst)
  expect_equal(colnames(fin)[1], "Date")
  expect_equal(colnames(fin)[2], "Min Total Load")
  expect_equal(colnames(fin)[3], "Max Total Load")
})

test_that("Colnames actual total load are set correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A65A16.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  onlyTS <- only_ts(rlst)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  fin <- set_colnames(df = final, rawdat = rlst)
  expect_equal(colnames(fin)[1], "Date")
  expect_equal(colnames(fin)[2], "Actual Total Load")
})

test_that("Colnames day ahead forecast margin are set correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A65A01.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  onlyTS <- only_ts(rlst)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  fin <- set_colnames(df = final, rawdat = rlst)
  expect_equal(colnames(fin)[1], "Date")
  expect_equal(colnames(fin)[2], "Day-ahead Total Load Forecast")
})

test_that("Colnames day ahead forecast margin are set correctly", {
  mockFile <- "web-api.tp.entsoe.eu/A71A01.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  onlyTS <- only_ts(rlst)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  final <- split_columns(final, rlst)
  fin <- set_colnames(df = final, rawdat = rlst)
  expect_equal(colnames(fin)[1], "Date")
  expect_equal(colnames(fin)[2], "Scheduled Generation")
  expect_equal(colnames(fin)[3], "Scheduled Consumption")
})


test_that("Test colnames with PSR-type", {
  mockFile <- "web-api.tp.entsoe.eu/A69A01.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  onlyTS <- only_ts(rlst)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  final <- cbind(final,
                 PSRType = type_from_list(
                   rlst = rlst,
                   psrtype = codeList$AssetTypeList
                 )
  )
  final <- reshape(final,
                   direction = "wide", idvar = "Date",
                   timevar = "PSRType", varying = unique(final$PSRType)
  )
  colnames(final) <- dynamic_colnames(
    df = final, rawdat = rlst,
    onlyTS_dat = onlyTS,
    codeList = codeList, PSR = T
  )
  expect_equal(colnames(final)[1], "Date")
  expect_equal(colnames(final)[2], "Day ahead Solar")
  expect_equal(nrow(final), 8784)
})

