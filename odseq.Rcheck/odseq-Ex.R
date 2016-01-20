pkgname <- "odseq"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('odseq')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("odmix")
### * odmix

flush(stderr()); flush(stdout())

### Name: odmix
### Title: Gaussian mixture modelling of distances in a multiple sequence
###   alignment.
### Aliases: odmix

### ** Examples

data(seqs)
al <- msa(seqs)
odmix(al, distance_metric = "affine", groups = 2)



cleanEx()
nameEx("odseq-package")
### * odseq-package

flush(stderr()); flush(stdout())

### Name: odseq-package
### Title: Outlier detection in multiple sequence alignments
### Aliases: odseq-package

### ** Examples

data(seqs)
al <- msa(seqs)
odseq(al, distance_metric = "affine", B = 1000, threshold = 0.025)



cleanEx()
nameEx("odseq")
### * odseq

flush(stderr()); flush(stdout())

### Name: odseq
### Title: Outlier detection in a multiple sequence alignment
### Aliases: odseq

### ** Examples

data(seqs)
al <- msa(seqs)
odseq(al, distance_metric = "affine", B = 1000, threshold = 0.025)



cleanEx()
nameEx("odseq_unaligned")
### * odseq_unaligned

flush(stderr()); flush(stdout())

### Name: odseq_unaligned
### Title: Outlier detection provided a distance/similarity matrix of
###   sequences.
### Aliases: odseq_unaligned

### ** Examples

data(seqs)
sp <- spectrumKernel(k = 3)
mat <- getKernelMatrix(sp, seqs)
odseq_unaligned(mat, B = 1000, threshold = 0.025, type = "similarity")



cleanEx()
nameEx("seqs")
### * seqs

flush(stderr()); flush(stdout())

### Name: seqs
### Title: PFAM plus random data.
### Aliases: seqs

### ** Examples

data(seqs)



### * <FOOTER>
###
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
