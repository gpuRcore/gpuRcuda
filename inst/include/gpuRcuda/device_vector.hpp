#ifndef DEVICE_VECTOR_HPP
#define DEVICE_VECTOR_HPP

#define R_NO_REMAP

// R headers
#include <Rinternals.h>
#include <R.h>

// Thrust headers
#include "gpuRcuda/thrust_vector.hpp"

#include <Rcpp.h>

#include <memory>

template <class T>
class device_vector: public thrust_vector<T> {
	
private:
	std::shared_ptr<thrust::device_vector<T> > ptr;
	
public:
	
	// initializers
	device_vector() { }; // private default constructor
	device_vector(int size){
		// initialize vector of zeros
		thrust::device_vector<T> vec(size);
		thrust::fill(vec.begin(), vec.end(), (T)(0));
		ptr = std::make_shared<thrust::device_vector<T> >(vec);
	}
	device_vector(T init, int size){
		// initialize vector of init
		thrust::device_vector<T> vec(size);
		thrust::fill(vec.begin(), vec.end(), init);
		ptr = std::make_shared<thrust::device_vector<T> >(vec);
	}
	device_vector(T *x, int size){
		
		// initialize from SEXP pointer
		thrust::device_vector<T> vec(x, x + size);
		ptr = std::make_shared<thrust::device_vector<T> >(vec);
	}
	
	device_vector(thrust::host_vector<T> h_vec){
		thrust::device_vector<T> vec = h_vec;
		ptr = std::make_shared<thrust::device_vector<T> >(vec);
	}
	
	virtual int size(){
		return ptr->size();
	}
	
	// return shared_ptr
	std::shared_ptr<thrust::device_vector<T> > getPtr(){
		return ptr;
	}
	
};

#endif