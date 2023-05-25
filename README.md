# REntsoE  <img src="man/figures/Logo.png" align="right" height="138">

<!-- badges: start -->
[![Codecov test coverage](https://codecov.io/gh/angryvoegi/REntsoE/branch/master/graph/badge.svg)](https://app.codecov.io/gh/angryvoegi/REntsoE?branch=master)
[![R-CMD-check](https://github.com/angryvoegi/REntsoE/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/angryvoegi/REntsoE/actions/workflows/R-CMD-check.yaml)
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

To get access to the data, you need a [Security Token](https://transparency.entsoe.eu/content/static_content/Static%20content/web%20api/Guide.html#_authentication_and_authorisation).

## How-to use

First, write your security token to the .Renviron of your R with 

```r
REntsoE::set_apikey("<YOUR_KEY>")
```

In a next step, in case you are not to familiar with the EIC codes and different available data points, take a look at the following included datasets.

```r
head(REntsoE::areaY)
           EicCode   EicDisplayName                                   EicLongName EicParent EicResponsibleParty EicStatus MarketParticipantPostalCode MarketParticipantIsoCountryCode
1 14YCCPADATENMLDW         CCPACCP1                              CCP Austria GmbH                                  Active                                                            
2 14YEXAADATENML2F         EXAACCP2 EXAA Abwicklungsstelle für Energieprodukte AG                                  Active                                                            
3 14YEXAADATENMLDU          EXAACCP EXAA Abwicklungsstelle für Energieprodukte AG                                  Active                                                            
4 10Y1001A1001A81J      IT-NORTH_FR                            Italy North_France                                  Active                                                            
5 10Y1001A1001A85B IT-MACRZONESOUTH           Market Balance Area MACROZONE SOUTH                                  Active                                                            
6 10Y1001A1001A91G      NORDIC_AREA                            Nordic Market Area                                  Active                                                            
  MarketParticipantVatCode                                                             EicTypeFunctionList type
1                       NA                                        Bidding Zone, Balance Group, Market Area    Y
2                       NA                                                      Market Area, Balance Group    Y
3                       NA                                        Balance Group, Bidding Zone, Market Area    Y
4                       NA                                                                    Bidding Zone    Y
5                       NA                                                                 Scheduling Area    Y
6                       NA Outage Coordination Region, LFC Block, Capacity Calculation Region, Market Area    Y
```





# Acknowledgement

I am incredibly thankful to my girlfriend Bianca Siegrist for her talent and creativity in crafting a beautiful logo for my project. 
