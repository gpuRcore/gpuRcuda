
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
                                x=data,
                                type=type)
                          },
                          float = {
                            new("fcudaMatrix", 
                                x=data,
                                type=type)
                          },
                          double = {
                            new("dcudaMatrix",
                                x = data, 
                                type=type)
                          },
                          stop("this is an unrecognized 
                                 or unimplemented data type")
            )
            
            return(data)
          },
          valueClass = "cudaMatrix"
)


#' @rdname cudaMatrix-methods
#' @aliases cudaMatrix,matrix
setMethod('cudaMatrix', 
          signature(data = 'gpuMatrix'),
          function(data, type=NULL){
            
            if (is.null(type)) type <- typeof(data)
            
            data = switch(type,
                          integer = {
                            new("icudaMatrix", 
                                x=data@x,
                                type=type)
                          },
                          float = {
                            new("fcudaMatrix", 
                                x=data@x,
                                type=type)
                          },
                          double = {
                            new("dcudaMatrix",
                                x = data@x, 
                                type=type)
                          },
                          stop("this is an unrecognized 
                                 or unimplemented data type")
            )
            
            return(data)
          },
          valueClass = "cudaMatrix"
)