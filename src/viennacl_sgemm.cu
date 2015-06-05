
// system headers
#include <iostream>

// Eigen headers
#include <Eigen/Core>
#include <Eigen/Sparse>

// Use CUDA with ViennaCL
#define VIENNACL_WITH_CUDA 1

// Use ViennaCL algorithms on Eigen objects
#define VIENNACL_WITH_EIGEN 1

// ViennaCL headers
#include "viennacl/matrix.hpp"
#include "viennacl/linalg/prod.hpp"

//using Eigen::Map;
using Eigen::MatrixXf;

extern "C"
Eigen::MatrixXf cu_vienna_cudaMatrix_sgemm(MatrixXf Am, MatrixXf Bm)
{      
    int M = Am.cols();
    int K = Am.rows();
    int N = Bm.rows();
    int P = Bm.cols();

    std::cout << "Number of Cols in A:" << M << std::endl;
    
    viennacl::matrix<float> vcl_A(K,M);
    viennacl::matrix<float> vcl_B(N,P);
    viennacl::matrix<float> vcl_C(K,P);

    std::cout << "Created VCL Matrices" << std::endl;
    
    MatrixXf Cm(K, P);
    
    viennacl::copy(Am, vcl_A); 
    viennacl::copy(Bm, vcl_B); 

    std::cout << "Moved data to the GPU" << std::endl;
    
    vcl_C = viennacl::linalg::prod(vcl_A, vcl_B);

    std::cout << "Completed Matrix Mult on GPU" << std::endl;
    
    viennacl::copy(vcl_C, Cm);
    
    std::cout << "Pulled new data to CPU" << std::endl;

    return Cm;
}
