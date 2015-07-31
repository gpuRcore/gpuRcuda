
#' @title Get cudaMatrix type
#' @param x A cudaMatrix object
#' @aliases typeof,cudaMatrix
#' @export
setMethod('typeof', signature(x="cudaMatrix"),
					function(x) {
						switch(class(x),
									 "icudaMatrix" = "integer",
									 "fcudaMatrix" = "float",
									 "dcudaMatrix" = "double")
					})