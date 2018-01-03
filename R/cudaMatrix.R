
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
                                address = sexpToDeviceMatrix(data, nrow(data), ncol(data), type = 4L))
                          },
                          float = {
                            new("fcudaMatrix", 
                                address = sexpToDeviceMatrix(data, nrow(data), ncol(data), type = 6L))
                          },
                          double = {
                            new("dcudaMatrix",
                                address = sexpToDeviceMatrix(data, nrow(data), ncol(data), type = 8L))
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
																address = cudaMatEmtpy(nrow, ncol, 4L))
													},
													float = {
														new("fcudaMatrix", 
																address = cudaMatEmtpy(nrow, ncol, 6L))
													},
													double = {
														new("dcudaMatrix",
																address = cudaMatEmtpy(nrow, ncol, 8L))
													},
													stop("this is an unrecognized 
                                 or unimplemented data type")
						)
						
						return(data)
					},
					valueClass = "cudaMatrix"
)

