#' Area and EIC codes
#'
#' Dataset pulled directly from the Entso-E website
#' including all the available EIC and Area codes
#' for each country/region etc.
#' Areas for inter System Operator data interchange.
#'
#' @format A data frame with 1213 rows and 11 columns:
#' \describe{
#'   \item{EicCode}{The EIC is based on fixed length alphanumeric codes which can be broken down as follows:
#'   * A 2-character number identifying the Issuing Office assigned by ENTSO-E.
#'   * One Character identifying the object type that the code represents.
#'   * 12 digits, uppercase characters or minus signs allocated by the issuing office
#'   * 1 check character to ensure the code validity.}
#'   \item{EicDisplayName}{Machine friendly name for Country/Region/Participant.}
#'   \item{EicLongName}{Name of participant.}
#'   \item{EicParent}{If two different EIC Participants have the same VAT
#'   identification number or identification code and this is permitted by the
#'   local tax regulations, one of the two EIC codes should be designated as
#'   EIC Parent, otherwise one of the two EIC codes will not be accepted.}
#'   \item{EicResponsibleParty}{Responsible party for the publication.}
#'   \item{EicStatus}{Status of the EIC code (active/inactive).}
#'   \item{MarketParticipantPostalCode}{Postal code of the participating Entity.}
#'   \item{MarketParticipantIsoCountryCode}{Country code of the participating Entity.}
#'   \item{MarketParticipantVatCode}{VAT code of the participating Entity.}
#'   \item{EicTypeFunctionList}{}
#'   \item{type}{}
#' }
#' @source <https://eepublicdownloads.entsoe.eu/eic-codes-csv/Y_eiccodes.csv>
"areaY"


#' Mulitple datapoints and code descriptions for Entso-E API
#'
#' Dataset pulled from the Entso-E, transformed the pdf to list.
#' It includes many explenations for codes such as Document Type,
#' Business Type and many more
#'
#' @format A list containing 27 different dataframes
#' \describe{
#'  \item{UnitOfMeasureTypeList}{Unit of supplied data.}
#'  \item{TarifTypeTypeList}{Tarif type.}
#'  \item{StatusTypeList}{Status of the document.}
#'  \item{RoleTypeList}{Role of the party.}
#'  \item{RightsTypeList}{Type of right of the data point.}
#'  \item{ReasonCodeTypeList}{Indicating the reason for acceptance or rejection.}
#'  \item{QualityTypeList}{Quality of the data.}
#'  \item{ProcessTypeList}{Process type, information provided and on which
#'  schedule.}
#'  \item{PriceDirectionTypeList}{Income or expediture (sell or buy).}
#'  \item{PriceCategoryTypeList}{Price categorie.}
#'  \item{PaymentTermsTypeList}{Type of payment.}
#'  \item{ObjectAggregationTypeList}{Type of object, area, party etc.}
#'  \item{IndicatorTypeList}{Indicator.}
#'  \item{EicTypeList}{Type of EIC identifier.}
#'  \item{EnergyProductTypeList}{Active or reactive power/energy.}
#'  \item{DocumentTypeList}{Requested document type.}
#'  \item{DirectionTypeList}{Increase or decrease energy.}
#'  \item{CurveTypeList}{Curve type.}
#'  \item{CurrencyTypeList}{Currency.}
#'  \item{ContractTypeList}{Allocation of capacity.}
#'  \item{CodingSchemeTypeList}{Type of coding.}
#'  \item{ClassificationTypeList}{Classification.}
#'  \item{CategoryTypeList}{Category type.}
#'  \item{BusinessTypeList}{Type of business of the supplier.}
#'  \item{AuctionTypeList}{Auction type.}
#'  \item{AssetTypeList}{Type of generation/load.}
#'  \item{AllocationModeTypeList}{Type of allocation to buy power.}
#' }
#' @source <https://docstore.entsoe.eu/Documents/EDI/Library/Core/entso-e-code-list-v29r0.pdf>
"codeList"


#' EIC Area Code List
#'
#' Dateset pulled from the Entso-E server.
#' The data serves as identification table for the
#' locations of generation units. The df includes the name,
#' if given the street name and more. The dataset is primarely
#' used to append the location to a unit.
#'
#' @format  A data frame with 53380 rows and 11 columns:
#' \describe{
#'   \item{mRID}{The unique identification of the time
#'   * series within the document.}
#'   \item{docStatus}{Only used in case a document has
#'   * been submitted by mistake. A13 = Withdrawn.}
#'   \item{Instance}{Not anymore used.}
#'   \item{Name}{The full name associated to the EIC code.}
#'   \item{Name_Abbr}{The display name or short name to be used on displays.}
#'   \item{Date_Change}{Date of the request.}
#'   \item{Date_Deactivate}{Date when the deactivation will becarried out.}
#'   \item{Street}{Street of the EIC Location. At least the attribute “country” shall be published.}
#'   \item{aCERCode}{The ACER code associated to the EIC code of the market participant.}
#'   \item{Description}{The description of the EIC code.}
#'   \item{Function_Name}{The function(s) of the EIC code.}
#' }
#' @source <https://eepublicdownloads.blob.core.windows.net/public-cdn-container/clean-documents/fileadmin/user_upload/edi/library/eic/allocated-eic-codes.xml>
#' <https://eepublicdownloads.entsoe.eu/clean-documents/EDI/Library/cim_based/EIC_Data_Exchange_IG_v1.1.pdf>
"eicLoc"


