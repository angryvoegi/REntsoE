library(testthat)
test_that("API key must be character",{
  key <- 123
  Sys.setenv("ENTSOE_KEY" = "")
  expect_error(REntsoE::set_apikey(key))
})

test_that("API key not set", {
  Sys.setenv("ENTSOE_KEY" = "")
  expect_error(build_url())
})
