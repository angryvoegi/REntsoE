test_that("URL is built correctly", {
  documentType = "A65"
  processType = "A16"
  outBiddingZone_Domain = "10YCZ-CEPS-----N"
  periodStart = "201512312300"
  periodEnd = "201612312300"
  url <- REntsoE::build_url(documentType = documentType,
                            processType = processType,
                            outBiddingZone_Domain = outBiddingZone_Domain,
                            periodStart = periodStart,
                            periodEnd = periodEnd)
  url <- gsub("\\&securityToken.*","",url)
  expect_equal(url,
               "https://web-api.tp.entsoe.eu/api?documentType=A65&outBiddingZone_Domain=10YCZ-CEPS-----N&periodEnd=201612312300&periodStart=201512312300&processType=A16")
})

test_that("URL security token missing", {
  Sys.setenv("ENTSOE_KEY" = "")
  documentType = "A65"
  processType = "A16"
  outBiddingZone_Domain = "10YCZ-CEPS-----N"
  periodStart = "201512312300"
  periodEnd = "201612312300"
  url <- REntsoE::build_url(documentType = documentType,
                            processType = processType,
                            outBiddingZone_Domain = outBiddingZone_Domain,
                            periodStart = periodStart,
                            periodEnd = periodEnd)
  url <- gsub(".*&securityToken=","",url)
  expect_true(url == "")
})

