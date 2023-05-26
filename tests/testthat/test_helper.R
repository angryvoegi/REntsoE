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

test_that("503 error correctly catched", {
  mockFile <- "web-api.tp.entsoe.eu/503.R"
  mock <- source(mockFile)
  expect_output(api_error(mock$value))
  expect_equal(is.na(api_error(mock$value)), TRUE)
})

test_that("404 error correctly catched", {
  mockFile <- "web-api.tp.entsoe.eu/404.R"
  mock <- source(mockFile)
  expect_output(api_error(mock$value))
  expect_equal(is.na(api_error(mock$value)), TRUE)
})

test_that("400 error correctly catched", {
  mockFile <- "web-api.tp.entsoe.eu/400.R"
  mock <- source(mockFile)
  expect_output(api_error(mock$value))
  expect_equal(is.na(api_error(mock$value)), TRUE)
})

test_that("200 good request", {
  mockFile <- "web-api.tp.entsoe.eu/200.R"
  mock <- source(mockFile)
  expect_output(api_error(mock$value))
})
