// CUDA header files
#include<cuda_runtime.h>
#include<cublas_v2.h>

// armadillo headers for handling the R input data
#include <RcppArmadillo.h>

using namespace Rcpp;

//[[Rcpp::export]]
SEXP cpp_cudaMatrix_dgemm(SEXP A_, SEXP B_) {
    
    const arma::Mat<double> Am = as<arma::mat>(A_);
    const arma::Mat<double> Bm = as<arma::mat>(B_);
    
    double *bufA, *bufB, *bufC;
    const double alpha = 1.0, beta = 0.0;
    
//    double
//        * xa = REAL(a), * xb = REAL(b),
//    	* gpua, * gpub, * gpuc;
//
//    SEXP
//        dima = getAttrib(a, R_DimSymbol),
//        dimb = getAttrib(b, R_DimSymbol);
//
//    int
//        rowsa = INTEGER(dima)[0], colsa = INTEGER(dima)[1],
//        rowsb = INTEGER(dimb)[0], colsb = INTEGER(dimb)[1];
    
    int M = Am.n_cols;
    int K = Am.n_rows;
    int N = Bm.n_rows;
    int P = Bm.n_cols;
    
    int szA = M * N;
    int szB = N * P;
    int szC = K * P;

    arma::Mat<double> Cm = arma::Mat<double>(K, P);
    Cm.zeros();

    cublasStatus_t stat;
    cublasHandle_t handle;

    cudaError_t cudaStat;

    cudaStat = cudaMalloc((void**) &bufA, szA * sizeof(double));
    if (cudaStat != cudaSuccess){
        stop("device memory allocation failed");  
    } 
    cudaStat = cudaMalloc((void**) &bufB, szB * sizeof(double));
    if (cudaStat != cudaSuccess){
        stop("device memory allocation failed");
    }

//    int
//        rowsOpA = rowsa, colsOpA = colsa, colsOpB = colsb;

    cudaStat = cudaMalloc((void**) &bufC, szC * sizeof(double));
    if (cudaStat != cudaSuccess){
        stop("device memory allocation failed");
    }
    
    stat = cublasCreate(&handle);
    if(stat != CUBLAS_STATUS_SUCCESS){
        stop("CUBLAS initialization failed\n");
    }
    
    // copy matrix Am to bufA in GPU memory
    stat = cublasSetMatrix(K, M, sizeof(double), &Am[0], K, bufA, K);
    if(stat != CUBLAS_STATUS_SUCCESS) {
        cudaFree(bufC);
    	cudaFree(bufB);
    	cudaFree(bufA);
    	cublasDestroy(handle);
    	stop("Transfer of Matrix A to GPU failed");
    }
    
    // copy matrix Bm to bufB in GPU memory
    stat = cublasSetMatrix(N, P, sizeof(double), &Bm[0], N,
        bufB, N);
    if(stat != CUBLAS_STATUS_SUCCESS) {
        cudaFree(bufC);
    	cudaFree(bufB);
    	cudaFree(bufA);
    	cublasDestroy(handle);
    	stop("Transfer of Matrix B to GPU failed");
    }

    // run dgemm routine
    cublasDgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, K, P, M,
        &alpha, (const double *) bufA, K, (const double *) bufB, N,
	    &beta, bufC, K);

//    SEXP ab, dimab;
//    PROTECT(ab = allocVector(REALSXP, rowsOpA * colsOpB));
//    PROTECT(dimab = allocVector(INTSXP, 2));
//    INTEGER(dimab)[0] = rowsOpA; INTEGER(dimab)[1] = colsOpB;
//    setAttrib(ab, R_DimSymbol, dimab);
//
//    double * xab = REAL(ab);
    stat = cublasGetMatrix(K, P, sizeof(double), bufC, K,
        &Cm[0], K);
    if(stat != CUBLAS_STATUS_SUCCESS) {
        cudaFree(bufC);
        cudaFree(bufB);
    	cudaFree(bufA);
    	cublasDestroy(handle);
    	stop("Transfer of Matrix C from GPU failed");
    }

    cudaFree(bufA);
    cudaFree(bufB);
    cudaFree(bufC);

    cublasDestroy(handle);
    
    return wrap(Cm);
}