.onLoad <- function(libname, pkgname) {
	options(gpuRcuda.print.warning=TRUE)
	options(gpuRcuda.default.type = "double")
}