
#include "gpuRcuda/thrust_matrix.hpp"
#include "gpuRcuda/thrust_vector.hpp"

using namespace Rcpp;

template <typename T>
int cpp_length(SEXP ptrA_)
{
	Rcpp::XPtr<thrust_vector<T> > ptrA(ptrA_);
	return ptrA->size();
}

template <typename T>
int cpp_ncol(SEXP ptrA_)
{
    Rcpp::XPtr<thrust_matrix<T> > ptrA(ptrA_);
    return ptrA->ncol();
}

template <typename T>
int cpp_nrow(SEXP ptrA_)
{
    Rcpp::XPtr<thrust_matrix<T> > ptrA(ptrA_);
    return ptrA->nrow();
}

// [[Rcpp::export]]
int cpp_length(SEXP ptrA, const int type_flag)
{
	switch(type_flag){
	case 4:
		return cpp_length<int>(ptrA);
	case 6:
		// return cpp_length(ptrA);
	case 8:
		return cpp_length<double>(ptrA);
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}

// [[Rcpp::export]]
int cpp_ncol(SEXP ptrA, const int type_flag)
{
	switch(type_flag){
		case 4:
			return cpp_ncol<int>(ptrA);
		case 6:
			// return cpp_ncol(ptrA);
		case 8:
			return cpp_ncol<double>(ptrA);
		default:
				throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}

// [[Rcpp::export]]
int cpp_nrow(SEXP ptrA, const int type_flag)
{
	switch(type_flag){
		case 4:
			return cpp_nrow<int>(ptrA);
		case 6:
			// return cpp_nrow(ptrA);
		case 8:
			return cpp_nrow<double>(ptrA);
		default:
			throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}

