\name{odseq_unaligned}
\alias{odseq_unaligned}
\title{
Outlier detection provided a distance/similarity matrix of sequences.
}
\description{
Provided a similarity matrix (like the ones provided using string kernels in \pkg{kebabs}). It will then compute a score for each sequence and perform bootstrap to provide information on the distribution of the scores, which is used to distinguish outlier sequences.
}
\usage{
odseq_unaligned(distance_matrix, B = 100, threshold = 0.025, type = "similarity")
}
\arguments{
  \item{distance_matrix}{
A numeric matrix representing either similarity or distance among unaligned sequences. Package \pkg{kebabs} may be useful for this task.
}

  \item{B}{
Integer indicating the number of bootstrap replicates to be run. The higher the more robust the detection should be.
}

  \item{threshold}{
Float indicating the probability to be left at the right of the bootstrap scores distribution when computing outliers. This parameter may need some tuning depending on each specific problem
}

  \item{type}{
A string indicating the type of distance metric used. Either \code{'similarity'} or \code{'distance'}.
}

  \item{weights}{
Numeric vector with the same length as the \code{msa_object}, giving weights for each sequence.  In particular, if these are integer values, then the result will be the same as if each sequence was repeated in the alignment a number of times equal to its weight, but will be calculated much more quickly.
}


}

\value{
Returns a logical vector, where \code{TRUE} indicates an outlier.
}
\references{
[1] OD-seq: outlier detection in multiple sequence alignments. \emph{Peter Jehl, Fabian Sievers and Desmond G. Higgins}. BMC Bioinformatics. 2015.
}
\author{
José Jiménez <jose@jimenezluna.com>
}

\seealso{
\code{\link{odseq}}
}
\examples{
data(seqs)
sp <- spectrumKernel(k = 3)
mat <- getKernelMatrix(sp, seqs)
odseq_unaligned(mat, B = 1000, threshold = 0.025, type = "similarity")
}

