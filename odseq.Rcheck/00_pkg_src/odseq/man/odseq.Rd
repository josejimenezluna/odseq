\name{odseq}
\alias{odseq}
\title{
Outlier detection in a multiple sequence alignment
}
\description{
This function will first compute a distance metric among every sequence in the multiple alignment. Then it will bootstrap an average score of these distance to provide information on the distribution of scores, which is used to distinguish outlier sequences with a certain threshold
}
\usage{
odseq(msa_object, distance_metric = "linear", B = 100, threshold = 0.025)
}
\arguments{
  \item{msa_object}{
An object of formal class \code{MsaAAMultipleAlignment}, as provided by the \pkg{msa} package.
}
  \item{distance_metric}{
A string indicating the type of distance metric to be computed. Either \code{'linear'} and \code{'affine'} is supported at the moment.
}
  \item{B}{
Integer indicating the number of bootstrap replicates to be run. The higher the more robust the detection should be.
}
  \item{threshold}{
Float indicating the probability to be left at the right of the bootstrap scores distribution when computing outliers. This parameter may need some tuning depending on each specific problem
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
\code{\link{odseq_unaligned}}
}
\examples{
data(seqs)
al <- msa(seqs)
odseq(al, distance_metric = "affine", B = 1000, threshold = 0.025)
}

