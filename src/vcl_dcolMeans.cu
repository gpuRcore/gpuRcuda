
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
using Eigen::MatrixXd;
using Eigen::VectorXd;

extern "C"
void cu_vienna_dColMean(
    Map<MatrixXd> &Am, 
    Map<VectorXd> &colMeans)
{        
    int M = Am.cols();
    int K = Am.rows();
    int V = colMeans.size();
    
    viennacl::matrix<double> vcl_A(K,M, viennacl::context(viennacl::CUDA_MEMORY));
    viennacl::vector<double> vcl_colMeans(V, viennacl::context(viennacl::CUDA_MEMORY));
    
    viennacl::copy(Am, vcl_A); 
    
    vcl_colMeans = viennacl::linalg::column_sum(vcl_A);
    vcl_colMeans *= (double)(1)/(double)(K);
    
    viennacl::copy(vcl_colMeans, colMeans);
}
