
# need code to reshape if dimensions differ from input

#' @title Construct a nvMatrix
#' @description Construct a nvMatrix of a class that inherits
#' from \code{nvMatrix}
#' @param data An object that is or can be converted to a 
#' \code{matrix} object
#' @param ncol An integer specifying the number of columns
#' @param nrow An integer specifying the number of rows
#' @param type A character string specifying the type of nvMatrix.  Default
#' is NULL where type is inherited from the source data type.
#' @param ... Additional method to pass to nvMatrix methods
#' @return A nvMatrix object
#' @docType methods
#' @rdname nvMatrix-methods
#' @author Charles Determan Jr.
#' @export
setGeneric("nvMatrix", function(data = NA, ncol=NA, nrow=NA, type=NULL, ...){
	standardGeneric("nvMatrix")
})

#' @rdname nvMatrix-methods
#' @aliases nvMatrix,matrix
setMethod('nvMatrix', 
					signature(data = 'matrix'),
					function(data, type=NULL){
						
						if (is.null(type)) type <- typeof(data)
						
						nrow <- nrow(data)
						ncol <- ncol(data)
						
						data = switch(type,
													integer = {
														new("invMatrix", 
																address=sexpToHostMatrix(data, nrow, ncol, type = 4L))
													},
													float = {
														stop("float not yet implemented")
														# new("fnvMatrix", 
														# 		address=sexpToHostMatrix(data))
													},
													double = {
														new("dnvMatrix",
																address = sexpToHostMatrix(data, nrow, ncol, type = 8L))
													},
													stop("this is an unrecognized 
															 or unimplemented data type")
													)
						
						return(data)
					},
					valueClass = "nvMatrix"
)


#' @rdname nvMatrix-methods
#' @aliases nvMatrix,missing
setMethod('nvMatrix',
					signature(data = 'missing'),
					function(data, ncol=NA, nrow=NA, type=NULL){

						if (is.null(type)) type <- getOption("gpuRcuda.default.type")

						data = switch(type,
													integer = {
														new("invMatrix",
																address=nvMatEmtpy(nrow, ncol, 4L))
													},
													float = {
														new("fnvMatrix",
																address=nvMatEmtpy(nrow, ncol, 6L))
													},
													double = {
														new("dnvMatrix",
																address = nvMatEmtpy(nrow, ncol, 8L))
													},
													stop("this is an unrecognized
															 or unimplemented data type")
													)

						return(data)
					},
					valueClass = "nvMatrix"
)
