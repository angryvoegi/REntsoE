library(testthat)
test_that("PSR type is correctly mapped", {
  vcr::use_cassette("pull_dataA69", {
    url <- build_url(
      documentType = "A69", processType = "A18",
      in_Domain = "10YFI-1--------U",
      periodStart = "201912312300", periodEnd = "202012312300")
    resp <- httr::GET(url)
    rlst <- convert_xml(resp)
  })
  datas <- rlst
  psrType <- type_from_list(
    rlst = datas,
    psrtype = codeList$AssetTypeList
    )
  expect_equal(unique(psrType)[1], "Solar")
  expect_equal(unique(psrType)[2], "Wind Onshore")
  expect_length(psrType, 17616)
})


test_that("Parameters from response are correct", {
  vcr::use_cassette("pull_dataA69", {
    url <- build_url(
      documentType = "A69", processType = "A18",
      in_Domain = "10YFI-1--------U",
      periodStart = "201912312300", periodEnd = "202012312300")
    resp <- httr::GET(url)
    rlst <- convert_xml(resp)
  })
  datas <- rlst
  prms <- get_params(datas)
  expect_length(prms, 6)
  expect_equal(prms[[1]], "A69")
  expect_equal(prms[[2]], "A18")
  expect_equal(prms[[3]], "A94")
  expect_equal(prms[[4]], "A08")
  expect_equal(prms[[5]], "MAW")
  expect_equal(prms[[6]], "A01")
})
