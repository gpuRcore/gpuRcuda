#' @title nvMatrix Class
#' @description This class refers to gpuRcuda matrix
#' objects that are on the host.
#' 
#' There are multiple child classes that correspond
#' to the particular data type contained.  These include
#' \code{invMatrix}, \code{fnvMatrix}, and 
#' \code{dnvMatrix} corresponding to integer, float, and
#' double data types respectively.
#' @section Slots:
#'  Common to all nvMatrix objects in the package
#'  \describe{
#'      \item{\code{address}:}{An R matrix object}
#'  }
#' 
#' @name nvMatrix-class
#' @rdname nvMatrix-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{invMatrix-class}}, 
#' \code{\link{fnvMatrix-class}},
#' \code{\link{dnvMatrix-class}}
#' @include class.R
#' @export
setClass('nvMatrix',
				 contains = "gpuRcudaMatrix")


# setClass('nvMatrix', 
# 				 slots = c(address="externalptr"))


#' @title invMatrix Class
#' @description An integer type matrix in the S4 \code{nvMatrix}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{A integer typed R matrix}
#'  }
#' @name invMatrix-class
#' @rdname invMatrix-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{nvMatrix-class}}, 
#' \code{\link{invMatrix-class}},
#' \code{\link{dnvMatrix-class}}
#' @export
setClass("invMatrix",
				 contains = "nvMatrix",
				 validity = function(object) {
				 	if( typeof(object) != "integer"){
				 		return("invMatrix must be of type 'integer'")
				 	}
				 	TRUE
				 })

#' @title fnvMatrix Class
#' @description An integer type matrix in the S4 \code{nvMatrix}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{A numeric R matrix.}
#'  }
#' @name fnvMatrix-class
#' @rdname fnvMatrix-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{nvMatrix-class}}, 
#' \code{\link{invMatrix-class}},
#' \code{\link{dnvMatrix-class}}
#' @export
setClass("fnvMatrix",
				 contains = "nvMatrix")


#' @title dnvMatrix Class
#' @description An integer type matrix in the S4 \code{nvMatrix}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{A numeric R matrix}
#'  }
#' @name dnvMatrix-class
#' @rdname dnvMatrix-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{nvMatrix-class}}, 
#' \code{\link{invMatrix-class}},
#' \code{\link{fnvMatrix-class}}
#' @export
setClass("dnvMatrix",
				 contains = "nvMatrix"
)
