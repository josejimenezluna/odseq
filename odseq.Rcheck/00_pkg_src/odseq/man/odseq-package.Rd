\name{odseq-package}
\alias{odseq-package}
\docType{package}
\title{
\packageTitle{odseq}
}
\description{
\packageDescription{odseq}
}
\details{

The DESCRIPTION file:
\packageDESCRIPTION{odseq}
\packageIndices{odseq}
}
\author{
\packageAuthor{odseq}

Maintainer: \packageMaintainer{odseq}
}
\references{
[1] OD-seq: outlier detection in multiple sequence alignments. \emph{Peter Jehl, Fabian Sievers and Desmond G. Higgins}. BMC Bioinformatics. 2015.
}
\seealso{
\code{\link{odseq}} \code{\link{odseq_unaligned}}
}
\examples{
data(seqs)
al <- msa(seqs)
odseq(al, distance_metric = "affine", B = 1000, threshold = 0.025)
}
