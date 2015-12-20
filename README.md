## odseq: Outlier detection in multiple sequence alignment (Bioconductor package)

`od-seq` is a simple method for detecting outliers in multiple sequence alignments performed in `R` using the functionality provided in the `msa` Bioconductor package.

The package will shortly be published in Bioconductor.

### Example of application

Suppose we have performed a fairly large alignment of protein sequences. We would like to know which sequences to discard for other analyses, but doing so visually is not easy.

We first load the necessary fasta files:

```
sq <- readAAStringSet("PF09274_plus_random.fasta")
```

We perform an msa using Clustal Omega:

```
alig <- msa(sq)
```

We call `odseq`, and it will return a logical vector (`TRUE` if the sequence is an outlier/can be discarded and `FALSE` otherwise).

```
y <- odseq(alig, threshold = 0.05, distance_metric = "affine", B = 1000)
```

In practice, `odseq` will discard a lot of the sequences if the overall quality of the multiple alignment is low. This is the intended purpose.

### References

[1] *Peter Jehl, Fabian Sievers and Desmond G. Higgins.* OD-seq: outlier detection in multiple sequence alignments. BMC Bioinformatics.