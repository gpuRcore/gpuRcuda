
# need code to reshape if dimensions differ from input

#' @title Construct a cudaMatrix
#' @description Construct a cudaMatrix of a class that inherits
#' from \code{cudaMatrix}
#' @param data An object that is or can be converted to a 
#' \code{matrix} object
#' @param ncol An integer specifying the number of columns
#' @param nrow An integer specifying the number of rows
#' @param type A character string specifying the type of cudaMatrix.  Default
#' is NULL where type is inherited from the source data type.
#' @param ... Additional method to pass to cudaMatrix methods
#' @return A cudaMatrix object
#' @docType methods
#' @rdname cudaMatrix-methods
#' @author Charles Determan Jr.
#' @export
setGeneric("cudaMatrix", function(data = NA, ncol=NA, nrow=NA, type=NULL, ...){
  standardGeneric("cudaMatrix")
})

#' @rdname cudaMatrix-methods
#' @aliases cudaMatrix,matrix
setMethod('cudaMatrix', 
          signature(data = 'matrix'),
          function(data, type=NULL){
            
            if (is.null(type)) type <- typeof(data)
            
            data = switch(type,
                          integer = {
                            new("icudaMatrix", 
                                address=matrixToIntXptr(data))
                          },
                          float = {
                            new("fcudaMatrix", 
                                address=matrixToFloatXptr(data))
                          },
                          double = {
                            new("dcudaMatrix",
                                address = matrixToDoubleXptr(data))
                          },
                          stop("this is an unrecognized 
                                 or unimplemented data type")
            )
            
            return(data)
          },
          valueClass = "cudaMatrix"
)


#' @rdname cudaMatrix-methods
#' @aliases cudaMatrix,missing
setMethod('cudaMatrix', 
					signature(data = 'missing'),
					function(data, ncol=NA, nrow=NA, type=NULL){
						
						if (is.null(type)) type <- getOption("gpuRcuda.default.type")
						
						data = switch(type,
													integer = {
														new("icudaMatrix", 
																address=emptyIntXptr(nrow, ncol))
													},
													float = {
														new("fcudaMatrix", 
																address=emptyFloatXptr(nrow, ncol))
													},
													double = {
														new("dcudaMatrix",
																address = emptyDoubleXptr(nrow, ncol))
													},
													stop("this is an unrecognized 
                                 or unimplemented data type")
						)
						
						return(data)
					},
					valueClass = "cudaMatrix"
)


# #' @importClassesFrom gpuR gpuMatrix
# #' @rdname cudaMatrix-methods
# #' @aliases cudaMatrix,gpuMatrix
# setMethod('cudaMatrix', 
#           signature(data = 'gpuMatrix'),
#           function(data, type=NULL){
#             
#             if (is.null(type)) type <- typeof(data)
#             
#             data = switch(type,
#                           integer = {
#                             new("icudaMatrix", 
#                                 address=data@address)
#                           },
#                           float = {
#                             new("fcudaMatrix", 
#                                 address=data@address)
#                           },
#                           double = {
#                             new("dcudaMatrix",
#                                 address = data@address)
#                           },
#                           stop("this is an unrecognized 
#                                  or unimplemented data type")
#             )
#             
#             return(data)
#           },
#           valueClass = "cudaMatrix"
# )
