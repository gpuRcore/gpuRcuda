
// system headers
#include <iostream>

// Eigen headers
#include <Eigen/Core>

// Use CUDA with ViennaCL
#define VIENNACL_WITH_CUDA 1

// Use Eigen with ViennaCL
#define VIENNACL_WITH_EIGEN 1

// ViennaCL headers
#include "viennacl/matrix.hpp"
#include "viennacl/linalg/sum.hpp"

using Eigen::Map;
using Eigen::MatrixXf;
using Eigen::VectorXf;

extern "C"
void cu_vienna_scolsum(
    Map<MatrixXf> &Am, 
    Map<VectorXf> &colSums)
{        
    int M = Am.cols();
    int K = Am.rows();
    int V = colSums.size();
    
    viennacl::matrix<float> vcl_A(K,M, viennacl::context(viennacl::CUDA_MEMORY));
    viennacl::vector<float> vcl_colSums(V, viennacl::context(viennacl::CUDA_MEMORY));
    
    viennacl::copy(Am, vcl_A); 
    
    vcl_colSums = viennacl::linalg::column_sum(vcl_A);
    
    viennacl::copy(vcl_colSums, colSums);
}
