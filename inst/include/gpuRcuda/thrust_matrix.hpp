#ifndef THRUST_MATRIX_HPP
#define THRUST_MATRIX_HPP

// Thrust headers
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>

#include <thrust/copy.h>
#include <thrust/fill.h>

#include <Rcpp.h>

template <class T>
class thrust_matrix {
		
	protected:
		int nr, nc;
		thrust_matrix<T>(int nr, int nc): nr(nr), nc(nc){};
		
	public:
		int nrow() { return nr; }
		int ncol() { return nc; }
			
};
	
#endif