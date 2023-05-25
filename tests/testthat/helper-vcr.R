library("vcr") # *Required* as vcr is set up on loading
invisible(vcr::vcr_configure(
  dir = "../fixtures"
))
vcr_dir <- vcr::vcr_test_path("fixtures")
if (!nzchar(Sys.getenv("ENTSOE_KEY"))) {
  if (dir.exists(vcr_dir)) {
    # Fake API token to fool our package
    Sys.setenv("ENTSOE_KEY" = "foobar")
  } else {
    # If there's no mock files nor API token, impossible to run tests
    stop("No API key nor cassettes, tests cannot be run.",
         call. = FALSE)
  }
}
vcr::check_cassette_names()

