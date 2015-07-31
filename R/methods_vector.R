


#' @title Get cudaVector type
#' @param x A cudaVector object
#' @aliases typeof,cudaVector
#' @export
setMethod('typeof', signature(x="cudaVector"),
					function(x) {
						switch(class(x),
									 "icudaVector" = "integer",
									 "fcudaVector" = "float",
									 "dcudaVector" = "double")
					})

# #' @title Length of cudaVector
# #' @param x A cudaVector object
# #' @rdname length-methods
# #' @aliases length,cudaVector
# #' @export
# setMethod('length', signature(x = "cudaVector"),
# 					function(x) {
# 						switch(typeof(x),
# 									 "integer" = return(cpp_igpuVec_size(x@address)),
# 									 "float" = return(cpp_fgpuVec_size(x@address)),
# 									 "double" = return(cpp_dgpuVec_size(x@address))
# 						)
# 						
# 					}
# )