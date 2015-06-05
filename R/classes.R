#' @title cudaMatrix Class
#' @description This is the 'mother' class for all
#' cudaMatrix objects.  It is essentially a wrapper for
#' a basic R matrix (possibly to be improved).  All other 
#' cudaMatrix classes inherit from this class but 
#' there are no current circumstances where this class 
#' is used directly.
#' 
#' There are multiple child classes that correspond
#' to the particular data type contained.  These include
#' \code{icudaMatrix}, \code{fcudaMatrix}, and 
#' \code{dcudaMatrix} corresponding to integer, float, and
#' double data types respectively.
#' @section Slots:
#'  Common to all cudaMatrix objects in the package
#'  \describe{
#'      \item{\code{x}:}{An R matrix object}
#'      \item{\code{type}:}{Character object specifying
#'      the type the matrix data will be interpreted as}
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
#' @importClassesFrom gpuR gpuMatrix
#' @export
setClass('cudaMatrix', 
         contains = 'gpuMatrix')

#' @title icudaMatrix Class
#' @description An integer type matrix in the S4 \code{cudaMatrix}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{x}:}{A integer typed R matrix}
#'      \item{\code{type}:}{Character object specifying
#'      the type the matrix data is integer}
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
#'      \item{\code{x}:}{A numeric R matrix.}
#'      \item{\code{type}:}{Character object specifying
#'      the type the matrix data is intepreted as float}
#'  }
#' @name fcudaMatrix-class
#' @rdname fcudaMatrix-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{cudaMatrix-class}}, 
#' \code{\link{icudaMatrix-class}},
#' \code{\link{dcudaMatrix-class}}
#' @export
setClass("fcudaMatrix",
         contains = "cudaMatrix",
         validity = function(object) {
           if( typeof(object) != "float"){
             return("fcudaMatrix must be of type 'float'")
           }
           TRUE
         })


#' @title dcudaMatrix Class
#' @description An integer type matrix in the S4 \code{cudaMatrix}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{x}:}{A numeric R matrix}
#'      \item{\code{type}:}{Character object specifying
#'      the type the matrix data is double}
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
