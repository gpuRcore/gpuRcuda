
// eigen headers for handling the R input data
#include <RcppEigen.h>

// header from gpuR for eigen matrix pointers
#include <gpuR/eigen_helpers.hpp>

using namespace Rcpp;

extern "C" 
{
	void cu_vienna_cudaMatrix_saxpy(
			float alpha, 
			MapMat<float> Am, 
			MapMat<float> Bm);
	void cu_vienna_cudaMatrix_daxpy(
			double alpha, 
			MapMat<double> Am, 
			MapMat<double> Bm);
}

//[[Rcpp::export]]
void cpp_vienna_cudaMatrix_saxpy(SEXP alpha_, SEXP ptrA_, SEXP ptrB_)
{    
		float alpha = as<float>(alpha_);
    
		Rcpp::XPtr<dynEigen<float> > ptrA(ptrA_);
    Rcpp::XPtr<dynEigen<float> > ptrB(ptrB_);
    
    MapMat<float> Am(ptrA->ptr(), ptrA->nrow(), ptrA->ncol());
    MapMat<float> Bm(ptrB->ptr(), ptrB->nrow(), ptrB->ncol());
    
    cu_vienna_cudaMatrix_saxpy(alpha, Am, Bm);
}

//[[Rcpp::export]]
void cpp_vienna_cudaMatrix_daxpy(SEXP alpha_, SEXP ptrA_, SEXP ptrB_)
{    
		double alpha = as<double>(alpha_);

		Rcpp::XPtr<dynEigen<double> > ptrA(ptrA_);
    Rcpp::XPtr<dynEigen<double> > ptrB(ptrB_);
    
    MapMat<double> Am(ptrA->ptr(), ptrA->nrow(), ptrA->ncol());
    MapMat<double> Bm(ptrB->ptr(), ptrB->nrow(), ptrB->ncol());
    
    cu_vienna_cudaMatrix_daxpy(alpha, Am, Bm);
}
