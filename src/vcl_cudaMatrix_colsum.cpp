
// eigen headers for handling the R input data
#include <RcppEigen.h>

#include "gpuR/eigen_helpers.hpp"

using namespace Rcpp;

extern "C" 
{
	void cu_vienna_scolsum(
			MapMat<float> Am, 
			MapVec<float> Cm);
	void cu_vienna_dcolsum(
			MapMat<double> Am, 
			MapVec<double> Cm);
}

//[[Rcpp::export]]
void cpp_vienna_cudaMatrix_scolsum(SEXP ptrA_, SEXP ptrC_)
{    
		Rcpp::XPtr<dynEigen<float> > ptrA(ptrA_);
    Rcpp::XPtr<dynEigenVec<float> > ptrC(ptrC_);
    
    MapMat<float> Am(ptrA->ptr(), ptrA->nrow(), ptrA->ncol());
    MapVec<float> Cm(ptrC->ptr(), ptrC->length());
    
    cu_vienna_scolsum(Am, Cm);
}

//[[Rcpp::export]]
void cpp_vienna_cudaMatrix_dcolsum(SEXP ptrA_, SEXP ptrC_)
{    
		Rcpp::XPtr<dynEigen<double> > ptrA(ptrA_);
    Rcpp::XPtr<dynEigenVec<double> > ptrC(ptrC_);
    
    MapMat<double> Am(ptrA->ptr(), ptrA->nrow(), ptrA->ncol());
    MapVec<double> Cm(ptrC->ptr(), ptrC->length());
    
    cu_vienna_dcolsum(Am, Cm);
}
