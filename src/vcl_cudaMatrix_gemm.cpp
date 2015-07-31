
// eigen headers for handling the R input data
#include <RcppEigen.h>

#include <gpuR/eigen_helpers.hpp>

using namespace Rcpp;

extern "C" 
{
	void cu_vienna_cudaMatrix_sgemm(
			MapMat<float> &Am, 
			MapMat<float> &Bm,
			MapMat<float> &Cm);
	void cu_vienna_cudaMatrix_dgemm(
			MapMat<double> &Am, 
			MapMat<double> &Bm,
			MapMat<double> &Cm);
}

//[[Rcpp::export]]
void cpp_vienna_cudaMatrix_sgemm(SEXP ptrA_, SEXP ptrB_, SEXP ptrC_)
{    
    Rcpp::XPtr<dynEigen<float> > ptrA(ptrA_);
    Rcpp::XPtr<dynEigen<float> > ptrB(ptrB_);
    Rcpp::XPtr<dynEigen<float> > ptrC(ptrC_);
    
    MapMat<float> Am(ptrA->ptr(), ptrA->nrow(), ptrA->ncol());
    MapMat<float> Bm(ptrB->ptr(), ptrB->nrow(), ptrB->ncol());
    MapMat<float> Cm(ptrC->ptr(), ptrC->nrow(), ptrC->ncol());
    
    cu_vienna_cudaMatrix_sgemm(Am, Bm, Cm);
}

//[[Rcpp::export]]
void cpp_vienna_cudaMatrix_dgemm(SEXP ptrA_, SEXP ptrB_, SEXP ptrC_)
{    
		Rcpp::XPtr<dynEigen<double> > ptrA(ptrA_);
    Rcpp::XPtr<dynEigen<double> > ptrB(ptrB_);
    Rcpp::XPtr<dynEigen<double> > ptrC(ptrC_);
    
    MapMat<double> Am(ptrA->ptr(), ptrA->nrow(), ptrA->ncol());
    MapMat<double> Bm(ptrB->ptr(), ptrB->nrow(), ptrB->ncol());
    MapMat<double> Cm(ptrC->ptr(), ptrC->nrow(), ptrC->ncol());
    
    cu_vienna_cudaMatrix_dgemm(Am, Bm, Cm);
}
