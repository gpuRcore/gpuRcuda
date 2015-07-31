
// eigen headers for handling the R input data
#include <RcppEigen.h>

#include "gpuR/eigen_helpers.hpp"

using namespace Rcpp;

extern "C" 
{
	void cu_vienna_sColMean(
			MapMat<float> Am, 
			MapVec<float> Cm);
	void cu_vienna_dColMean(
			MapMat<double> Am, 
			MapVec<double> Cm);
}

//[[Rcpp::export]]
void cpp_vienna_cudaMatrix_sColMean(SEXP ptrA_, SEXP ptrC_)
{    
		Rcpp::XPtr<dynEigen<float> > ptrA(ptrA_);
    Rcpp::XPtr<dynEigenVec<float> > ptrC(ptrC_);
    
    MapMat<float> Am(ptrA->ptr(), ptrA->nrow(), ptrA->ncol());
    MapVec<float> Cm(ptrC->ptr(), ptrC->length());
    
    cu_vienna_sColMean(Am, Cm);
}

//[[Rcpp::export]]
void cpp_vienna_cudaMatrix_dColMean(SEXP ptrA_, SEXP ptrC_)
{    
		Rcpp::XPtr<dynEigen<double> > ptrA(ptrA_);
    Rcpp::XPtr<dynEigenVec<double> > ptrC(ptrC_);
    
    MapMat<double> Am(ptrA->ptr(), ptrA->nrow(), ptrA->ncol());
    MapVec<double> Cm(ptrC->ptr(), ptrC->length());
    
    cu_vienna_dColMean(Am, Cm);
}
