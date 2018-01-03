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
					function(data, length=NULL, type=NULL){
						
						if (is.null(type)) type <- typeof(data)
						
						data = switch(type,
													integer = {
														new("icudaVector", 
																address = sexpToDeviceVector(data, length(data), 4L))
													},
													float = {
														new("fcudaVector", 
																address = sexpToDeviceVector(data, length(data), 6L))
													},
													double = {
														new("dcudaVector",
																address = sexpToDeviceVector(data, length(data), 8L))
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
						if (length != as.integer(length)) stop("length must be a positive integer")
						
						data = switch(type,
													integer = {
														new("icudaVector", 
																address = cudaVecEmpty(length, 4L))
													},
													float = {
														new("fcudaVector", 
																address = cudaVecEmpty(length, 6L))
													},
													double = {
														new("dcudaVector",
																address = cudaVecEmpty(length, 8L))
													},
													stop("this is an unrecognized 
                                 or unimplemented data type")
						)
						
						return(data)
					},
					valueClass = "cudaVector")
