test_that("API key already set",{
  set_apikey("abc")
  expect_message(set_apikey("bcd"), "Already set an API Key for the ENTSO-E platform...")
})

test_that("API key must be character",{
  key <- 123
  expect_error(set_apikey(key))
})

test_that("API key not set", {
  expect_error(build_url())
})
