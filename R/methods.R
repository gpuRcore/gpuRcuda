
#' @export
setMethod("%*%", signature(x="cudaMatrix", y = "cudaMatrix"),
          function(x,y)
          {
            if( dim(x)[2] != dim(y)[1]){
              stop("Non-conformant matrices")
            }
            return(cudaMatMult(x, y))
          },
          valueClass = "cudaMatrix"
)



#' @export
setMethod('typeof', signature(x="cudaMatrix"),
          function(x) return(x@type))