# Weighted odseq

data(seqs)
seqs <- sort(seqs)
al1 <- msa(seqs, order = "input")

# get only the unique sequences
uniq_seqs <- unique(seqs)
counts <- table(seqs)

#get lines from the alignment corresponding to the first instance of each sequence
al2 <- Biostrings::AAMultipleAlignment(al1@unmasked[!duplicated(seqs)])

# verify that we can reproduce the sequences and alignments in the correct order
stopifnot(names(counts) == uniq_seqs)
stopifnot(rep(uniq_seqs, counts) == seqs)
stopifnot(as.character(al1@unmasked) == rep(as.character(al2@unmasked), counts))

# check timing
# dereplicated + weights is faster
# for this dataset both are fast, but for bigger datasets this can matter!
# (dereplicating before alignment can also be a big speedup)
system.time(od1 <- odseq(al1, B = 10000))
system.time(od2 <- odseq(al2, B = 10000, weights = counts))

# results are the same.
stopifnot(od1 == rep(od2, counts))
