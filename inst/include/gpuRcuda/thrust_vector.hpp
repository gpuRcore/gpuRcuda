#ifndef THRUST_VECTOR_HPP
#define THRUST_VECTOR_HPP

// Thrust headers
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>

#include <thrust/copy.h>
#include <thrust/fill.h>

#include <Rcpp.h>

template <class T>
class thrust_vector {
	
public:
	virtual ~thrust_vector() {}
	virtual int size(){
		return (int)(0);
	}
};

#endif