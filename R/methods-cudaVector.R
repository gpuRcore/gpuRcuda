


#' @rdname extract-methods
#' @export
setMethod("[",
					signature(x = "cudaVector", i = "missing", j = "missing", drop = "missing"),
					function(x, i, j, drop) {
						
						init <- ifelse(typeof(x) == "double", 0, 0L)
						out <- rep(init, length(x))
						
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
