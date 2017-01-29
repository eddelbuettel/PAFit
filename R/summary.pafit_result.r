# function to summarize estimation results
summary.PAFit_result <- function(object,...){
    cat("\nPAFit_result object \n");
    cat("Estimation results by the PAFit method. \n");
    cat("Mode:","Only PA: ",object$only_PA,"; Only f:", object$only_f,"\n");
    cat("Number of bins: ", object$G,"\n");
    cat("Threshold of the number of new edges acquired: ", object$deg_thresh,"\n");
    cat("Number of nodes satisfied the threshold: ",sum(object$f != 1),"\n");
    cat("Number of iterations: ",length(object$log_likelihood) - 1,"\n");
    cat("Stopping condition:", object$stop_cond,"\n");
    cat("Auto Lambda: ",object$auto_lambda,"\n");
    if (object$auto_lambda == TRUE) 
        cat("Ratio (r): ", object$ratio,"\n");
    cat("Lambda used: ", object$lambda,"\n");
    cat("Prior of node fitness: shape: ",object$shape,"; rate: ",object$rate,"\n")
}