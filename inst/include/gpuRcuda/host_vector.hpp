#ifndef HOST_VECTOR_HPP
#define HOST_VECTOR_HPP

#define R_NO_REMAP

// R headers
#include <Rinternals.h>
#include <R.h>

// Thrust headers
#include "gpuRcuda/thrust_vector.hpp"

#include <Rcpp.h>

#include <memory>

template <class T>
class host_vector: public thrust_vector<T> {
	
private:
	std::shared_ptr<thrust::host_vector<T> > ptr;
	
public:
	
	// initializers
	host_vector() { }; // private default constructor
	host_vector(int size){
		// initialize vector of zeros
		thrust::host_vector<T> vec(size);
		thrust::fill(vec.begin(), vec.end(), (T)(0));
		ptr = std::make_shared<thrust::host_vector<T> >(vec);
	}
	host_vector(T init, int size){
		// initialize vector of init
		thrust::host_vector<T> vec(size);
		thrust::fill(vec.begin(), vec.end(), init);
		ptr = std::make_shared<thrust::host_vector<T> >(vec);
	}
	host_vector(T *x, int size){
		
		// initialize from SEXP pointer
		thrust::host_vector<T> vec(x, x + size);
		ptr = std::make_shared<thrust::host_vector<T> >(vec);
	}
	
	virtual int size(){
		return ptr->size();
	}
	
	// return shared_ptr
	std::shared_ptr<thrust::host_vector<T> > getPtr(){
		return ptr;
	}
	
};

#endif