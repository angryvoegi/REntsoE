structure(list(url = "https://web-api.tp.entsoe.eu/api?documentType=A70&outBiddingZone_Domain=10YCZ-CEPS-----N&periodEnd=202012312300&periodStart=201912312300&processType=A33&securityToken=",
    status_code = 200L, headers = structure(list(date = "Fri, 26 May 2023 09:22:55 GMT",
        server = "Apache", `strict-transport-security` = "max-age=31536000 ; includeSubDomains",
        `x-powered-by` = "Undertow/1", `transfer-encoding` = "chunked",
        `content-type` = "text/xml"), class = c("insensitive",
    "list")), all_headers = list(list(status = 200L, version = "HTTP/1.1",
        headers = structure(list(date = "Fri, 26 May 2023 09:22:55 GMT",
            server = "Apache", `strict-transport-security` = "max-age=31536000 ; includeSubDomains",
            `x-powered-by` = "Undertow/1", `transfer-encoding` = "chunked",
            `content-type` = "text/xml"), class = c("insensitive",
        "list")))), cookies = structure(list(domain = logical(0),
        flag = logical(0), path = logical(0), secure = logical(0),
        expiration = structure(numeric(0), class = c("POSIXct",
        "POSIXt")), name = logical(0), value = logical(0)), row.names = integer(0), class = "data.frame"),
    content = charToRaw("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<GL_MarketDocument xmlns=\"urn:iec62325.351:tc57wg16:451-6:generationloaddocument:3:0\">\n\t<mRID>d777136257074b7abed1c7524a6fbcaa</mRID>\n\t<revisionNumber>1</revisionNumber>\n\t<type>A70</type>\n\t<process.processType>A33</process.processType>\n\t<sender_MarketParticipant.mRID codingScheme=\"A01\">10X1001A1001A450</sender_MarketParticipant.mRID>\n\t<sender_MarketParticipant.marketRole.type>A32</sender_MarketParticipant.marketRole.type>\n\t<receiver_MarketParticipant.mRID codingScheme=\"A01\">10X1001A1001A450</receiver_MarketParticipant.mRID>\n\t<receiver_MarketParticipant.marketRole.type>A33</receiver_MarketParticipant.marketRole.type>\n\t<createdDateTime>2023-05-26T09:22:56Z</createdDateTime>\n\t<time_Period.timeInterval>\n\t\t<start>2019-12-31T23:00Z</start>\n\t\t<end>2020-12-31T23:00Z</end>\n\t</time_Period.timeInterval>\n\t<TimeSeries>\n\t\t<mRID>1</mRID>\n\t\t<businessType>A91</businessType>\n\t\t<objectAggregation>A01</objectAggregation>\n\t\t<outBiddingZone_Domain.mRID codingScheme=\"A01\">10YCZ-CEPS-----N</outBiddingZone_Domain.mRID>\n\t\t<quantity_Measure_Unit.name>MAW</quantity_Measure_Unit.name>\n\t\t<curveType>A01</curveType>\n\t\t<Period>\n\t\t\t<timeInterval>\n\t\t\t\t<start>2019-12-31T23:00Z</start>\n\t\t\t\t<end>2020-12-31T23:00Z</end>\n\t\t\t</timeInterval>\n\t\t\t<resolution>P1Y</resolution>\n\t\t\t<Point>\n                <position>1</position>\n                    <quantity>321</quantity>\n\t\t\t</Point>\n\t\t</Period>\n</TimeSeries>\n</GL_MarketDocument>"),
    date = structure(1685092975, class = c("POSIXct", "POSIXt"
    ), tzone = "GMT"), times = c(redirect = 0, namelookup = 0.030343,
    connect = 0.070963, pretransfer = 0.132674, starttransfer = 1.584197,
    total = 1.795767)), class = "response")
