library(testthat)
test_that("Conversion to yearly is correct", {
  load("web-api.tp.entsoe.eu/pullDataA65A16.rda")
  expect_equal(nrow(to_yearly(dat)), 1)
  expect_equal(round(as.numeric(to_yearly(dat, type = "sum")[,2]), 0), 64290077)
  expect_equal(round(as.numeric(to_yearly(dat, type = "mean")[,2]), 0), 7319)
  expect_equal(round(as.numeric(to_yearly(dat, type = "median")[,2]), 0), 7306)
})

test_that("Conversion to monthly is correct", {
  load("web-api.tp.entsoe.eu/pullDataA65A16.rda")
  expect_equal(nrow(to_monthly(dat)), 12)
  expect_equal(unname(round(unlist(as.vector(to_monthly(dat, type = "sum")[,2,F])), 0)),
               c(6391562, 5861256, 5882029, 4725507, 4721988, 4707301,
                 4758082, 4855509, 5010548, 5556211, 5848641, 5971443))
  expect_equal(unname(round(unlist(as.vector(to_monthly(dat, type = "mean")[,2,F])), 2)),
               c(8590.81, 8421.34, 7905.95, 6563.20, 6346.76, 6537.92,
                 6395.27, 6526.22, 6959.09, 7468.03, 8123.11, 8026.13))
  expect_equal(unname(round(unlist(as.vector(to_monthly(dat, type = "median")[,2,F])), 1)),
               c(8559.0, 8272.0, 7872.0, 6557.5, 6167.5, 6554.5, 6372.5,
                 6451.5, 6952.0, 7428.5, 8118.5, 7856.5))
})

test_that("Conversion to weekly is correct", {
  load("web-api.tp.entsoe.eu/pullDataA65A16.rda")
  expect_equal(nrow(to_weekly(dat)), 53)
  expect_equal(unname(round(unlist(as.vector(to_weekly(dat, type = "sum")[1, 2,F])), 0)),
               878471)
  expect_equal(unname(round(unlist(as.vector(to_weekly(dat, type = "mean")[1, 2,F])), 2)),
               7320.59)
  expect_equal(unname(round(unlist(as.vector(to_weekly(dat, type = "median")[1, 2,F])), 1)),
               7272)
})
#
test_that("Conversion to daily is correct", {
  load("web-api.tp.entsoe.eu/pullDataA65A16.rda")
  expect_equal(nrow(to_daily(dat)), 366)
  expect_equal(unname(round(unlist(as.vector(to_daily(dat, type = "sum")[1, 2,F])), 0)),
               148136)
  expect_equal(unname(round(unlist(as.vector(to_daily(dat, type = "mean")[1, 2,F])), 2)),
               6172.33)
  expect_equal(unname(round(unlist(as.vector(to_daily(dat, type = "median")[1, 2,F])), 1)),
               6310)
})
