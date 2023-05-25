library(testthat)
test_that("PSR type is correctly mapped", {
  mockFile <- "web-api.tp.entsoe.eu/A69A18.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  psrType <- type_from_list(
    rlst = rlst,
    psrtype = codeList$AssetTypeList
    )
  expect_equal(unique(psrType)[1], "Solar")
  expect_equal(unique(psrType)[2], "Wind Onshore")
  expect_length(psrType, 17616)
})


test_that("Parameters from response are correct", {
  mockFile <- "web-api.tp.entsoe.eu/A69A18.R"
  mock <- source(mockFile)
  rlst <- convert_xml(mock$value)
  prms <- get_params(rlst)
  expect_length(prms, 6)
  expect_equal(prms[[1]], "A69")
  expect_equal(prms[[2]], "A18")
  expect_equal(prms[[3]], "A94")
  expect_equal(prms[[4]], "A08")
  expect_equal(prms[[5]], "MAW")
  expect_equal(prms[[6]], "A01")
})
