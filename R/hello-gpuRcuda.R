#' @title CUDA GPU functions for R Objects
#' 
#' @description This package was developed to provide an extension to the
#' \pkg{gpuR} to allow use of NVIDIA GPU's.  As with the predecessor, this 
#' package removes the complex code needed for GPU computing and provide 
#' easier to use functions to apply on R objects.
#' 
#' \tabular{ll}{ Package: \tab gpuRcuda\cr Type: \tab Package\cr 
#' Version: \tab 1.0.0\cr Date: \tab 2015-03-31\cr License: \tab GPL-3\cr
#' Copyright: \tab (c) 2015 Charles E. Determan Jr.\cr URL: \tab 
#' \url{http://www.github.com/cdeterman/gpuRcuda}\cr LazyLoad: \tab yes\cr
#' }
#' 
#' 
#' @note This package is entirely dependently upon \pkg{gpuR}.  This decision 
#' was made for the following reasons: \preformatted{
#' 
#' 1. Avoid repetition of code that would be duplicated from \pkg{gpuR}.
#' 
#' 2. This will allow any updates in the parent package to immediately be
#' available within this package (using the OpenCL backend) until corresponding
#' CUDA functions are made available.
#' 
#' }
#' @author 
#' Charles Determan \email{cdetermanjr@@gmail.com}
#' 
#' Maintainer: Charles Determan \email{cdetermanjr@@gmail.com}
#' @docType package
#' @name gpuRcuda-package
#' @aliases gpuRcuda-package gpuRcuda
NULL