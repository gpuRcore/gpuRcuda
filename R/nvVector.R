#' @title Construct a nvVector
#' @description Construct a nvVector of a class that inherits
#' from \code{nvVector}
#' @param data An object that is or can be converted to a 
#' \code{vector}
#' @param length A non-negative integer specifying the desired length.
#' @param type A character string specifying the type of nvVector.  Default
#' is NULL where type is inherited from the source data type.
#' @param ... Additional method to pass to nvVector methods
#' @return A nvVector object
#' @docType methods
#' @rdname nvVector-methods
#' @author Charles Determan Jr.
#' @export
setGeneric("nvVector", function(data, length, type=NULL, ...){
	standardGeneric("nvVector")
})

#' @rdname nvVector-methods
#' @aliases nvVector,vector
setMethod('nvVector', 
					signature(data = 'vector', length = 'missing'),
					function(data, type=NULL){
						
						if (is.null(type)) type <- typeof(data)
						size <- length(data)
						
						data = switch(type,
													integer = {
														new("invVector", 
																address=sexpToHostVector(data, size, 4L))
													},
													float = {
														new("fnvVector", 
																address=sexpToHostVector(data, size, 6L))
													},
													double = {
														new("dnvVector",
																address = sexpToHostVector(data, size, 8L))
													},
													stop("this is an unrecognized 
															 or unimplemented data type")
													)
						
						return(data)
						},
					valueClass = "nvVector")


#' @rdname nvVector-methods
#' @aliases nvVector,missing
setMethod('nvVector', 
					signature(data = 'missing'),
					function(data, length, type=NULL){
						
						if (is.null(type)) type <- getOption("gpuRcuda.default.type")
						if (length <= 0) stop("length must be a positive integer")
						if (length != as.integer(length)) stop("length must be a positive integer")
						
						data = switch(type,
													integer = {
														new("invVector", 
																address=nvVecEmpty(length, 4L))
													},
													float = {
														new("fnvVector", 
																address=nvVecEmpty(length, 6L))
													},
													double = {
														new("dnvVector",
																address = nvVecEmpty(length, 8L))
													},
													stop("this is an unrecognized 
                                 or unimplemented data type")
						)
						
						return(data)
					},
					valueClass = "nvVector")
