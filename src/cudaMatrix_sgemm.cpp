// CUDA header files
#include<cuda_runtime.h>
#include<cublas_v2.h>

// armadillo headers for handling the R input data
#include <RcppArmadillo.h>

using namespace Rcpp;

//[[Rcpp::export]]
SEXP cpp_cudaMatrix_sgemm(SEXP A_, SEXP B_) {
    
    const arma::Mat<float> Am = as<arma::Mat<float> >(A_);
    const arma::Mat<float> Bm = as<arma::Mat<float> >(B_);
    
    float *bufA, *bufB, *bufC;
    const float alpha = 1.0, beta = 0.0;
    
    int M = Am.n_cols;
    int K = Am.n_rows;
    int N = Bm.n_rows;
    int P = Bm.n_cols;
    
    int szA = M * N;
    int szB = N * P;
    int szC = K * P;

    arma::Mat<float> Cm = arma::Mat<float>(K, P);
    Cm.zeros();

    cublasStatus_t stat;
    cublasHandle_t handle;

    cudaError_t cudaStat;

    cudaStat = cudaMalloc((void**) &bufA, szA * sizeof(float));
    if (cudaStat != cudaSuccess){
        stop("device memory allocation failed");  
    } 
    cudaStat = cudaMalloc((void**) &bufB, szB * sizeof(float));
    if (cudaStat != cudaSuccess){
        stop("device memory allocation failed");
    }

//    int
//        rowsOpA = rowsa, colsOpA = colsa, colsOpB = colsb;

    cudaStat = cudaMalloc((void**) &bufC, szC * sizeof(float));
    if (cudaStat != cudaSuccess){
        stop("device memory allocation failed");
    }
    
    stat = cublasCreate(&handle);
    if(stat != CUBLAS_STATUS_SUCCESS){
        stop("CUBLAS initialization failed\n");
    }
    
    // copy matrix Am to bufA in GPU memory
    stat = cublasSetMatrix(K, M, sizeof(float), &Am[0], K, bufA, K);
    if(stat != CUBLAS_STATUS_SUCCESS) {
        cudaFree(bufC);
    	cudaFree(bufB);
    	cudaFree(bufA);
    	cublasDestroy(handle);
    	stop("Transfer of Matrix A to GPU failed");
    }
    
    // copy matrix Bm to bufB in GPU memory
    stat = cublasSetMatrix(N, P, sizeof(float), &Bm[0], N,
        bufB, N);
    if(stat != CUBLAS_STATUS_SUCCESS) {
        cudaFree(bufC);
    	cudaFree(bufB);
    	cudaFree(bufA);
    	cublasDestroy(handle);
    	stop("Transfer of Matrix B to GPU failed");
    }

    // run dgemm routine
    cublasSgemm(handle, CUBLAS_OP_N, CUBLAS_OP_N, K, P, M,
        &alpha, (const float *) bufA, K, (const float *) bufB, N,
	    &beta, bufC, K);

    stat = cublasGetMatrix(K, P, sizeof(float), bufC, K,
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