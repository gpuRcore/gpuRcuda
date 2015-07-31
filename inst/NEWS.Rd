\name{NEWS}
\title{News for Package 'gpuRcuda'}

\section{Initial Release version 1.0.0 (Unreleased)}{
    \itemize{
        \item Implemented Features:
        \itemize{
            \item cuda* classes for matrix objects
            \item Back compatible with gpuR objects - if method
            			method exists in gpuR but not in gpuRcuda, uses gpuR method
            \item CUDA support for 'float' and 'double' data types
            \item gpuMatrix functions (multiplication, addition, subtraction)
        }
        \item Features in Progress:
        \itemize{
            \item Additional matrix functions (QR-decompsition, SVD)
        }
    }
}