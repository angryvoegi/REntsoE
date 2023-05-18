test_that("API returns response",{
  url <- "https://web-api.tp.entsoe.eu/api?documentType=A65&processType=A16&outBiddingZone_Domain=10YCZ-CEPS-----N&periodStart=201512302300&periodEnd=201512312300"
  resp <- httr::GET(paste(url, "&securityToken=", Sys.getenv("ENTSOE_KEY"), sep = ""))
  expect_output(api_error(resp), "Good request.")
})

test_that("API unavailable",{
  url <- "https://web-api.tp.entsoe.eu/api?documentType=A65&processType=A16&periodStart=201512302300&periodEnd=201512312300"
  resp <- httr::GET(paste(url, "&securityToken=", Sys.getenv("ENTSOE_KEY"), sep = ""))
  expect_output(api_error(resp), "Bad request.")
})
