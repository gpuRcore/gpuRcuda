

#include "gpuRcuda/device_matrix.hpp"

// empty device_matrix
template <typename T>
SEXP cudaMatEmpty(int nr, int nc){
	device_matrix<T> *mat = new device_matrix<T>(nr, nc);
	Rcpp::XPtr<device_matrix<T> > pMat(mat);
	return pMat;
}

// convert SEXP to thrust matrix
template <typename T>
SEXP sexpToDeviceMatrix(T *x, int nr, int nc){
	device_matrix<T> *mat = new device_matrix<T>(x, nr, nc);
	Rcpp::XPtr<device_matrix<T> > pMat(mat);
	return pMat;
}

// convert thrust matrix to SEXP
template <typename T>
void cudaMatToSEXP(SEXP mat, T* x){
	
	Rcpp::XPtr<device_matrix<T> > pMat(mat);
	
	thrust::copy(pMat->getPtr()->begin(), pMat->getPtr()->end(), x);
}


// [[Rcpp::export]]
SEXP
sexpToDeviceMatrix(SEXP x, 
                int nr,
                int nc, 
                const int type_flag)
{
	switch(type_flag) {
	case 4:
		return sexpToDeviceMatrix<int>(INTEGER(x), nr, nc);
	case 6:
		Rcpp::exception("float not yet implemented");
		// return sexpToDeviceMatrix<float>(FLOAT(ptrA_, nr, nc);
	case 8:
		return sexpToDeviceMatrix<double>(REAL(x), nr, nc);
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}

// [[Rcpp::export]]
void
cudaMatToSEXP(SEXP ptrA, 
           SEXP x,
           const int type_flag)
{
	switch(type_flag) {
	case 4:
		cudaMatToSEXP<int>(ptrA, INTEGER(x));
		return;
	case 6:
		Rcpp::exception("float not yet implemented");
		// cudaMatToSEXP<float>(FLOAT(ptrA_, nr, nc);
		// return;
	case 8:
		cudaMatToSEXP<double>(ptrA, REAL(x));
		return;
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}


// [[Rcpp::export]]
SEXP
cudaMatEmtpy(int nr,
          int nc, 
          const int type_flag)
{
	switch(type_flag) {
	case 4:
		return cudaMatEmpty<int>(nr, nc);
	case 6:
		Rcpp::exception("float not yet implemented");
		// return cudaMatEmpty<float>(nr, nc);
	case 8:
		return cudaMatEmpty<double>(nr, nc);
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}
