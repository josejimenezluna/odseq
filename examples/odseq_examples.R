### odseq experiments on paper

set.seed(93)

## Accuracy on PFAM0974

data(seqs)
al <- msa(seqs)
ground_truth <- c(rep(1,211), rep(2, 100))

mix <- odmix(al, distance_metric = "affine", groups = 2:5)
mean(mix$class == ground_truth)

## Dropping accuracy adding more random sequences

aminoacids <- c("A", "R", "N", "D", "C", "Q", "E", "G", "H",
                "I", "L", "K", "M", "F", "P", "S", "T", "W",
                "Y",  "V")
rand <- paste0(sample(aminoacids, 76,replace = T), collapse = "")

c(seqs, AAStringSet(rand))

set.seed(93)

limit = 20
data(seqs)

accuracy1 <- numeric(limit)
accuracy2 <- numeric(limit)

for(i in 1:limit){
  cat("Iteration", i, "\n")
  rand_aa_sequence <- paste0(sample(aminoacids, 76,replace = T), collapse = "")
  ground_truth <- c(rep(FALSE, 211), rep(TRUE, 100 + i))
  seqs <- c(seqs, AAStringSet(rand_aa_sequence))
  al <- msa(seqs)
  outliers <- odseq(al, B = 1000, distance_metric = "linear")
  outliers2 <- odseq(al, B = 1000, distance_metric = "affine")
  accuracy1[i] <- mean(outliers == ground_truth)
  accuracy2[i] <- mean(outliers2 == ground_truth)
}

library(ggplot2)
theme_set(theme_gray(base_size = 15))
qplot(101:220, accuracy1, geom = "line", ylab = "Classification accuracy (0-1)",
      xlab = "Random sequences added")
qplot(101:220, accuracy2, geom = "line", ylab = "Classification accuracy (0-1)",
      xlab = "Random sequences added")


## Considering sequences from the same clan

pf01500 <- readAAStringSet("PF01500_uniprot.txt")
pf13885 <- readAAStringSet("PF13885_uniprot.txt")


both <- c(pf01500[1:200], pf13885[1:50])
ground_truth <- c(rep(FALSE,200), rep(TRUE, 50))
al <- msa(both)
outliers <- odseq(al, distance_metric = "affine", B = 1000)
mean(ground_truth == outliers)