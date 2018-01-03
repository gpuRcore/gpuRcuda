

#include "gpuRcuda/device_vector.hpp"

// empty device_vector
template <typename T>
SEXP cudaVecEmpty(int size){
	
	#ifdef __CUDACC__
		cudaSetDevice(0);
	#endif
	
	device_vector<T> *vec = new device_vector<T>(size);
	Rcpp::XPtr<device_vector<T> > pVec(vec);
	return pVec;
}

// convert SEXP to thrust vector
template <typename T>
SEXP sexpToDeviceVector(T *x, int size){
	device_vector<T> *vec = new device_vector<T>(x, size);
	Rcpp::XPtr<device_vector<T> > pVec(vec);
	return pVec;
}

// convert thrust vector to SEXP
template <typename T>
void cudaVecToSEXP(SEXP mat, T* x){
	
	Rcpp::XPtr<device_vector<T> > pVec(mat);
	
	thrust::copy(pVec->getPtr()->begin(), pVec->getPtr()->end(), x);
}


// [[Rcpp::export]]
SEXP
sexpToDeviceVector(SEXP x, 
                int size,
                const int type_flag)
{
	switch(type_flag) {
	case 4:
		return sexpToDeviceVector<int>(INTEGER(x), size);
	case 6:
		Rcpp::exception("float not yet implemented");
		// return sexpToDeviceVector<float>(FLOAT(ptrA_, nr, nc);
	case 8:
		return sexpToDeviceVector<double>(REAL(x), size);
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}

// [[Rcpp::export]]
void
cudaVecToSEXP(SEXP ptrA, 
           SEXP x,
           const int type_flag)
{
	switch(type_flag) {
	case 4:
		cudaVecToSEXP<int>(ptrA, INTEGER(x));
		return;
	case 6:
		Rcpp::exception("float not yet implemented");
		// cudaVecToSEXP<float>(ptrA, FLOAT(ptrA_));
		// return;
	case 8:
		cudaVecToSEXP<double>(ptrA, REAL(x));
		return;
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}


// [[Rcpp::export]]
SEXP
cudaVecEmpty(int size,
          const int type_flag)
{
	switch(type_flag) {
	case 4:
		return cudaVecEmpty<int>(size);
	case 6:
		Rcpp::exception("float not yet implemented");
		// return cudaVecEmpty<float>(size);
	case 8:
		return cudaVecEmpty<double>(size);
	default:
		throw Rcpp::exception("unknown type detected for gpuRcuda object!");
	}
}
