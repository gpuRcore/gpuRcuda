
#' @useDynLib gpuRcuda
#' @importFrom Rcpp evalCpp

#' @title CUDA GPU Matrix Multiplication
#' @description matrix multiplication
#' @param A A cudaMatrix object
#' @param B A cudaMatrix object
#' @return A cudaMatrix object
#' @author Charles Determan Jr.
#' @importFrom gpuR deviceHasDouble
cudaMatMult <- function(A, B){
  
  #pkg_path <- find.package("gpuR", .libPaths())
  #file <- file.path(pkg_path, "CL", "basic_gemm.cl")
  
#   if(!file_test("-f", file)){
#     stop("kernel file does not exist")
#   }
#   kernel <- readChar(file, file.info(file)$size)
#   
  type <- typeof(A)
  
  out <- switch(type,
                integer = {
                  stop("integer not yet implemented")
#                   new("icudaMatrix", 
#                       x=cpp_cudaMatrix_igemm(A@x,B@x, kernel, "iMatMult"),
#                       type="integer"
#                   )
                },
                float = {
                  stop("float not yet implemented")
#                   new("fcudaMatrix", 
#                       x=cpp_cudaMatrix_sgemm(A@x,B@x),
#                       type="float"
#                   )
                },
                double = {
                  if(!deviceHasDouble()){
                    stop("Selected GPU does not support double precision")
                  }else{
                    new("dcudaMatrix", 
                        x=cpp_cudaMatrix_dgemm(A@x,B@x),
                        type="double"
                    )
                  }
                },
                {
                  stop("type not recognized")
                })
return(out)
}