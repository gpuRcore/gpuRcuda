
// eigen headers for handling the R input data
#include <RcppEigen.h>
//#include <Eigen/Core>

using namespace Rcpp;
using Eigen::MatrixXf;
using Eigen::MatrixXd;

extern "C" 
{
	MatrixXf cu_vienna_cudaMatrix_sgemm(MatrixXf Am, MatrixXf Bm);
	MatrixXd cu_vienna_cudaMatrix_dgemm(MatrixXd Am, MatrixXd Bm);
}

//[[Rcpp::export]]
SEXP cpp_vienna_cudaMatrix_sgemm(SEXP A_, SEXP B_)
{    

    MatrixXf Am = as<MatrixXf>(A_);
    MatrixXf Bm = as<MatrixXf>(B_);
    
    MatrixXf Cm = cu_vienna_cudaMatrix_sgemm(Am, Bm);
    
    return wrap(Cm);
}

//[[Rcpp::export]]
SEXP cpp_vienna_cudaMatrix_dgemm(SEXP A_, SEXP B_)
{    

    MatrixXd Am = as<MatrixXd>(A_);
    MatrixXd Bm = as<MatrixXd>(B_);
    
    MatrixXd Cm = cu_vienna_cudaMatrix_dgemm(Am, Bm);
    
    return wrap(Cm);
}
