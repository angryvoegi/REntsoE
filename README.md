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

In a next step, in case you are not to familiar with the EIC codes, take a look at the following included datasets:

```r
head(REntsoE::areaY)
           EicCode   EicDisplayName                                   EicLongName EicParent EicResponsibleParty EicStatus MarketParticipantPostalCode MarketParticipantIsoCountryCode MarketParticipantVatCode                                                             EicTypeFunctionList type
1 14YCCPADATENMLDW         CCPACCP1                              CCP Austria GmbH                                  Active                                                                                   NA                                        Bidding Zone, Balance Group, Market Area    Y
2 14YEXAADATENML2F         EXAACCP2 EXAA Abwicklungsstelle für Energieprodukte AG                                  Active                                                                                   NA                                                      Market Area, Balance Group    Y
3 14YEXAADATENMLDU          EXAACCP EXAA Abwicklungsstelle für Energieprodukte AG                                  Active                                                                                   NA                                        Balance Group, Bidding Zone, Market Area    Y
4 10Y1001A1001A81J      IT-NORTH_FR                            Italy North_France                                  Active                                                                                   NA                                                                    Bidding Zone    Y
5 10Y1001A1001A85B IT-MACRZONESOUTH           Market Balance Area MACROZONE SOUTH                                  Active                                                                                   NA                                                                 Scheduling Area    Y
6 10Y1001A1001A91G      NORDIC_AREA                            Nordic Market Area                                  Active                                                                                   NA Outage Coordination Region, LFC Block, Capacity Calculation Region, Market Area    Y             
```

The list `codeList` has 27 different tables inside. The following tables are available:

```r
names(REntsoE::codeList)
 [1] "UnitOfMeasureTypeList"     "TarifTypeTypeList"         "StatusTypeList"            "RoleTypeList"              "RightsTypeList"            "ReasonCodeTypeList"       
 [7] "QualityTypeList"           "ProcessTypeList"           "PriceDirectionTypeList"    "PriceCategoryTypeList"     "PaymentTermsTypeList"      "ObjectAggregationTypeList"
[13] "IndicatorTypeList"         "EicTypeList"               "EnergyProductTypeList"     "DocumentTypeList"          "DirectionTypeList"         "CurveTypeList"            
[19] "CurrencyTypeList"          "ContractTypeList"          "CodingSchemeTypeList"      "ClassificationTypeList"    "CategoryTypeList"          "BusinessTypeList"         
[25] "AuctionTypeList"           "AssetTypeList"             "AllocationModeTypeList"  
```

Different data points require different variables. To date, following data points are implemented in the package. Behind the name, the used name from the [API documentation](https://transparency.entsoe.eu/content/static_content/Static%20content/web%20api/Guide.html#_load_domain) and from the [Knowledge Base](https://transparency.entsoe.eu/content/static_content/Static%20content/knowledge%20base/knowledge%20base.html) is included.

-  Actual Total Load [6.1.A]                
-  Day-Ahead Total Load Forecast [6.1.B]
-  Week-Ahead Total Load Forecast [6.1.C]
-  Month-Ahead Total Load Forecast [6.1.D]
-  Year-Ahead Total Load Forecast [6.1.E]
-  Year-Ahead Forecast Margin [8.1]
-  Forecasted Capacity [11.1.A]
-  Installed Generation Capacity Aggregated [14.1.A]
-  Installed Generation Capacity per Unit [14.1.B]
-  Day-ahead Aggregated Generation [14.1.C]
-  Day-ahead Generation Forecasts for Wind and Solar [14.1.D]
-  Current Generation Forecasts for Wind and Solar [14.1.D]
-  Intraday Generation Forecasts for Wind and Solar [14.1.D]
-  Actual Generation Output per Generation Unit [16.1.A]
-  Aggregated Filling Rate of Water Reservoirs and Hydro Storage Plants [16.1.D]
-  Aggregated Generation per Type [16.1.B&C]

Besides the EIC code and the different documentTypes or processTypes, there is another important information which the call needs: The defined time horizon.
The API call works with the date in the format **YYYYMMDDHHMM**. Different endpoints have different time horizon restrictions. View them in the [API documentation](https://transparency.entsoe.eu/content/static_content/Static%20content/web%20api/Guide.html#_load_domain).

If you have found your desired data point and have set the API key, the data can be pulled using the function `pull_data`.
Lets say we want to pull the *Actual Total Load* for Switzerland from the year 2020, we would use the following function definitions:

```r
REntsoE::pull_data(
  documentType = "A65",                                # Which data point should be pulled
  processType = "A16",                                 # Which aggregation method
  outBiddingZone_Domain = "10YCH-SWISSGRIDZ",          # EIC code
  periodStart = "201912312300",                        # Start point
  periodEnd = "202012312300"                           # End point
) %>%
    head()
    
                 Date Realised Consumption
1 2020-01-01 00:00:00                 6886
2 2020-01-01 01:00:00                 7012
3 2020-01-01 02:00:00                 7134
4 2020-01-01 03:00:00                 6973
5 2020-01-01 04:00:00                 7581
6 2020-01-01 05:00:00                 7180
    
```

Depending on the desired endpoint, the call changes. The next example pull the *Forecasted Capacity*.

```r
REntsoE::pull_data(
  documentType = "A61",                     # Which data point should be pulled
  contract_MarketAgreement.Type = "A01",    # Type of contract, in this case daily
  in_Domain = "10YCZ-CEPS-----N",           # EIC code of the Czech Republic
  out_Domain = "10YSK-SEPS-----K",          # EIC code of the Slovak Republic
  periodStart = "201912312300",             # Start point
  periodEnd = "202012312300"                # End point
) %>%
    head()

                 Date BZN|SK>BZN|CZ
1 2020-01-01 00:00:00          1200
2 2020-01-01 01:00:00          1200
3 2020-01-01 02:00:00          1200
4 2020-01-01 03:00:00          1200
5 2020-01-01 04:00:00          1200
6 2020-01-01 05:00:00          1200    
```

The package always returns a data frame.

# Acknowledgement

I am incredibly thankful to my girlfriend Bianca Siegrist for her talent and creativity in crafting a beautiful logo for my project. 
