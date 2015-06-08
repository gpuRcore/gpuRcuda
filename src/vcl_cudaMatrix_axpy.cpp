
// eigen headers for handling the R input data
#include <RcppEigen.h>
//#include <Eigen/Core>

using namespace Rcpp;
using Eigen::MatrixXf;
using Eigen::MatrixXd;

extern "C" 
{
	MatrixXf cu_vienna_cudaMatrix_saxpy(float alpha, MatrixXf Am, MatrixXf Bm);
	MatrixXd cu_vienna_cudaMatrix_daxpy(double alpha, MatrixXd Am, MatrixXd Bm);
}

//[[Rcpp::export]]
SEXP cpp_vienna_cudaMatrix_saxpy(SEXP alpha_, SEXP A_, SEXP B_)
{    
		float alpha = as<float>(alpha_);
    MatrixXf Am = as<MatrixXf>(A_);
    MatrixXf Bm = as<MatrixXf>(B_);
    
    MatrixXf Cm = cu_vienna_cudaMatrix_saxpy(alpha, Am, Bm);
    
    return wrap(Cm);
}

//[[Rcpp::export]]
SEXP cpp_vienna_cudaMatrix_daxpy(SEXP alpha_, SEXP A_, SEXP B_)
{    
		double alpha = as<double>(alpha_);
    MatrixXd Am = as<MatrixXd>(A_);
    MatrixXd Bm = as<MatrixXd>(B_);
    
    MatrixXd Cm = cu_vienna_cudaMatrix_daxpy(alpha, Am, Bm);
    
    return wrap(Cm);
}
