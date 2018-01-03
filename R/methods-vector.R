
#' @title Length of gpuRcudaVector
#' @param x A gpuRcudaVector object
#' @docType methods
#' @rdname length-methods
#' @aliases length,nvVector
#' @aliases length,cudaVector
#' @author Charles Determan Jr.
#' @export
setMethod('length', signature(x = "gpuRcudaVector"),
					function(x) {
						switch(typeof(x),
									 "integer" = return(cpp_length(x@address, 4L)),
									 "float" = return(cpp_length(x@address, 6L)),
									 "double" = return(cpp_length(x@address, 8L))
						)
						
					}
)