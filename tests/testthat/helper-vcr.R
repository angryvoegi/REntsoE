library("vcr") # *Required* as vcr is set up on loading
invisible(vcr::vcr_configure(
  dir = "../REntsoE/tests/fixtures"
))
vcr::check_cassette_names()
