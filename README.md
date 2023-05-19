# REntsoE

<!-- badges: start -->
[![R-CMD-check](https://github.com/r-lib/rcmdcheck/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/r-lib/rcmdcheck/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

R Package for the [Entso-E Transparency Platform](https://transparency.entsoe.eu/). 
The aim of this package is to get easy access to the (to date) Generation and Load data through the Entso-E API. 
The package is still being developed with the goal to pull every endpoint from the API.

## Installation

The development version of the package can be installed from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("angryvoegi/REntsoE")
```

## Pre-requisits

To get access to the data, you need a [Security Token](https://transparency.entsoe.eu/content/static_content/Static%20content/web%20api/Guide.html#_authentication_and_authorisation)

## How-to use

First, write your security token to the .Renviron of your R with 

```r
REntsoE::set_apikey("<YOUR_KEY>")
```

