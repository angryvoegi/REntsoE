library(testthat)
library(vcr)
test_that("URL is built correctly", {
  documentType = "A65"
  processType = "A16"
  outBiddingZone_Domain = "10YCZ-CEPS-----N"
  periodStart = "201512312300"
  periodEnd = "201612312300"
  url <- build_url(documentType = documentType,
                   processType = processType,
                   outBiddingZone_Domain = outBiddingZone_Domain,
                   periodStart = periodStart,
                   periodEnd = periodEnd, key = FALSE)
  expect_equal(url,
               "documentType=A65&outBiddingZone_Domain=10YCZ-CEPS-----N&periodEnd=201612312300&periodStart=201512312300&processType=A16")
})

test_that("URL security token missing", {
  Sys.setenv("ENTSOE_KEY" = "")
  documentType = "A65"
  processType = "A16"
  outBiddingZone_Domain = "10YCZ-CEPS-----N"
  periodStart = "201512312300"
  periodEnd = "201612312300"
  expect_error(build_url(documentType = documentType,
                         processType = processType,
                         outBiddingZone_Domain = outBiddingZone_Domain,
                         periodStart = periodStart,
                         periodEnd = periodEnd))
})

