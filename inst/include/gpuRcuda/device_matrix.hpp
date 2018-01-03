#ifndef DEVICE_MATRIX_HPP
#define DEVICE_MATRIX_HPP

#define R_NO_REMAP

// R headers
#include <Rinternals.h>
#include <R.h>

// Thrust headers
#include "gpuRcuda/thrust_matrix.hpp"

#include <Rcpp.h>

#include <memory>

template <class T>
class device_matrix: public thrust_matrix<T> {
	
private:
	std::shared_ptr<thrust::device_vector<T> > h_ptr;
	
public:
	
	// initializers
	device_matrix() { }; // private default constructor
	device_matrix(int nr, int nc): thrust_matrix<T>(nr, nc){
		// initialize vector of zeros
		thrust::device_vector<T> vec(nr*nc);
		thrust::fill(vec.begin(), vec.end(), (T)(0));
		h_ptr = std::make_shared<thrust::device_vector<T> >(vec);
	}
	device_matrix(T init, int nr, int nc): thrust_matrix<T>(nr, nc){
		// initialize vector of init
		thrust::device_vector<T> vec(nr*nc);
		thrust::fill(vec.begin(), vec.end(), init);
		h_ptr = std::make_shared<thrust::device_vector<T> >(vec);
	}
	device_matrix(T *x, int nr, int nc): thrust_matrix<T>(nr, nc){
		
		// initialize from SEXP pointer
		thrust::device_vector<T> vec(x, x + nr*nc);
		h_ptr = std::make_shared<thrust::device_vector<T> >(vec);
	}
	
	// return shared_ptr
	std::shared_ptr<thrust::device_vector<T> > getPtr(){
		return h_ptr;
	}
	
};

#endif