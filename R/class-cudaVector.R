# The primary class for all cudaVector objects

#' @title cudaVector Class
#' @description This is the 'mother' class for all
#' cudaVector objects.  All other cudaVector classes
#' inherit from this class but there are no current
#' circumstances where this class is used directly.
#' 
#' There are multiple child classes that correspond
#' to the particular data type contained.  These include
#' \code{icudaVector}.
#' @name cudaVector-class
#' @rdname cudaVector-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{icudaVector-class}}
#' @include class.R
#' @export
setClass('cudaVector', 
				 contains = 'gpuRcudaVector')
# setClass('cudaVector', 
# 				 slots = c(address="externalptr"))

# setClass('cudaVector',
#          representation("VIRTUAL"),
#          validity = function(object) {
#              if( !length(object@object) > 0 ){
#                  return("cudaVector must be a length greater than 0")
#              }
#              TRUE
#          })


#' @title icudaVector Class
#' @description An integer vector in the S4 \code{cudaVector}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{An integer vector object}
#'  }
#' @name icudaVector-class
#' @rdname icudaVector-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{cudaVector-class}}
#' @export
setClass("icudaVector",
				 contains = "cudaVector")


#' @title fcudaVector Class
#' @description An float vector in the S4 \code{cudaVector}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{Pointer to a float typed vector}
#'  }
#' @name fcudaVector-class
#' @rdname fcudaVector-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{cudaVector-class}}
#' @export
setClass("fcudaVector",
				 contains = "cudaVector")


#' @title dcudaVector Class
#' @description An double vector in the S4 \code{cudaVector}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{Pointer to a double typed vector}
#'  }
#' @name dcudaVector-class
#' @rdname dcudaVector-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{cudaVector-class}}
#' @export
setClass("dcudaVector",
				 contains = "cudaVector")
