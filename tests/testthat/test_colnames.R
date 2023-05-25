library(testthat)
library(vcr)
test_that("Display name is converted correctly", {
  vcr::use_cassette("pull_dataA61", {
    url <- build_url(
      documentType = "A61", contract_MarketAgreement.Type = "A01",
      in_Domain = "10YCZ-CEPS-----N", out_Domain = "10YSK-SEPS-----K",
      periodStart = "201912312300", periodEnd = "202012312300")
    resp <- httr::GET(url)
  })
  rlst <- convert_xml(resp)
  datas <- rlst
  test <- get_displayName(rlst = datas, eic = REntsoE::areaY)
  expect_equal(test[[1]], "CZ")
  expect_equal(test[[2]], "SK")
  expect_length(test, 2)
})


test_that("Colnames are set correctly", {
  vcr::use_cassette("pull_dataA611", {
    url <- build_url(
      documentType = "A61", contract_MarketAgreement.Type = "A01",
      in_Domain = "10YCZ-CEPS-----N", out_Domain = "10YSK-SEPS-----K",
      periodStart = "201912312300", periodEnd = "202012312300")
    resp <- httr::GET(url)
  })
  rlst <- convert_xml(resp)
  datas <- rlst
  onlyTS <- only_ts(datas)
  dates <- date_from_lst(onlyTS)
  values <- values_from_lst(onlyTS)
  final <- data.frame(Date = do.call("c", dates), Val = unlist(values))
  final <- set_colnames(df = final, rawdat = datas)
  expect_equal(colnames(final), c("Date", "BZN|SK>BZN|CZ"))
})


test_that("Dynamic colnames are set correctly", {
  vcr::use_cassette("pull_dataA65", {
    url <- build_url(
      documentType = "A65", processType = "A16",
      outBiddingZone_Domain = "10YCZ-CEPS-----N",
      periodStart = "201912312300", periodEnd = "202012312300")
    resp <- httr::GET(url)
  })
  rlst <- convert_xml(resp)
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
  vcr::use_cassette("pull_dataA651", {
    url <- build_url(
      documentType = "A65", processType = "A16",
      outBiddingZone_Domain = "10YCZ-CEPS-----N",
      periodStart = "201912312300", periodEnd = "202012312300")
    resp <- httr::GET(url)
  })
  rlst <- convert_xml(resp)
  datas <- rlst
  onlyTS <- only_ts(datas)
  bT <- business_types(onlyTS)
  expect_equal(bT, "A04")
})


test_that("Detect generation and consumption correctly", {
  vcr::use_cassette("pull_dataA652", {
    url <- build_url(
      documentType = "A65", processType = "A16",
      outBiddingZone_Domain = "10YCZ-CEPS-----N",
      periodStart = "201912312300", periodEnd = "202012312300")
    resp <- httr::GET(url)
  })
  rlst <- convert_xml(resp)
  datas <- rlst
  onlyTS <- only_ts(datas)
  gC <- generation_consumption(onlyTS)
  expect_equal(gC, "Consumption")
})
