
// Use CUDA with ViennaCL
//#define VIENNACL_WITH_CUDA 1
//
//// ViennaCL headers
////#include "viennacl/ocl/device.hpp"
////#include "viennacl/ocl/platform.hpp"
//#include "viennacl/matrix.hpp"
//#include "viennacl/linalg/prod.hpp"

// CUDA header for cuda functions
//#include <cuda.h>

// eigen headers for handling the R input data
#include <RcppEigen.h>

using namespace Rcpp;
using Eigen::Map;
using Eigen::MatrixXf;

extern "C" 
MatrixXf cu_vienna_cudaMatrix_sgemm(MatrixXf Am, MatrixXf Bm);

//[[Rcpp::export]]
SEXP cpp_vienna_cudaMatrix_sgemm(SEXP A_, SEXP B_)
{    

    MatrixXf Am = as<MatrixXf>(A_);
    MatrixXf Bm = as<MatrixXf>(B_);
    
    MatrixXf Cm = cu_vienna_cudaMatrix_sgemm(Am, Bm);
    
    return wrap(Cm);
}
