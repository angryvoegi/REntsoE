test_that("Display name is converted correctly", {
  Sys.setenv("ENTSOE_KEY" = "")
  expect_error(pull_data())
})

