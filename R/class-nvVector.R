# The primary class for all nvVector objects

#' @title nvVector Class
#' @description This is the 'mother' class for all
#' nvVector objects.  All other nvVector classes
#' inherit from this class but there are no current
#' circumstances where this class is used directly.
#' 
#' There are multiple child classes that correspond
#' to the particular data type contained.  These include
#' \code{invVector}.
#' @name nvVector-class
#' @rdname nvVector-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{invVector-class}}
#' @include class.R
#' @export
setClass('nvVector', 
				 contains = 'gpuRcudaVector')


#' @title invVector Class
#' @description An integer vector in the S4 \code{nvVector}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{An integer vector object}
#'  }
#' @name invVector-class
#' @rdname invVector-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{nvVector-class}}
#' @export
setClass("invVector",
				 contains = "nvVector")


#' @title fnvVector Class
#' @description An float vector in the S4 \code{nvVector}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{Pointer to a float typed vector}
#'  }
#' @name fnvVector-class
#' @rdname fnvVector-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{nvVector-class}}
#' @export
setClass("fnvVector",
				 contains = "nvVector")


#' @title dnvVector Class
#' @description An double vector in the S4 \code{nvVector}
#' representation.
#' @section Slots:
#'  \describe{
#'      \item{\code{address}:}{Pointer to a double typed vector}
#'  }
#' @name dnvVector-class
#' @rdname dnvVector-class
#' @author Charles Determan Jr.
#' @seealso \code{\link{nvVector-class}}
#' @export
setClass("dnvVector",
				 contains = "nvVector")
