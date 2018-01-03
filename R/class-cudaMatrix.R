#' @title cudaMatrix Class
#' @description This class refers to gpuRcuda matrix
#' objects that are on the device.
#' 
#' There are multiple child classes that correspond
#' to the particular data type contained.  These include
#' \code{icudaMatrix}, \code{fcudaMatrix}, and 
#' \code{dcudaMatrix} corresponding to integer, float, and
#' double data types respectively.
#' @section Slots:
#'  Common to all cudaMatrix objects in the package
#'  \describe{
#'      \item{\code{address}:}{An R matrix object}
#'  }
#' @note R does not contain a native float type.  As such,
#' the matrix data within a \code{\link{fcudaMatrix-class}} 
#' will be represented as double but downcast when any 
#' cudaMatrix methods are used.
#' 
#' May also remove the type slot
#' 
#' @name cudaMatrix-class
#' @rdname cudaMatrix-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{icudaMatrix-class}}, 
#' \code{\link{fcudaMatrix-class}},
#' \code{\link{dcudaMatrix-class}}
#' @include class.R
#' @export
setClass('cudaMatrix',
				 contains = "gpuRcudaMatrix")


# setClass('cudaMatrix', 
# 				 slots = c(address="externalptr"))


#' @title icudaMatrix Class
#' @description An integer type matrix in the S4 \code{cudaMatrix}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{A integer typed R matrix}
#'  }
#' @name icudaMatrix-class
#' @rdname icudaMatrix-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{cudaMatrix-class}}, 
#' \code{\link{icudaMatrix-class}},
#' \code{\link{dcudaMatrix-class}}
#' @export
setClass("icudaMatrix",
         contains = "cudaMatrix",
         validity = function(object) {
           if( typeof(object) != "integer"){
             return("icudaMatrix must be of type 'integer'")
           }
           TRUE
         })

#' @title fcudaMatrix Class
#' @description An integer type matrix in the S4 \code{cudaMatrix}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{A numeric R matrix.}
#'  }
#' @name fcudaMatrix-class
#' @rdname fcudaMatrix-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{cudaMatrix-class}}, 
#' \code{\link{icudaMatrix-class}},
#' \code{\link{dcudaMatrix-class}}
#' @export
setClass("fcudaMatrix",
         contains = "cudaMatrix")


#' @title dcudaMatrix Class
#' @description An integer type matrix in the S4 \code{cudaMatrix}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{A numeric R matrix}
#'  }
#' @name dcudaMatrix-class
#' @rdname dcudaMatrix-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{cudaMatrix-class}}, 
#' \code{\link{icudaMatrix-class}},
#' \code{\link{fcudaMatrix-class}}
#' @export
setClass("dcudaMatrix",
         contains = "cudaMatrix"
         )
