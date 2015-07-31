
// system headers
#include <iostream>

// Eigen headers
#include <Eigen/Core>

// Use CUDA with ViennaCL
#define VIENNACL_WITH_CUDA 1

// Use ViennaCL algorithms on Eigen objects
#define VIENNACL_WITH_EIGEN 1

// ViennaCL headers
#include "viennacl/matrix.hpp"
#include "viennacl/linalg/prod.hpp"

using Eigen::Map;
using Eigen::MatrixXf;


extern "C"
void cu_vienna_cudaMatrix_sgemm(
		Map<MatrixXf> &Am, 
		Map<MatrixXf> &Bm,
		Map<MatrixXf> &Cm)
{      
    int M = Am.cols();
    int K = Am.rows();
    int N = Bm.rows();
    int P = Bm.cols();

		// Currently must pass CUDA memory manually (conflicts with prior OpenCL)
    viennacl::matrix<float> vcl_A(K,M, viennacl::context(viennacl::CUDA_MEMORY));
    viennacl::matrix<float> vcl_B(N,P, viennacl::context(viennacl::CUDA_MEMORY));
    viennacl::matrix<float> vcl_C(K,P, viennacl::context(viennacl::CUDA_MEMORY));
    
    viennacl::copy(Am, vcl_A); 
    viennacl::copy(Bm, vcl_B); 
    
    vcl_C = viennacl::linalg::prod(vcl_A, vcl_B);

    viennacl::copy(vcl_C, Cm);
}
