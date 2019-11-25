odseq_unaligned <- function(distance_matrix, B = 100, threshold = 0.025, type = "similarity", weights = NULL){

   weighted_sum <- if (is.null(weights)) {
      sum
   } else {
      function(x) {
         sum(x*weights)
      }
   }

  n <- nrow(distance_matrix)

  # Compute score for each sequence
  distance_scores <- apply(distance_matrix, 1, weighted_sum)

  # Perform bootstrap of distance scores

  distribution_scores <- replicate(B, {boot <- sample(distance_scores, n, replace = TRUE, prob = weights);
                            mean(boot)})

  # Return logical vector of outliers, using threshold

  confidence_interval <- quantile(distribution_scores, probs = c(threshold, 1 - threshold))

  if(type == "similarity"){
    outliers <- distance_scores < confidence_interval[1]
  }
  else if(type == "distance"){
    outliers <- distance_scores > confidence_interval[2]
  }
  else{
    stop("Matrix type not supported. Choose similarity or distance.")
  }

  return(outliers)

}
