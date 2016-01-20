### odmix experiments on paper

## Dropping accuracy

ground_truth <- c(rep(1,211), rep(2,100))

limit = 125
data(seqs)

accuracy <- numeric(limit)

for(i in 1:limit){
  cat("Iteration", i, "\n")
  rand_aa_sequence <- paste0(sample(aminoacids, 76,replace = T), collapse = "")
  ground_truth <- c(rep(1, 211), rep(2, 100 + i))
  seqs <- c(seqs, AAStringSet(rand_aa_sequence))
  al <- msa(seqs)
  mix <- odmix(al, groups = 2, distance_metric = "affine")
  outliers <- mix$class
  prob <- mix$prob[,1]
  accuracy[i] <- mean(outliers == ground_truth)
}

library(ggplot2)
theme_set(theme_gray(base_size = 15))
qplot(101:225, accuracy, geom = "line", ylab = "Classification accuracy (0-1)",
      xlab = "Random sequences added")

## 3 families belonging to the same clan

pf01500 <- readAAStringSet("PF01500_uniprot.txt")
pf13885 <- readAAStringSet("PF13885_uniprot.txt")
pf05267 <- readAAStringSet("PF05287_uniprot.txt")

all <- c(pf01500[1:200], pf13885[1:200], pf05267[1:200])

al <- msa(all)
mix <- odmix(al,distance_metric = "affine", groups = 3)
ground_truth <- c(rep(3,200), rep(1,200), rep(2, 200))
mean(ground_truth == mix$class)


