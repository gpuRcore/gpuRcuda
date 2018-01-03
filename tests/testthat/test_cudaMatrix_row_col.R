# library(gpuRcuda)
# context("cudaMatrix Row and Column Methods")
# 
# # set seed
# set.seed(123)
# 
# ORDER_X <- 4
# ORDER_Y <- 5
# 
# # Base R objects
# A <- matrix(rnorm(ORDER_X*ORDER_Y), nrow=ORDER_X, ncol=ORDER_Y)
# 
# R <- rowSums(A)
# C <- colSums(A)
# RM <- rowMeans(A)
# CM <- colMeans(A)
# 
# 
# test_that("cudaMatrix Single Precision Column Sums",
# {
# 	
# 	has_gpu_skip()
# 	
# 	fgpuX <- cudaMatrix(A, type="float")
# 	
# 	gpuC <- colSums(fgpuX)
# 	
# 	expect_is(gpuC, "fcudaVector")
# 	expect_equal(gpuC[], C, tolerance=1e-06, 
# 							 info="float colSums not equivalent")  
# })
# 
# test_that("cudaMatrix Double Precision Column Sums", 
# {
# 	
# 	has_gpu_skip()
# 	has_double_skip()
# 	
# 	dgpuX <- cudaMatrix(A, type="double")
# 	
# 	gpuC <- colSums(dgpuX)
# 	
# 	expect_is(gpuC, "dcudaVector")
# 	expect_equal(gpuC[], C, tolerance=.Machine$double.eps ^ 0.5, 
# 							 info="double colSums not equivalent")  
# })
# 
# 
# test_that("cudaMatrix Single Precision Row Sums",
# {
# 	
# 	has_gpu_skip()
# 	
# 	fgpuX <- cudaMatrix(A, type="float")
# 	
# 	gpuC <- rowSums(fgpuX)
# 	
# 	expect_is(gpuC, "fcudaVector")
# 	expect_equal(gpuC[], R, tolerance=1e-06, 
# 							 info="float rowSums values not equivalent")  
# })
# 
# test_that("cudaMatrix Double Precision Row Sums", 
# {
# 	
# 	has_gpu_skip()
# 	has_double_skip()
# 	
# 	dgpuX <- cudaMatrix(A, type="double")
# 	
# 	gpuC <- rowSums(dgpuX)
# 	
# 	expect_is(gpuC, "dcudaVector")
# 	expect_equal(gpuC[], R, tolerance=.Machine$double.eps ^ 0.5, 
# 							 info="double rowSums not equivalent")  
# })
# 
# test_that("cudaMatrix Single Precision Column Means",
# {
# 	
# 	has_gpu_skip()
# 	
# 	fgpuX <- cudaMatrix(A, type="float")
# 	
# 	gpuC <- colMeans(fgpuX)
# 	
# 	expect_is(gpuC, "fcudaVector")
# 	expect_equal(gpuC[], CM, tolerance=1e-06, 
# 							 info="float colMeans values not equivalent")  
# })
# 
# test_that("cudaMatrix Double Precision Column Means", 
# {
# 	
# 	has_gpu_skip()
# 	has_double_skip()
# 	
# 	dgpuX <- cudaMatrix(A, type="double")
# 	
# 	gpuC <- colMeans(dgpuX)
# 	
# 	expect_is(gpuC, "dcudaVector")
# 	expect_equal(gpuC[], CM, tolerance=.Machine$double.eps ^ 0.5, 
# 							 info="double colMeans not equivalent")  
# })
# 
# 
# test_that("cudaMatrix Single Precision Row Means",
# {
# 	
# 	has_gpu_skip()
# 	
# 	fgpuX <- cudaMatrix(A, type="float")
# 	
# 	gpuC <- rowMeans(fgpuX)
# 	
# 	expect_is(gpuC, "fcudaVector")
# 	expect_equal(gpuC[], RM, tolerance=1e-06, 
# 							 info="float rowMeans not equivalent")  
# })
# 
# test_that("cudaMatrix Double Precision Row Means", 
# {
# 	
# 	has_gpu_skip()
# 	has_double_skip()
# 	
# 	dgpuX <- cudaMatrix(A, type="double")
# 	
# 	gpuC <- rowMeans(dgpuX)
# 	
# 	expect_is(gpuC, "dcudaVector")
# 	expect_equal(gpuC[], RM, tolerance=.Machine$double.eps ^ 0.5, 
# 							 info="double rowMeans not equivalent")  
# })
