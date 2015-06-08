#' @export
setMethod("%*%", signature(x="fcudaMatrix", y = "fcudaMatrix"),
					function(x,y)
					{
						if( dim(x)[2] != dim(y)[1]){
							stop("Non-conformant matrices")
						}
						
						res <- new("fcudaMatrix", 
											 x=cpp_vienna_cudaMatrix_sgemm(x@x,y@x),
											 type="float"
						)
						
						return(res)
					},
					valueClass = "fcudaMatrix"
)

#' @export
setMethod("%*%", signature(x="dcudaMatrix", y = "dcudaMatrix"),
					function(x,y)
					{
						if( dim(x)[2] != dim(y)[1]){
							stop("Non-conformant matrices")
						}
						
						res <- new("dcudaMatrix", 
											 x=cpp_vienna_cudaMatrix_dgemm(x@x,y@x),
											 type="double"
						)
						
						return(res)
					},
					valueClass = "dcudaMatrix"
)