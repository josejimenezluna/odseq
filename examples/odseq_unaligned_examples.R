### odseq_unaligned examples on paper

### Trying out several different kernels

data(seqs)
sp <- spectrumKernel(k = 3)
mat <- getKernelMatrix(sp, seqs)
outliers <- odseq_unaligned(mat, B = 1000, threshold = 0.025, type = "similarity")

ground_truth <- c(rep(FALSE, 211), rep(TRUE, 100))
mean(outliers == ground_truth)

k2 <- gappyPairKernel(k = 1, m = 3)
mat2 <- getKernelMatrix(k2, seqs)
outliers2 <- odseq_unaligned(mat2, B = 1000, threshold = 0.025, type = "similarity")
mean(outliers2 == ground_truth)

k3 <- mismatchKernel(k = 3, m = 2)
mat2 <- getKernelMatrix(k3, seqs)
outliers3 <- odseq_unaligned(mat2, B = 1000, threshold = 0.025, type = "similarity")
mean(outliers3 == ground_truth)

spec20 <- spectrumKernel(k=3, distWeight=linWeight(sigma=20))
mat3 <- getKernelMatrix(spec20, seqs)
outliers4 <- odseq_unaligned(mat3, B = 1000, threshold = 0.025, type = "similarity")
mean(outliers4 == ground_truth)

exp20 <- spectrumKernel(k=3, distWeight=expWeight(sigma=20))
mat4 <- getKernelMatrix(exp20, seqs)
outliers5 <- odseq_unaligned(mat4, B = 1000, threshold = 0.025, type = "similarity")
mean(outliers5 == ground_truth)

### Using families from the same clan

pf01500 <- readAAStringSet("PF01500_uniprot.txt")
pf13885 <- readAAStringSet("PF13885_uniprot.txt")


both <- c(pf01500[1:200], pf13885[1:50])

k2 <- gappyPairKernel(k = 1, m = 3)
mat2 <- getKernelMatrix(k2, both)
outliers2 <- odseq_unaligned(mat2, B = 1000, threshold = 0.025, type = "similarity")
mean(outliers2 == ground_truth)

k <- spectrumKernel(k = 3)
mat <- getKernelMatrix(k, both)
outliers <- odseq_unaligned(mat, B = 1000, threshold = 0.025, type = "similarity")
mean(outliers == ground_truth)


