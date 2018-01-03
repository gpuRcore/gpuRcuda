
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

#' @title The Number of Rows/Columns of a gpuRcudaMatrix
#' @description \code{nrow} and \code{ncol} return the number of rows
#' or columns present in \code{x}.
#' @param x A gpuRcudaMatrix object
#' @return An integer of length 1
#' @docType methods
#' @rdname nrow-gpuRcudaMatrix
#' @aliases nrow,cudaMatrix
#' @aliases nrow,nvMatrix
#' @aliases ncol,cudaMatrix
#' @aliases ncol,nvMatrix
#' @author Charles Determan Jr.
#' @export
setMethod('nrow', signature(x="gpuRcudaMatrix"), 
					function(x) {
						switch(typeof(x),
									 "integer" = return(cpp_nrow(x@address, 4L)),
									 "float" = return(cpp_nrow(x@address, 6L)),
									 "double" = return(cpp_nrow(x@address, 8L))
						)
					}
)

#' @rdname nrow-gpuRcudaMatrix
#' @export
setMethod('ncol', signature(x="gpuRcudaMatrix"),
					function(x) {
						switch(typeof(x),
									 "integer" = return(cpp_ncol(x@address, 4L)),
									 "float" = return(cpp_ncol(x@address, 6L)),
									 "double" = return(cpp_ncol(x@address, 8L))
						)
					}
)


#' @title gpuRcuda dim method
#' @param x A gpuRcuda matrix object
#' @return A length 2 vector of the number of rows and columns respectively.
#' @docType methods
#' @rdname dim-methods
#' @author Charles Determan Jr.
#' @aliases dim,cudaMatrix
#' @aliases dim,nvMatrix
#' @export
setMethod('dim', signature(x="gpuRcudaMatrix"),
					function(x) return(c(nrow(x), ncol(x))))

#' @title Extract gpuRcuda elements
#' @param x A gpuRcuda object
#' @param i missing
#' @param j missing
#' @param drop missing
#' @docType methods
#' @rdname extract-methods
#' @author Charles Determan Jr.
#' @export
setMethod("[",
					signature(x = "cudaMatrix", i = "missing", j = "missing", drop = "missing"),
					function(x, i, j, drop) {
						
						init <- ifelse(typeof(x) == "double", 0, 0L)
						out <- matrix(init, nrow = nrow(x), ncol = ncol(x))
						
						switch(typeof(x),
									 "integer" = {
									 		cudaMatToSEXP(x@address, out, 4L)
									 		return(out)
									 },
									 "float" = {
									 		cudaMatToSEXP(x@address, out, 6L)
									 		return(out)
									 },
									 "double" = {
									 		cudaMatToSEXP(x@address, out, 8L)
									 		return(out)
									 }
						)
					})

#' @rdname extract-methods
#' @export
setMethod("[",
					signature(x = "nvMatrix", i = "missing", j = "missing", drop = "missing"),
					function(x, i, j, drop) {
						
						init <- ifelse(typeof(x) == "double", 0, 0L)
						out <- matrix(init, nrow = nrow(x), ncol = ncol(x))
						
						switch(typeof(x),
									 "integer" = {
									 		nvMatToSEXP(x@address, out, 4L)
										 	return(out)
									 	},
									 "float" = {
									 		nvMatToSEXP(x@address, out, 6L)
										 	return(out)
									 	},
									 "double" = {
									 		nvMatToSEXP(x@address, out, 8L)
									 		return(out)
									 }
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