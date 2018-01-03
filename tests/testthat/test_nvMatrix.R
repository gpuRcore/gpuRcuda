library(gpuRcuda)
context("nvMatrix class")

# set seed
set.seed(123)

ORDER <- 4

# Base R objects
Aint <- matrix(sample(seq(10), ORDER^2, replace=TRUE), nrow=ORDER, ncol=ORDER)
Bint <- matrix(sample(seq(10), ORDER^2, replace=TRUE), nrow=ORDER, ncol=ORDER)
A <- matrix(rnorm(ORDER^2), nrow=ORDER, ncol=ORDER)
B <- matrix(rnorm(ORDER^2), nrow=ORDER, ncol=ORDER)


test_that("typeof not working correctly", {
	fgpuA <- nvMatrix(A, type="double")
	expect_equal(typeof(fgpuA), "double")
})


test_that("dim not working correctly", {
	fgpuA <- nvMatrix(A, type="double")
	expect_equal(dim(fgpuA), dim(A))
})

test_that("empty initialization failed", {
	fgpuA <- nvMatrix(nrow = 4, ncol = 4, type = "double")
	expect_equivalent(fgpuA[], matrix(0, nrow = 4, ncol = 4),
										tolerance = .Machine$double.eps ^ 0.5,
										info = "double matrix elements not equivalent")
})

test_that("double matrix values not returned correctly",{
	fgpuA <- nvMatrix(A, type = "double")
	expect_equivalent(fgpuA[], A,  tolerance=.Machine$double.eps ^ 0.5,
										info="double matrix elements not equivalent")
})

# test_that("nvMatrix Single Precision Matrix multiplication successful", {
# 	
# 	has_gpu_skip()
# 	
# 	C <- A %*% B
# 	
# 	fgpuA <- nvMatrix(A, type="float")
# 	fgpuB <- nvMatrix(B, type="float")
# 	
# 	fgpuC <- fgpuA %*% fgpuB
# 	
# 	expect_is(fgpuC, "fnvMatrix")
# 	expect_equal(fgpuC[,], C, tolerance=1e-07, 
# 							 info="double matrix elements not equivalent")  
# })
# 
# test_that("nvMatrix Double Precision Matrix multiplication successful", {
# 	
# 	has_gpu_skip()
# 	has_double_skip()
# 	
# 	C <- A %*% B
# 	
# 	dgpuA <- nvMatrix(A, type="double")
# 	dgpuB <- nvMatrix(B, type="double")
# 	
# 	dgpuC <- dgpuA %*% dgpuB
# 	
# 	expect_is(dgpuC, "dnvMatrix")
# 	expect_equal(dgpuC[,], C, tolerance=.Machine$double.eps ^ 0.5, 
# 							 info="double matrix elements not equivalent")  
# })
# 
# 
# test_that("nvMatrix Single Precision Matrix Subtraction successful", {
# 	
# 	has_gpu_skip()
# 	
# 	C <- A - B
# 	
# 	fgpuA <- nvMatrix(A, type="float")
# 	fgpuB <- nvMatrix(B, type="float")
# 	
# 	fgpuC <- fgpuA - fgpuB
# 	
# 	expect_is(fgpuC, "fnvMatrix")
# 	expect_equal(fgpuC[,], C, tolerance=1e-07, 
# 							 info="float matrix elements not equivalent")  
# })
# 
# test_that("nvMatrix Single Precision Matrix Addition successful", {
# 	
# 	has_gpu_skip()
# 	
# 	C <- A + B
# 	
# 	fgpuA <- nvMatrix(A, type="float")
# 	fgpuB <- nvMatrix(B, type="float")
# 	
# 	fgpuC <- fgpuA + fgpuB
# 	
# 	expect_is(fgpuC, "fnvMatrix")
# 	expect_equal(fgpuC[,], C, tolerance=1e-07, 
# 							 info="float matrix elements not equivalent")  
# })
# 
# 
# test_that("CUDA nvMatrix Double Precision Matrix Subtraction successful", {
# 	
# 	has_gpu_skip()
# 	has_double_skip()
# 	
# 	C <- A - B
# 	
# 	dgpuA <- nvMatrix(A, type="double")
# 	dgpuB <- nvMatrix(B, type="double")
# 	
# 	dgpuC <- dgpuA - dgpuB
# 	
# 	expect_is(dgpuC, "dnvMatrix")
# 	expect_equal(dgpuC[,], C, tolerance=.Machine$double.eps ^ 0.5, 
# 							 info="double matrix elements not equivalent")  
# })
# 
# test_that("CUDA nvMatrix Double Precision Matrix Addition successful", {
# 	
# 	has_gpu_skip()
# 	has_double_skip()
# 	
# 	C <- A + B
# 	
# 	dgpuA <- nvMatrix(A, type="double")
# 	dgpuB <- nvMatrix(B, type="double")
# 	
# 	dgpuC <- dgpuA + dgpuB
# 	
# 	expect_is(dgpuC, "dnvMatrix")
# 	expect_equal(dgpuC[,], C, tolerance=.Machine$double.eps ^ 0.5, 
# 							 info="double matrix elements not equivalent")  
# })
