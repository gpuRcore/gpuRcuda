#' @title gpuRcudaMatrix Class
#' @description This is the 'mother' class for all
#' gpuRcudaMatrix objects.  It is essentially a wrapper for
#' a basic R matrix (possibly to be improved).  All other 
#' gpuRcuda classes inherit from this class but 
#' there are no current circumstances where this class 
#' is used directly.
#' 
#' @section Slots:
#'  Common to all gpuRcuda objects in the package
#'  \describe{
#'      \item{\code{address}:}{An R matrix object}
#'  }
#' @note R does not contain a native float type.  As such,
#' the matrix data within a such an object 
#' will be represented as double but downcast when any 
#' gpuRcuda methods are used.
#' 
#' May also remove the type slot
#' 
#' @name gpuRcudaMatrix-class
#' @rdname gpuRcudaMatrix-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{nvMatrix-class}}, 
#' \code{\link{cudaMatrix-class}}
#' @export
setClass('gpuRcudaMatrix',
				 slots = c(address = "externalptr"))


#' @title gpuRcudaVector Class
#' @description This is the 'mother' class for all
#' gpuRcudaVector objects.  It is essentially a wrapper for
#' a basic R vector (possibly to be improved).  All other 
#' gpuRcuda classes inherit from this class but 
#' there are no current circumstances where this class 
#' is used directly.
#' 
#' @section Slots:
#'  Common to all gpuRcuda objects in the package
#'  \describe{
#'      \item{\code{address}:}{An R vector object}
#'  }
#' @note R does not contain a native float type.  As such,
#' the vector data within a such an object 
#' will be represented as double but downcast when any 
#' gpuRcuda methods are used.
#' 
#' May also remove the type slot
#' 
#' @name gpuRcudaVector-class
#' @rdname gpuRcudaVector-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{nvVector-class}}, 
#' \code{\link{cudaVector-class}}
#' @export
setClass('gpuRcudaVector',
				 slots = c(address = "externalptr"))
