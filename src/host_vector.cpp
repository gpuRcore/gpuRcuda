

#include "gpuRcuda/host_vector.hpp"

// empty host_vector
template <typename T>
SEXP nvVecEmpty(int size){
	host_vector<T> *vec = new host_vector<T>(size);
	Rcpp::XPtr<host_vector<T> > pVec(vec);
	return pVec;
}

// convert SEXP to thrust vector
template <typename T>
SEXP sexpToHostVector(T *x, int size){
	host_vector<T> *vec = new host_vector<T>(x, size);
	Rcpp::XPtr<host_vector<T> > pVec(vec);
	return pVec;
}

// convert thrust vector to SEXP
template <typename T>
void nvVecToSEXP(SEXP mat, T* x){
	
	Rcpp::XPtr<host_vector<T> > pVec(mat);
	
	thrust::copy(pVec->getPtr()->begin(), pVec->getPtr()->end(), x);
}


// [[Rcpp::export]]
SEXP
sexpToHostVector(SEXP x, 
                int size,
                const int type_flag)
{
	switch(type_flag) {
	case 4:
		return sexpToHostVector<int>(INTEGER(x), size);
	case 6:
		Rcpp::exception("float not yet implemented");
		// return sexpToHostVector<float>(FLOAT(ptrA_, nr, nc);
	case 8:
		return sexpToHostVector<double>(REAL(x), size);
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}

// [[Rcpp::export]]
void
nvVecToSEXP(SEXP ptrA, 
           SEXP x,
           const int type_flag)
{
	switch(type_flag) {
	case 4:
		nvVecToSEXP<int>(ptrA, INTEGER(x));
		return;
	case 6:
		Rcpp::exception("float not yet implemented");
		// nvVecToSEXP<float>(ptrA, FLOAT(ptrA_));
		// return;
	case 8:
		nvVecToSEXP<double>(ptrA, REAL(x));
		return;
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}


// [[Rcpp::export]]
SEXP
nvVecEmpty(int size,
          const int type_flag)
{
	switch(type_flag) {
	case 4:
		return nvVecEmpty<int>(size);
	case 6:
		Rcpp::exception("float not yet implemented");
		// return nvVecEmpty<float>(size);
	case 8:
		return nvVecEmpty<double>(size);
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}
