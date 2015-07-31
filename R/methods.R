
# Currently separate methods until integer methods
# written in CUDA, then will consolidate
# This separate allows for using the parent gpuR methods
# Note - when consolidating will need to make sure to import typeof from gpuR




#' Single Precision CUDA Matrix Addition/Subtraction
#' @param e1 An fcudaMatrix object
#' @param e2 An fcudaMatrix object
#' @export
setMethod("Arith", c(e1="fcudaMatrix", e2="fcudaMatrix"),
					function(e1, e2)
					{						
						Z <- cudaMatrix(nrow=nrow(e1), ncol=ncol(e2), type="float")
						if(length(e2[]) != length(e1[])) stop("Lengths of matrices must match")
						Z@address <- e1@address
						
						op = .Generic[[1]]
						
						switch(op,
									 `+` = cpp_vienna_cudaMatrix_saxpy(1, 
									 																	Z@address, 
									 																	e2@address),
									 `-` = cpp_vienna_cudaMatrix_saxpy(-1, 
									 																	Z@address, 
									 																	e2@address),
									{
										stop("undefined operation")	
									}
						)
						
						return(Z)
					},
valueClass = "fcudaMatrix"
)

#' Double Precision CUDA Matrix Addition/Subtraction
#' @param e1 An dcudaMatrix object
#' @param e2 An dcudaMatrix object
#' @export
setMethod("Arith", c(e1="dcudaMatrix", e2="dcudaMatrix"),
					function(e1, e2)
					{
						if(!deviceHasDouble()){
							stop("Selected GPU does not support double precision")
						}else{
							op = .Generic[[1]]
							
							Z <- cudaMatrix(nrow=nrow(e1), ncol=ncol(e2), type="double")
							
							if(length(e2[]) != length(e1[])) stop("Lengths of matrices must match")
							Z@address <- e1@address
							
							op = .Generic[[1]]
							
							switch(op,
										 `+` = cpp_vienna_cudaMatrix_daxpy(1, 
										 																	Z@address, 
										 																	e2@address),
										 `-` = cpp_vienna_cudaMatrix_daxpy(-1, 
										 																	Z@address, 
										 																	e2@address),
										{
											stop("undefined operation")	
										}
							)
							return(Z)
						}
					},
valueClass = "dcudaMatrix"
)


#' CUDA Matrix Multiplication
#' @param x An fcudaMatrix object
#' @param y An fcudaMatrix object
#' @export
setMethod("%*%", signature(x="cudaMatrix", y = "cudaMatrix"),
					function(x,y)
					{
						if( dim(x)[2] != dim(y)[1]){
							stop("Non-conformant matrices")
						}
						return(gpu_Mat_mult(x, y))
					},
					valueClass = "cudaMatrix"
)


#' @title Row and Column Sums and Means of cudaMatrix
#' @description Row and column sums and of cudaMatrix objects
#' @param x A cudaMatrix object
#' @param na.rm Not currently used
#' @param dims Not currently used
#' @return A cudaVector object
#' @author Charles Determan Jr.
#' @docType methods
#' @rdname cudaMatrix-colSums
#' @aliases colSums,cudaMatrix
#' @export
setMethod("colSums",
					signature(x = "cudaMatrix", na.rm = "missing", dims = "missing"),
					function(x, na.rm, dims){
						cuda_colSums(x)
					})

#' @rdname cudaMatrix-colSums
#' @export
setMethod("rowSums",
					signature(x = "cudaMatrix", na.rm = "missing", dims = "missing"),
					function(x, na.rm, dims){
						cuda_rowSums(x)
					})

#' @rdname cudaMatrix-colSums
#' @export
setMethod("colMeans",
					signature(x = "cudaMatrix", na.rm = "missing", dims = "missing"),
					function(x, na.rm, dims){
						cuda_colMeans(x)
					})

#' @rdname cudaMatrix-colSums
#' @export
setMethod("rowMeans",
					signature(x = "cudaMatrix", na.rm = "missing", dims = "missing"),
					function(x, na.rm, dims){
						cuda_rowMeans(x)
					})

#' @title The Number of Rows/Columns of a cudaMatrix
#' @param x A cudaMatrix object
#' @return An integer of length 1
#' @rdname nrow.cudaMatrix
#' @aliases nrow,cudaMatrix
#' @aliases ncol,cudaMatrix
#' @author Charles Determan Jr.
#' @export
setMethod('nrow', signature(x="cudaMatrix"), 
					function(x) {
						switch(typeof(x),
									 "integer" = return(cpp_inrow(x@address)),
									 "float" = return(cpp_fnrow(x@address)),
									 "double" = return(cpp_dnrow(x@address))
						)
					}
)

#' @rdname nrow.cudaMatrix
#' @export
setMethod('ncol', signature(x="cudaMatrix"),
					function(x) {
						switch(typeof(x),
									 "integer" = return(cpp_incol(x@address)),
									 "float" = return(cpp_fncol(x@address)),
									 "double" = return(cpp_dncol(x@address))
						)
					}
)


#' @title cudaMatrix dim method
#' @param x A cudaMatrix object
#' @return A length 2 vector of the number of rows and columns respectively.
#' @author Charles Determan Jr.
#' @aliases dim,cudaMatrix
#' @export
setMethod('dim', signature(x="cudaMatrix"),
					function(x) return(c(nrow(x), ncol(x))))

#' @title Extract all cudaMatrix elements
#' @param x A cudaMatrix object
#' @param i missing
#' @param j missing
#' @param drop missing
#' @aliases [,cudaMatrix
#' @author Charles Determan Jr.
#' @export
setMethod("[",
					signature(x = "cudaMatrix", i = "missing", j = "missing", drop = "missing"),
					function(x, i, j, drop) {
						switch(typeof(x),
									 "integer" = return(iXptrToSEXP(x@address)),
									 "float" = return(fXptrToSEXP(x@address)),
									 "double" = return(dXptrToSEXP(x@address))
						)
					})

# #' Single Precision CUDA Matrix Multiplication
# #' @param x An fcudaMatrix object
# #' @param y An fcudaMatrix object
# #' @export
# setMethod("%*%", signature(x="fcudaMatrix", y = "fcudaMatrix"),
# 					function(x,y)
# 					{
# 						if( dim(x)[2] != dim(y)[1]){
# 							stop("Non-conformant matrices")
# 						}
# 						
# 						C <- cudaMatrix(nrow=nrow(x), ncol=ncol(y), type="float")
# 						
# 						cpp_vienna_cudaMatrix_sgemm(x@address,
# 																				y@address,
# 																				C@address)
# 						
# 						return(C)
# 					},
# 					valueClass = "fcudaMatrix"
# )
# 
# #' Double Precision CUDA Matrix Multiplication
# #' @param x An fcudaMatrix object
# #' @param y An fcudaMatrix object
# #' @export
# setMethod("%*%", signature(x="cudaMatrix", y = "cudaMatrix"),
# 					function(x,y)
# 					{
# 						if( dim(x)[2] != dim(y)[1]){
# 							stop("Non-conformant matrices")
# 						}
# 						
# 						if(!deviceHasDouble()){
# 							stop("Selected GPU does not support double precision")
# 						}else{
# 							C <- cudaMatrix(nrow=nrow(x), ncol=ncol(y), type="double")
# 							
# 							cpp_vienna_cudaMatrix_dgemm(x@address,
# 																					y@address,
# 																					C@address)
# 						}
# 						
# 						return(C)
# 					},
# 					valueClass = "dcudaMatrix"
# )