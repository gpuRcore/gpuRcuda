#' @useDynLib gpuRcuda
#' @importFrom Rcpp evalCpp
#' @import methods
NULL

# cuda_colSums <- function(A){
# 	
# 	type <- typeof(A)
# 	
# 	if(type == "integer"){
# 		stop("integer type not currently implemented")
# 	}
# 	
# 	sums <- cudaVector(length = ncol(A), type = type)
# 	
# 	switch(type,
# 				 "integer" = stop("integer type not currently implemented"),
# 				 "float" = cpp_vienna_cudaMatrix_scolsum(A@address, sums@address),
# 				 "double" = cpp_vienna_cudaMatrix_dcolsum(A@address, sums@address)
# 	)
# 	
# 	return(sums)
# }
# 
# cuda_rowSums <- function(A){
# 	
# 	type <- typeof(A)
# 	
# 	if(type == "integer"){
# 		stop("integer type not currently implemented")
# 	}
# 	
# 	sums <- cudaVector(length = nrow(A), type = type)
# 	
# 	switch(type,
# 				 "integer" = stop("integer type not currently implemented"),
# 				 "float" = cpp_vienna_cudaMatrix_sRowSum(A@address, sums@address),
# 				 "double" = cpp_vienna_cudaMatrix_dRowSum(A@address, sums@address)
# 	)
# 	
# 	return(sums)
# }
# 
# 
# cuda_colMeans <- function(A){
# 	
# 	type <- typeof(A)
# 	
# 	if(type == "integer"){
# 		stop("integer type not currently implemented")
# 	}
# 	
# 	means <- cudaVector(length = ncol(A), type = type)
# 	
# 	switch(type,
# 				 "integer" = stop("integer type not currently implemented"),
# 				 "float" = cpp_vienna_cudaMatrix_sColMean(A@address, means@address),
# 				 "double" = cpp_vienna_cudaMatrix_dColMean(A@address, means@address)
# 	)
# 	
# 	return(means)
# }
# 
# cuda_rowMeans <- function(A){
# 	
# 	type <- typeof(A)
# 	
# 	if(type == "integer"){
# 		stop("integer type not currently implemented")
# 	}
# 	
# 	means <- cudaVector(length = nrow(A), type = type)
# 	
# 	switch(type,
# 				 "integer" = stop("integer type not currently implemented"),
# 				 "float" = cpp_vienna_cudaMatrix_sRowMean(A@address, means@address),
# 				 "double" = cpp_vienna_cudaMatrix_dRowMean(A@address, means@address)
# 	)
# 	
# 	return(means)
# }
# 
# # Matrix Multiplication
# gpu_Mat_mult <- function(A, B){
# 	
# 	type <- typeof(A)
# 	
# 	C <- cudaMatrix(nrow=nrow(A), ncol=ncol(B), type=type)
# 	
# 	switch(type,
# 				 integer = {stop("integer not currently implemented")},
# 				 float = {cpp_vienna_cudaMatrix_sgemm(A@address,
# 				 																		B@address,
# 				 																		C@address)
# 				 },
# 				 double = {
# 				 	if(!deviceHasDouble()){
# 				 		stop("Selected GPU does not support double precision")
# 				 	}else{cpp_vienna_cudaMatrix_dgemm(A@address,
# 				 																	 B@address,
# 				 																	 C@address)
# 				 	}
# 				 },
# 				{
# 					stop("type not recognized")
# 				})
# 	
# 	return(C)
# }
