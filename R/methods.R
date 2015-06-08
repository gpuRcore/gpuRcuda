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

#' @export
setMethod("Arith", c(e1="fcudaMatrix", e2="fcudaMatrix"),
					function(e1, e2)
					{
						e3 <- e1
						op = .Generic[[1]]
						switch(op,
									 `+` = new("fcudaMatrix", 
									 					x=cpp_vienna_cudaMatrix_saxpy(1, e3@x, e2@x),
									 					type = "float"),
									 `-` = new("fcudaMatrix", 
									 					x=cpp_vienna_cudaMatrix_saxpy(-1, e3@x, e2@x),
									 					type = "float"),
									{
										stop("undefined operation")
									}
						)
					},
valueClass = "fcudaMatrix"
)

#' @export
setMethod("Arith", c(e1="dcudaMatrix", e2="dcudaMatrix"),
					function(e1, e2)
					{
						e3 <- e1
						op = .Generic[[1]]
						switch(op,
									 `+` = new("dcudaMatrix", 
									 					x=cpp_vienna_cudaMatrix_daxpy(1, e3@x, e2@x),
									 					type = "double"),
									 `-` = new("dcudaMatrix", 
									 					x=cpp_vienna_cudaMatrix_daxpy(-1, e3@x, e2@x),
									 					type = "double"),
{
	stop("undefined operation")
}
						)
					},
valueClass = "dcudaMatrix"
)

