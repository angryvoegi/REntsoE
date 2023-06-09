% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/handle_colnames.R
\name{dynamic_colnames}
\alias{dynamic_colnames}
\title{Create dynamic colnames}
\usage{
dynamic_colnames(df, rawdat, onlyTS_dat, codeList, PSR = FALSE)
}
\arguments{
\item{df}{Final data frame (without proper colnames)}

\item{rawdat}{Converted XML response to list}

\item{onlyTS_dat}{List of data containing only the time series data}

\item{codeList}{CodeList (data frame that comes with this package)}

\item{PSR}{If PSR is true, old colnames and process names are pasted together to
form the new colnames}
}
\value{
Vector with correct colnames
}
\description{
Function dynamically creates colnames. Used for each
unique data point.
}
\details{
Append the processtype (e.g. intraday total) to the colnames. This
is done with the `get_params` function.
}
