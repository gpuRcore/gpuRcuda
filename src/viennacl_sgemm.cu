
// Use CUDA with ViennaCL
#define VIENNACL_WITH_CUDA 1

// Use ViennaCL algorithms on Eigen objects
#define VIENNACL_WITH_EIGEN 1

// ViennaCL headers
//#include "viennacl/ocl/device.hpp"
//#include "viennacl/ocl/platform.hpp"
#include "viennacl/matrix.hpp"
#include "viennacl/linalg/prod.hpp"


// eigen headers for handling the R input data
//#include <RcppEigen.h>
// Eigen headers
#include <Eigen/Core>
#include <Eigen/Sparse>

//using Eigen::Map;
using Eigen::MatrixXf;

inline
Eigen::MatrixXf cu_vienna_cudaMatrix_sgemm(const MatrixXf Am, const MatrixXf Bm)
{      
    int M = Am.cols();
    int K = Am.rows();
    int N = Bm.rows();
    int P = Bm.cols();
    
    viennacl::matrix<float> vcl_A(K,M);
    viennacl::matrix<float> vcl_B(N,P);
    viennacl::matrix<float> vcl_C(K,P);
    
    MatrixXf Cm(K, P);
    
    viennacl::copy(Am, vcl_A); 
    viennacl::copy(Bm, vcl_B); 
    
    vcl_C = viennacl::linalg::prod(vcl_A, vcl_B);
    
    viennacl::copy(vcl_C, Cm);
    
    return Cm;
}
