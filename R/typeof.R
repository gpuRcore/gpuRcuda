
#' @title Get gpuRcudaMatrix type
#' @param x A gpuRcudaMatrix object
#' @aliases typeof,cudaMatrix
#' @aliases typeof,nvMatrix
#' @author Charles Determan Jr.
#' @rdname typeof
#' @export
setMethod('typeof', signature(x="gpuRcudaMatrix"),
					function(x) {
						switch(class(x),
									 "icudaMatrix" = "integer",
									 "fcudaMatrix" = "float",
									 "dcudaMatrix" = "double",
									 "invMatrix" = "integer",
									 "fnvMatrix" = "float",
									 "dnvMatrix" = "double")
					})

#' @title Get gpuRcudaVector type
#' @param x A gpuRcudaVector object
#' @aliases typeof,cudaVector
#' @aliases typeof,nvVector
#' @author Charles Determan Jr.
#' @rdname typeof
#' @export
setMethod('typeof', signature(x="gpuRcudaVector"),
					function(x) {
						switch(class(x),
									 "icudaVector" = "integer",
									 "fcudaVector" = "float",
									 "dcudaVector" = "double",
									 "invVector" = "integer",
									 "fnvVector" = "float",
									 "dnvVector" = "double")
					})

