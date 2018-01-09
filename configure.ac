AC_INIT([gpuRcuda], 1.0.0)

AC_LANG(C++)
AC_REQUIRE_CPP

echo "Checking for C++ Compiler"
AC_PROG_CXX

GPURCUDA_CPPFLAGS="-I. -I../inst/include"
GPURCUDA_CXXFLAGS=""
GPURCUDA_LIBS=""

if test "$BACKEND" = "OPENMP"; then

		AC_MSG_NOTICE("BACKEND = OPENMP")
		GPURCUDA_CPPFLAGS="${GPURCUDA_CPPFLAGS} -DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_OMP"
		GPURCUDA_CXXFLAGS="${GPURCUDA_CXXFLAGS} -fopenmp"

		BACKEND="OPENMP"
		AC_SUBST(BACKEND)

elif test "$BACKEND" = "CUDA"; then

		AC_MSG_NOTICE("BACKEND = CUDA")
		GPURCUDA_CPPFLAGS="${GPURCUDA_CPPFLAGS} -DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_CUDA"

		AC_MSG_CHECKING("Checking environment variable CUDA_HOME")
		if test -z "${CUDA_HOME}"; then
		    CUDA_HOME=`find /usr/local/ -maxdepth 1 -type d -name "cuda*" | sort -V | tail -1`
		    AC_MSG_RESULT("CUDA_HOME not set; using highest version found ${CUDA_HOME}")
		else
		    AC_MSG_RESULT("using CUDA_HOME=${CUDA_HOME}")
		fi
		
		AC_CHECK_FILE([${CUDA_HOME}/bin/nvcc], [HAS_NVCC="yes"])
		if test -z "${HAS_NVCC}"; then
		    AC_MSG_ERROR("NVCC not found; check CUDA install")
		else
		    AC_MSG_RESULT("NVCC found")
		fi
		
		AC_MSG_CHECKING("whether this is the 64 bit linux version of CUDA")
		AC_CHECK_FILE([${CUDA_HOME}/lib64/libcudart.so], [BIT64="yes"])
		if test -z "${BIT64}"; then
				AC_MSG_RESULT("no -- using ${CUDA_HOME}/lib for CUDA libs")
				cu_libdir="${CUDA_HOME}/lib"
				#AC_SUBST(CUDA_LIBDIR,["$cu_libdir"])
		else
				AC_MSG_RESULT("yes -- using ${CUDA_HOME}/lib64 for CUDA libs")
				cu_libdir="${CUDA_HOME}/lib64"
				#AC_SUBST(CUDA_LIBDIR,["$cu_libdir"])
		fi

		GPURCUDA_LIBS="${GPURCUDA_LIBS} -L${cu_libdir} -Wl,-rpath,${cu_libdir} -lcudart"
		BACKEND="CUDA"
		AC_SUBST(BACKEND)
else

		AC_MSG_NOTICE("No recognized BACKEND defined so trying CUDA first")
		
		AC_MSG_CHECKING("Checking environment variable CUDA_HOME")
		if test -z "${CUDA_HOME}"; then
		    CUDA_HOME=`find /usr/local/ -maxdepth 1 -type d -name "cuda*" | sort -V | tail -1`
		fi

		#else
		#    AC_MSG_RESULT("using CUDA_HOME=${CUDA_HOME}")
		#fi
		
		if test -z "${CUDA_HOME}"; then
			AC_MSG_RESULT("No CUDA installation found, attempting OPENMP install")
			GPURCUDA_CPPFLAGS="${GPURCUDA_CPPFLAGS} -DTHRUST_DEVICE_SYSTEM=THRUST_DEVICE_SYSTEM_OMP"
			GPURCUDA_CXXFLAGS="${CXXFLAGS} -fopenmp"
			BACKEND="OPENMP"
			AC_SUBST(BACKEND)

		else
			AC_MSG_RESULT("using CUDA_HOME=${CUDA_HOME}")
			#AC_MSG_RESULT("CUDA_HOME not set; using highest version found ${CUDA_HOME}")

			AC_CHECK_FILE([${CUDA_HOME}/bin/nvcc], [HAS_NVCC="yes"])
			if test -z "${HAS_NVCC}"; then
			    AC_MSG_ERROR("NVCC not found; check CUDA install")
			else
			    AC_MSG_RESULT("NVCC found")
			fi
			
			AC_MSG_CHECKING("whether this is the 64 bit linux version of CUDA")
			AC_CHECK_FILE([${CUDA_HOME}/lib64/libcudart.so], [BIT64="yes"])
			if test -z "${BIT64}"; then
					AC_MSG_RESULT("no -- using ${CUDA_HOME}/lib for CUDA libs")
					cu_libdir="${CUDA_HOME}/lib"
					#AC_SUBST(CUDA_LIBDIR,["$cu_libdir"])
			else
					AC_MSG_RESULT("yes -- using ${CUDA_HOME}/lib64 for CUDA libs")
					cu_libdir="${CUDA_HOME}/lib64"
					#AC_SUBST(CUDA_LIBDIR,["$cu_libdir"])
			fi

			GPURCUDA_LIBS="${GPURCUDA_LIBS} -L${cu_libdir} -Wl,-rpath,${cu_libdir} -lcudart"
			BACKEND="CUDA"
			AC_SUBST(BACKEND)

		fi

fi

## look for Rscript, but use the one found via R_HOME to allow for multiple installations
AC_DEFUN([AC_PROG_RSCRIPT], [AC_CHECK_PROG(RSCRIPT,Rscript,yes)])
AC_PROG_RSCRIPT

if test x"${RSCRIPT}" == x"yes" ; then
		
		R_HOME=`Rscript -e 'cat(R.home())'`

    rcpp_incl=`${R_HOME}/bin/Rscript -e 'Rcpp:::CxxFlags()'`
		thrust_incl=`${R_HOME}/bin/Rscript -e 'cat(paste("-I", system.file("include", package = "thrust"), sep = ""))'`
		AC_SUBST(RCPP_INCL,["$rcpp_incl"])
    AC_SUBST(THRUST_INCL,["$thrust_incl"])
else
    echo "
  Your installation does not appear to have Rscript installed.

  Please make sure that you have a working and complete R installation.
"
    exit 1
fi

R_INCL=`"${R_HOME}/bin/R" CMD config --cppflags`
R_LIBS=`"${R_HOME}/bin/R" CMD config --ldflags`
R_CPIC=`"${R_HOME}/bin/R" CMD config CPICFLAGS`




AC_MSG_CHECKING("building the nvcc command line")
NVCC="${CUDA_HOME}/bin/nvcc"

AC_MSG_NOTICE([Building Makevars])
AC_SUBST(GPURCUDA_CPPFLAGS)
AC_SUBST(GPURCUDA_CXXFLAGS)
AC_SUBST(CU_INCL)
AC_SUBST(NVCC)
AC_SUBST(R_INCL)
AC_SUBST(R_CPIC)
AC_SUBST(R_LIBS)
AC_SUBST(GPURCUDA_LIBS)
AC_OUTPUT(src/Makevars)
