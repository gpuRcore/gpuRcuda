
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

typedef Eigen::Map<Eigen::Matrix<float, Eigen::Dynamic, Eigen::Dynamic> > MapMatf;

extern "C"
void cu_vienna_cudaMatrix_saxpy(
		float alpha, 
		MapMatf &Am, 
		MapMatf &Bm)
{      
    int M = Am.cols();
    int K = Am.rows();
    int N = Bm.rows();
    int P = Bm.cols();

		// Currently must pass CUDA memory manually (conflicts with prior OpenCL)
    viennacl::matrix<float> vcl_A(K,M, viennacl::context(viennacl::CUDA_MEMORY));
    viennacl::matrix<float> vcl_B(N,P, viennacl::context(viennacl::CUDA_MEMORY));
    
		// How the calls should look
    //viennacl::matrix<float> vcl_A(K,M);
    //viennacl::matrix<float> vcl_B(N,P);

    //std::cout << "Created VCL Matrices" << std::endl;
    
    viennacl::copy(Am, vcl_A); 
    viennacl::copy(Bm, vcl_B); 

    //std::cout << "Moved data to the GPU" << std::endl;
    
    vcl_A += alpha * vcl_B;

    //std::cout << "Completed Matrix Mult on GPU" << std::endl;
    
    viennacl::copy(vcl_A, Am);
    
    //std::cout << "Pulled new data to CPU" << std::endl;
}
