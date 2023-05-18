test_that("Conversion to yearly is correct", {
  if(Sys.getenv("ENTSOE_KEY") == ""){
    stop()
  }
  dat <- pull_data(
    documentType = "A65", processType = "A16",
    outBiddingZone_Domain = "10YCZ-CEPS-----N",
    periodStart = "201912312300", periodEnd = "202012312300")
  expect_equal(nrow(to_yearly(dat)), 1)
  expect_equal(dat %>%
                 dplyr::mutate(Year = lubridate::year(Date)) %>%
                 dplyr::group_by(Year) %>%
                 dplyr::summarize(sum = sum(`Realised Consumption`)) %>%
                 dplyr::select(sum) %>%
                 as.numeric(),
               64290077)
  expect_equal(dat %>%
                 dplyr::mutate(Year = lubridate::year(Date)) %>%
                 dplyr::group_by(Year) %>%
                 dplyr::summarize(mean = round(mean(`Realised Consumption`), 2)) %>%
                 dplyr::select(mean) %>%
                 as.numeric(),
               7319)
  expect_equal(dat %>%
                 dplyr::mutate(Year = lubridate::year(Date)) %>%
                 dplyr::group_by(Year) %>%
                 dplyr::summarize(median = round(median(`Realised Consumption`), 2)) %>%
                 dplyr::select(median) %>%
                 as.numeric(),
               7306)
})

test_that("Conversion to monthly is correct", {
  if(Sys.getenv("ENTSOE_KEY") == ""){
    stop()
  }
  dat <- pull_data(
    documentType = "A65", processType = "A16",
    outBiddingZone_Domain = "10YCZ-CEPS-----N",
    periodStart = "201912312300", periodEnd = "202012312300")
  test_sum <- dat %>%
    dplyr::mutate(Month = lubridate::month(Date)) %>%
    dplyr::group_by(Month) %>%
    dplyr::summarize(sum = sum(`Realised Consumption`)) %>%
    dplyr::select(sum) %>%
    as.vector()
  test_mean <- dat %>%
    dplyr::mutate(Month = lubridate::month(Date)) %>%
    dplyr::group_by(Month) %>%
    dplyr::summarize(mean = round(mean(`Realised Consumption`), 2)) %>%
    dplyr::select(mean) %>%
    as.vector()
  test_median <- dat %>%
    dplyr::mutate(Month = lubridate::month(Date)) %>%
    dplyr::group_by(Month) %>%
    dplyr::summarize(median = round(median(`Realised Consumption`), 2)) %>%
    dplyr::select(median) %>%
    as.vector()
  expect_equal(nrow(to_monthly(dat)), 12)
  expect_setequal(test_sum$sum, c(6391562, 5861256, 5882029, 4725507, 4721988, 4707301,
                    4758082, 4855509, 5010548, 5556211, 5848641, 5971443))
  expect_setequal(test_mean$mean, c(8590.81, 8421.34, 7905.95, 6563.20, 6346.76,
                                    6537.92, 6395.27, 6526.22, 6959.09, 7468.03,
                                    8123.11, 8026.13))
  expect_setequal(test_median$median, c(8559.0, 8272.0, 7872.0, 6557.5, 6167.5,
                                    6554.5, 6372.5, 6451.5, 6952.0, 7428.5,
                                    8118.5, 7856.5))
})

test_that("Conversion to weekly is correct", {
  if(Sys.getenv("ENTSOE_KEY") == ""){
    stop()
  }
  dat <- pull_data(
    documentType = "A65", processType = "A16",
    outBiddingZone_Domain = "10YCZ-CEPS-----N",
    periodStart = "201912312300", periodEnd = "202012312300")
  test_sum <- dat %>%
    dplyr::mutate(Week = lubridate::week(Date)) %>%
    dplyr::group_by(Week) %>%
    dplyr::summarize(sum = sum(`Realised Consumption`)) %>%
    dplyr::select(sum) %>%
    as.vector()
  test_mean <- dat %>%
    dplyr::mutate(Week = lubridate::week(Date)) %>%
    dplyr::group_by(Week) %>%
    dplyr::summarize(mean = round(mean(`Realised Consumption`), 2)) %>%
    dplyr::select(mean) %>%
    as.vector()
  test_median <- dat %>%
    dplyr::mutate(Week = lubridate::week(Date)) %>%
    dplyr::group_by(Week) %>%
    dplyr::summarize(median = round(median(`Realised Consumption`), 2)) %>%
    dplyr::select(median) %>%
    as.vector()
  expect_equal(nrow(to_weekly(dat)), 53)
  expect_true(test_sum$sum[1] == 1305958)
  expect_true(test_mean$mean[1] == 7773.56)
  expect_true(test_median$median[1] == 7765.0)
})

test_that("Conversion to daily is correct", {
  if(Sys.getenv("ENTSOE_KEY") == ""){
    stop()
  }
  dat <- pull_data(
    documentType = "A65", processType = "A16",
    outBiddingZone_Domain = "10YCZ-CEPS-----N",
    periodStart = "201912312300", periodEnd = "202012312300")
  test_sum <- dat %>%
    dplyr::mutate(Day = lubridate::day(Date)) %>%
    dplyr::group_by(Day) %>%
    dplyr::summarize(sum = sum(`Realised Consumption`)) %>%
    dplyr::select(sum) %>%
    as.vector()
  test_mean <- dat %>%
    dplyr::mutate(Day = lubridate::day(Date)) %>%
    dplyr::group_by(Day) %>%
    dplyr::summarize(mean = round(mean(`Realised Consumption`), 2)) %>%
    dplyr::select(mean) %>%
    as.vector()
  test_median <- dat %>%
    dplyr::mutate(Day = lubridate::day(Date)) %>%
    dplyr::group_by(Day) %>%
    dplyr::summarize(median = round(median(`Realised Consumption`), 2)) %>%
    dplyr::select(median) %>%
    as.vector()
  expect_equal(nrow(to_daily(dat)), 366)
  expect_true(test_sum$sum[1] == 2027321)
  expect_true(test_mean$mean[1] == 7039.31)
  expect_true(test_median$median[1] == 7037.5)
})
