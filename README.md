# gpuRcuda: The Simple CUDA GPU Interface for R
[![Travis-CI Build Status](https://travis-ci.org/gpuRcore/gpuRcuda.png?branch=master)](https://travis-ci.org/gpuRcore/gpuRcuda)

Test coverage: [![Coverage Status](https://coveralls.io/repos/github/gpuRcore/gpuRcuda/badge.svg?branch=master)](https://coveralls.io/github/gpuRcore/gpuRcuda?branch=master)

Welcome to gpuRcuda!  This package is designed to be an extension upon the
more general [gpuR](https://github.com/cdeterman/gpuR) package.  Essentially,
this package creates a new series of classes that mirror those from
gpuR classes.  The key aspect of this
package is to allow the user to use a CUDA backend where the NVIDIA specific
language will improve overall performance.

The syntax is designed to be identical to [gpuR](https://github.com/cdeterman/gpuR)

```r
ORDER <- 1024
A <- matrix(rnorm(ORDER^2), nrow=ORDER)
B <- matrix(rnorm(ORDER^2), nrow=ORDER)
gpuA <- cudaMatrix(A, type="double")
gpuB <- cudaMatrix(B, type="double")

C <- A %*% B
gpuC <- gpuA %*% gpuB

all(C == gpuC)
[1] TRUE
```

### Dependencies
1. opencl-headers (shared library)
2. NVIDIA Drivers & SDK

### NVIDIA Driver and CUDA/OpenCL
#### Up-to-date Card
If you are fortunate enough to have a very recent card that you can
use the most recent drivers.  THis install is much more simple
```
# Install Boost & OpenCL headers
sudo apt-get install opencl-headers

# Install NVIDIA Drivers and CUDA
sudo add-apt-repository -y ppa:xorg-edgers/ppa
sudo apt-get update
sudo apt-get install nvidia-346 nvidia-settings
sudo apt-get install cuda
```

#### Older Card
If you have an older card that doesn't support the newest drivers:

1. Purge any existing nvidia and cuda implementations 
(`sudo apt-get purge cuda* nvidia-*`)
2. Download appropriate CUDA toolkit for the specific card.  You can figure 
this out by first checking which NVIDIA driver is compatible with your card
by searching for it in [NVIDIA's Driver Downloads](http://www.nvidia.com/Download/index.aspx?lang=en-us).
Then check which cuda toolkit is compatible with the driver from this
[Backward Compatibility Table](http://docs.roguewave.com/totalview/8.14.1/html/index.html#page/User_Guides/totalviewug-about-cuda.31.4.html)
Let's say the cuda-6.5 toolkit was appropriate, which you can download from the 
[CUDA toolkit archive](https://developer.nvidia.com/cuda-toolkit-archive).
Once downloaded, run the .run file.
3. Reboot computer
4. Switch to ttyl (Ctrl-Alt-F1)
5. Stop the X server (sudo stop lightdm)
6. Run the cuda run file (`sh cuda_6.5.14_linux_64.run`)
7. Select 'yes' and accept all defaults
8. Required reboot
9. Switch to ttyl, stop X server and run the cuda run file again and select 
'yes' and default for everything (including the driver again)
10. Update `PATH` to include `/usr/local/cuda-6.5/bin` and `LD_LIBRARY_PATH`
to include `/usr/local/cuda-6.5/lib64`
11. Reboot again
