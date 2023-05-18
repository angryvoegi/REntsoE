test_that("PSR type is correctly mapped", {
  url <- build_url(
    documentType = "A69", processType = "A18",
     in_Domain = "10YFI-1--------U",
     periodStart = "201912312300", periodEnd = "202012312300"
  )
  resp <- httr::GET(url)
  test <- convert_xml(resp)
  psrType <- type_from_list(
    rlst = test,
    psrtype = codeList$AssetTypeList
  )
  expect_equal(unique(psrType)[1], "Solar")
  expect_equal(unique(psrType)[2], "Wind Onshore")
  expect_length(psrType, 17616)
})

test_that("Parameters from response are correct", {
  url <- build_url(
    documentType = "A69", processType = "A18",
    in_Domain = "10YFI-1--------U",
    periodStart = "201912312300", periodEnd = "202012312300"
  )
  resp <- httr::GET(url)
  test <- convert_xml(resp)
  prms <- get_params(test)
  expect_equal(prms[[1]], "A69")
  expect_equal(prms[[2]], "A18")
  expect_equal(prms[[3]], "A94")
  expect_equal(prms[[4]], "A08")
  expect_equal(prms[[5]], "MAW")
  expect_equal(prms[[6]], "A01")
})

