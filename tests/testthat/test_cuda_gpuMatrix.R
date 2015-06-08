library(gpuRcuda)
context("CUDA gpuMatrix algebra")

# avoid downcast warnings for single precision
options(bigmemory.typecast.warning=FALSE)

# set seed
set.seed(123)

ORDER <- 4

# Base R objects
Aint <- matrix(sample(seq(10), ORDER^2, replace=TRUE), nrow=ORDER, ncol=ORDER)
Bint <- matrix(sample(seq(10), ORDER^2, replace=TRUE), nrow=ORDER, ncol=ORDER)
A <- matrix(rnorm(ORDER^2), nrow=ORDER, ncol=ORDER)
B <- matrix(rnorm(ORDER^2), nrow=ORDER, ncol=ORDER)


test_that("cudaMatrix Single Precision Matrix multiplication successful", {
  
  has_gpu_skip()
  
  C <- A %*% B
  
  fgpuA <- cudaMatrix(A, type="float")
  fgpuB <- cudaMatrix(B, type="float")
  
  fgpuC <- fgpuA %*% fgpuB
  
  expect_is(fgpuC, "fcudaMatrix")
  expect_equal(fgpuC@x[,], C, tolerance=1e-07, 
               info="double matrix elements not equivalent")  
})

test_that("cudaMatrix Double Precision Matrix multiplication successful", {
	
	has_gpu_skip()
	has_double_skip()
	
	C <- A %*% B
	
	dgpuA <- cudaMatrix(A, type="double")
	dgpuB <- cudaMatrix(B, type="double")
	
	dgpuC <- dgpuA %*% dgpuB
	
	expect_is(dgpuC, "dcudaMatrix")
	expect_equal(dgpuC@x[,], C, tolerance=.Machine$double.eps ^ 0.5, 
							 info="double matrix elements not equivalent")  
})


test_that("cudaMatrix Single Precision Matrix Subtraction successful", {
    
    has_gpu_skip()
    
    C <- A - B
    
    fgpuA <- cudaMatrix(A, type="float")
    fgpuB <- cudaMatrix(B, type="float")
    
    fgpuC <- fgpuA - fgpuB
    
    expect_is(fgpuC, "fcudaMatrix")
    expect_equal(fgpuC@x[,], C, tolerance=1e-07, 
                 info="float matrix elements not equivalent")  
})

test_that("cudaMatrix Single Precision Matrix Addition successful", {
    
    has_gpu_skip()
    
    C <- A + B
    
    fgpuA <- cudaMatrix(A, type="float")
    fgpuB <- cudaMatrix(B, type="float")
    
    fgpuC <- fgpuA + fgpuB
    
    expect_is(fgpuC, "fcudaMatrix")
    expect_equal(fgpuC@x[,], C, tolerance=1e-07, 
                 info="float matrix elements not equivalent")  
})


test_that("CUDA cudaMatrix Double Precision Matrix Subtraction successful", {
    
    has_gpu_skip()
    has_double_skip()
    
    C <- A - B
    
    dgpuA <- cudaMatrix(A, type="double")
    dgpuB <- cudaMatrix(B, type="double")
    
    dgpuC <- dgpuA - dgpuB
    
    expect_is(dgpuC, "dcudaMatrix")
    expect_equal(dgpuC@x[,], C, tolerance=.Machine$double.eps ^ 0.5, 
                 info="double matrix elements not equivalent")  
})

test_that("CUDA cudaMatrix Double Precision Matrix Addition successful", {
    
    has_gpu_skip()
    has_double_skip()
    
    C <- A + B
    
    dgpuA <- cudaMatrix(A, type="double")
    dgpuB <- cudaMatrix(B, type="double")
    
    dgpuC <- dgpuA + dgpuB
    
    expect_is(dgpuC, "dcudaMatrix")
    expect_equal(dgpuC@x[,], C, tolerance=.Machine$double.eps ^ 0.5, 
                 info="double matrix elements not equivalent")  
})
