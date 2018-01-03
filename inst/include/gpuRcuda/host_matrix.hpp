#ifndef HOST_MATRIX_HPP
#define HOST_MATRIX_HPP

#define R_NO_REMAP

// R headers
#include <Rinternals.h>
#include <R.h>

// Thrust headers
#include "gpuRcuda/thrust_matrix.hpp"

#include <Rcpp.h>

#include <memory>

template <class T>
class host_matrix: public thrust_matrix<T> {
	
	private:
		std::shared_ptr<thrust::host_vector<T> > h_ptr;
		
	public:
		
		// initializers
		host_matrix() { }; // private default constructor
		host_matrix(int nr, int nc): thrust_matrix<T>(nr, nc){
			// initialize vector of zeros
			thrust::host_vector<T> vec(nr*nc);
			thrust::fill(vec.begin(), vec.end(), (T)(0));
			h_ptr = std::make_shared<thrust::host_vector<T> >(vec);
		}
		host_matrix(T init, int nr, int nc): thrust_matrix<T>(nr, nc){
			// initialize vector of init
			thrust::host_vector<T> vec(nr*nc);
			thrust::fill(vec.begin(), vec.end(), init);
			h_ptr = std::make_shared<thrust::host_vector<T> >(vec);
		}
		host_matrix(T *x, int nr, int nc): thrust_matrix<T>(nr, nc){
			
			// initialize from SEXP pointer
			thrust::host_vector<T> vec(x, x + nr*nc);
			h_ptr = std::make_shared<thrust::host_vector<T> >(vec);
		}
		
		// return shared_ptr
		std::shared_ptr<thrust::host_vector<T> > getPtr(){
			return h_ptr;
		}
	
};

#endif