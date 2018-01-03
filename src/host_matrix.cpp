

#include "gpuRcuda/host_matrix.hpp"

// empty host_matrix
template <typename T>
SEXP nvMatEmpty(int nr, int nc){
	host_matrix<T> *mat = new host_matrix<T>(nr, nc);
	Rcpp::XPtr<host_matrix<T> > pMat(mat);
	return pMat;
}

// convert SEXP to thrust matrix
template <typename T>
SEXP sexpToHostMatrix(T *x, int nr, int nc){
	host_matrix<T> *mat = new host_matrix<T>(x, nr, nc);
	Rcpp::XPtr<host_matrix<T> > pMat(mat);
	return pMat;
}

// convert thrust matrix to SEXP
template <typename T>
void nvMatToSEXP(SEXP mat, T* x){
	
	Rcpp::XPtr<host_matrix<T> > pMat(mat);
	
	thrust::copy(pMat->getPtr()->begin(), pMat->getPtr()->end(), x);
}


// [[Rcpp::export]]
SEXP
sexpToHostMatrix(SEXP x, 
             int nr,
             int nc, 
             const int type_flag)
{
	switch(type_flag) {
		case 4:
			return sexpToHostMatrix<int>(INTEGER(x), nr, nc);
		case 6:
			Rcpp::exception("float not yet implemented");
			// return sexpToHostMatrix<float>(FLOAT(ptrA_, nr, nc);
		case 8:
			return sexpToHostMatrix<double>(REAL(x), nr, nc);
		default:
			throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}

// [[Rcpp::export]]
void
nvMatToSEXP(SEXP ptrA, 
            SEXP x,
            const int type_flag)
{
	switch(type_flag) {
	case 4:
		nvMatToSEXP<int>(ptrA, INTEGER(x));
		return;
	case 6:
		Rcpp::exception("float not yet implemented");
		// nvMatToSEXP<float>(FLOAT(ptrA_, nr, nc);
		// return;
	case 8:
		nvMatToSEXP<double>(ptrA, REAL(x));
		return;
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}


// [[Rcpp::export]]
SEXP
nvMatEmtpy(int nr,
           int nc, 
           const int type_flag)
{
	switch(type_flag) {
		case 4:
			return nvMatEmpty<int>(nr, nc);
		case 6:
			Rcpp::exception("float not yet implemented");
			// return nvMatEmpty<float>(nr, nc);
		case 8:
			return nvMatEmpty<double>(nr, nc);
		default:
			throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}
