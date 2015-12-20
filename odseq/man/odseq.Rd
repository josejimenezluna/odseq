\name{odseq}
\alias{odseq}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
odseq(msa_object, distance_metric = "linear", B = 100, threshold = 0.025)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{msa_object}{
%%     ~~Describe \code{msa_object} here~~
}
  \item{distance_metric}{
%%     ~~Describe \code{distance_metric} here~~
}
  \item{B}{
%%     ~~Describe \code{B} here~~
}
  \item{threshold}{
%%     ~~Describe \code{threshold} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (msa_object, distance_metric = "linear", B = 100, threshold = 0.025) 
{
    is.gap <- function(char) {
        if (char == "-") {
            return(1)
        }
        else {
            return(0)
        }
    }
    vector.gap <- function(seq) {
        return(as.numeric(sapply(seq, is.gap)))
    }
    linear_score <- function(seq1, seq2) {
        sum(seq1 != seq2)
    }
    linear_score_vec <- function(seq1, rest_sequences) {
        sapply(rest_sequences, function(x) {
            linear_score(seq1, x)
        })
    }
    affine_score <- function(seq1, seq2) {
        l <- length(seq1)
        seq1_left <- seq1[-1]
        seq2_left <- seq2[-1]
        seq1_right <- seq1[-l]
        seq2_right <- seq2[-l]
        case1 = (seq1_left != seq2_left) & (seq1_right == seq2_right)
        case2 = (seq1_left != seq2_left) & (seq1_right != seq2_right)
        sum(3 * case1 + case2)
    }
    affine_score_vec <- function(seq1, rest_sequences) {
        sapply(rest_sequences, function(x) {
            affine_score(seq1, x)
        })
    }
    sequences <- msa_object@unmasked
    n <- length(sequences)
    sep_sequences <- sapply(sequences, function(x) {
        strsplit(as.character(x), "")
    })
    gap_sequences <- t(sapply(sep_sequences, vector.gap))
    gap_sequences <- as.list(data.frame(t(gap_sequences)))
    if (distance_metric == "linear") {
        distance_matrix <- sapply(gap_sequences, function(x) {
            linear_score_vec(x, gap_sequences)
        })
    }
    else if (distance_metric == "affine") {
        distance_matrix <- sapply(gap_sequences, function(x) {
            affine_score_vec(x, gap_sequences)
        })
    }
    distance_scores <- apply(distance_matrix, 1, sum)
    distribution_scores <- replicate(B, {
        boot <- sample(distance_scores, n, rep = T)
        mean(boot)
    })
    confidence_interval <- quantile(distribution_scores, probs = c(threshold, 
        1 - threshold))
    outliers <- (distance_scores > confidence_interval[2] | distance_scores < 
        confidence_interval[1])
    return(outliers)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
