odseq <-
function(msa_object, distance_metric = "linear", B = 100,
                  threshold = 0.025){
  
  # Define gap and score functions, using vectorization
  
  is.gap <- function(char){
    if(char == "-"){
      return(1)
    }
    else{
      return(0)
    }
  }
  
  vector.gap <- function(seq){
    return(as.numeric(sapply(seq, is.gap)))
  }
  
  linear_score <- function(seq1, seq2){
    sum(seq1 != seq2)
  }
  
  linear_score_vec <- function(seq1, rest_sequences){
    sapply(rest_sequences, function(x){linear_score(seq1, x)})
  }
  
  affine_score <- function(seq1, seq2){
    l <- length(seq1)
    seq1_left <- seq1[-1]
    seq2_left <- seq2[-1]
    seq1_right <- seq1[-l]
    seq2_right <- seq2[-l]
    
    case1 = (seq1_left != seq2_left) & (seq1_right == seq2_right)
    case2 = (seq1_left != seq2_left) & (seq1_right != seq2_right)
    
    sum(3*case1 + case2)
  }
  
  affine_score_vec <- function(seq1, rest_sequences){
    sapply(rest_sequences, function(x){affine_score(seq1, x)})
  }
  
  # Load msa object, and coerce it to list
  sequences <- msa_object@unmasked
  n <- length(sequences)
  sep_sequences <- sapply(sequences, function(x){strsplit(as.character(x), "")})
  gap_sequences <- t(sapply(sep_sequences, vector.gap))
  gap_sequences <- as.list(data.frame(t(gap_sequences)))

  # Compute distance matrix efficiently
  
  if(distance_metric == "linear"){
    distance_matrix <- sapply(gap_sequences, function(x){linear_score_vec(x, gap_sequences)})
  } else if(distance_metric == "affine"){
    distance_matrix <- sapply(gap_sequences, function(x){affine_score_vec(x, gap_sequences)})
  }
  
  # Compute score for each sequence
  
  distance_scores <- apply(distance_matrix, 1, sum)
  
  # Perform bootstrapping of distance scores
  
  distribution_scores <- replicate(B, {boot <- sample(distance_scores, n, rep = T);
                                      mean(boot)})
  
  # Return logical vector of outliers, using threshold
  
  confidence_interval <- quantile(distribution_scores, probs = c(threshold, 1 - threshold))
  outliers <- (distance_scores > confidence_interval[2] | 
                 distance_scores < confidence_interval[1])
  
  return(outliers)
  
}
