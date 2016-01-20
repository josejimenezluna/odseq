\name{odmix}
\alias{odmix}
\title{
Gaussian mixture modelling of distances in a multiple sequence alignment.
}
\description{
This function performs clustering of biological sequences via fitting a
Gaussian mixture model of the distances defined by the \code{odseq} algorithm  
}
\usage{
odmix(msa_object, distance_metric, groups)
}
\arguments{
  \item{msa_object}{
An object of formal class \code{MsaAAMultipleAlignment}, as provided by the \pkg{msa} package.
}
  \item{distance_metric}{
A string indicating the type of distance metric to be computed. Either \code{'linear'} and \code{'affine'} is supported at the moment.
}
\item{groups}{
Number of groups to fit in the mixture model. If a numeric vector of size \code{n}, \code{n} models will be fitted and a list of BIC values
will be given to choose a single model.
}
}

\value{
A list containing the following items:

\item{prob}{A numeric matrix of size n x groups where the probability of belonging to a group is provided for each sequence.}
\item{class}{The class assigned according to \code{prob}. Returns a numeric vector.} 
\item{BIC}{BIC values for the models proposed in \code{groups}}
}

\author{
José Jiménez <jose@jimenezluna.com>
}

\seealso{
\code{\link{odseq_unaligned}} \code{\link{odseq}}
}
\examples{
data(seqs)
al <- msa(seqs)
odmix(al, distance_metric = "affine", groups = 2)
}
