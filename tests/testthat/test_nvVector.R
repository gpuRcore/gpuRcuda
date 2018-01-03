library(gpuRcuda)
context("nvVector class")

# set seed
set.seed(123)

ORDER <- 10

# Base R objects
Aint <- seq.int(ORDER)
Bint <- sample(seq.int(ORDER), ORDER)
A <- rnorm(ORDER)
B <- rnorm(ORDER)


test_that("typeof not working correctly", {
	fgpuA <- nvVector(A, type="double")
	expect_equal(typeof(fgpuA), "double")
})


test_that("length not working correctly", {
	fgpuA <- nvVector(A, type="double")
	expect_equal(length(fgpuA), length(A))
})

test_that("empty initialization failed", {
	fgpuA <- nvVector(length = 4, type = "double")
	expect_equivalent(fgpuA[], rep(0, 4),
										tolerance = .Machine$double.eps ^ 0.5,
										info = "double vector elements not equivalent")
})

test_that("double vector values not returned correctly",{
	fgpuA <- nvVector(A, type = "double")
	expect_equivalent(fgpuA[], A,  tolerance=.Machine$double.eps ^ 0.5,
										info="double vector elements not equivalent")
})