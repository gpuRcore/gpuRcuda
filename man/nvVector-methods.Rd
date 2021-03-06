% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nvVector.R
\docType{methods}
\name{nvVector}
\alias{nvVector}
\alias{nvVector,vector,missing-method}
\alias{nvVector,vector}
\alias{nvVector,missing,ANY-method}
\alias{nvVector,missing}
\title{Construct a nvVector}
\usage{
nvVector(data, length, type = NULL, ...)

\S4method{nvVector}{vector,missing}(data, type = NULL)

\S4method{nvVector}{missing,ANY}(data, length, type = NULL)
}
\arguments{
\item{data}{An object that is or can be converted to a 
\code{vector}}

\item{length}{A non-negative integer specifying the desired length.}

\item{type}{A character string specifying the type of nvVector.  Default
is NULL where type is inherited from the source data type.}

\item{...}{Additional method to pass to nvVector methods}
}
\value{
A nvVector object
}
\description{
Construct a nvVector of a class that inherits
from \code{nvVector}
}
\author{
Charles Determan Jr.
}
