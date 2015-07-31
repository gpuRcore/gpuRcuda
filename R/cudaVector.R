#' @title Construct a cudaVector
#' @description Construct a cudaVector of a class that inherits
#' from \code{cudaVector}
#' @param data An object that is or can be converted to a 
#' \code{vector}
#' @param length A non-negative integer specifying the desired length.
#' @param type A character string specifying the type of cudaVector.  Default
#' is NULL where type is inherited from the source data type.
#' @param ... Additional method to pass to cudaVector methods
#' @return A cudaVector object
#' @docType methods
#' @rdname cudaVector-methods
#' @author Charles Determan Jr.
#' @export
setGeneric("cudaVector", function(data, length, type=NULL, ...){
	standardGeneric("cudaVector")
})

#' @rdname cudaVector-methods
#' @aliases cudaVector,vector
setMethod('cudaVector', 
					signature(data = 'vector', length = 'missing'),
					function(data, length, type=NULL){
						
						if (is.null(type)) type <- typeof(data)
						if (!missing(length)) {
							warning("length argument not currently used when passing
											in data")
						}
						
						data = switch(type,
													integer = {
														new("icudaVector", 
																address=vectorToIntXptr(data))
													},
													float = {
														new("fcudaVector", 
																address=vectorToFloatXptr(data))
													},
													double = {
														new("dcudaVector",
																address = vectorToDoubleXptr(data))
													},
													stop("this is an unrecognized 
															 or unimplemented data type")
													)
						
						return(data)
						},
					valueClass = "cudaVector")


#' @rdname cudaVector-methods
#' @aliases cudaVector,missing
setMethod('cudaVector', 
					signature(data = 'missing'),
					function(data, length, type=NULL){
						
						if (is.null(type)) type <- getOption("gpuRcuda.default.type")
						if (length <= 0) stop("length must be a positive integer")
						if (!is.integer(length)) stop("length must be a positive integer")
						
						data = switch(type,
													integer = {
														new("icudaVector", 
																address=emptyVecIntXptr(length))
													},
													float = {
														new("fcudaVector", 
																address=emptyVecFloatXptr(length))
													},
													double = {
														new("dcudaVector",
																address = emptyVecDoubleXptr(length))
													},
													stop("this is an unrecognized 
                                 or unimplemented data type")
						)
						
						return(data)
					},
					valueClass = "cudaVector")
