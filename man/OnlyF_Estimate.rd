\name{OnlyF_Estimate}
\alias{OnlyF_Estimate}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Estimating node fitnesses in isolation   
}
\description{
  This function estimates node fitnesses \eqn{\eta_i} assusming either \eqn{A_k = k} (i.e. linear preferential attachment) or \eqn{A_k = 1} (i.e. no preferential attachment). It first performs a cross-validation to select the optimal parameter \eqn{s} for the prior of \eqn{\eta_i}, then estimates \eqn{eta_i} (Ref. 1).
}
\usage{
OnlyF_Estimate(raw_net               , 
               net_stat              , 
               stop.cond = 10^-8     , 
               model_A   = "Linear"  ,
               ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
\item{raw_net}{
  a three-column matrix that contains the network.
}
\item{net_stat}{
   An object of class \code{PAFit_data} which contains summerized statistics needed in estimation. This object is created by the function \code{\link{GetStatistics}}.
}
  \item{stop.cond}{Numeric. The iterative algorithm stops when \eqn{abs(h(ii) - h(ii + 1)) / (abs(h(ii)) + 1) < stop.cond} where \eqn{h(ii)} is the value of the objective function at iteration \eqn{ii}. We recommend to choose \code{stop.cond} at most equal to \eqn{10^(- number of digits of h - 2)}, in order to ensure that when the algorithm stops, the increase in posterior probability is less than 1\% of the current posterior probability. Default is \code{10^-8}. This is a good enough convergence threshold for most applications. The careful user can try with \code{10^-9}.}
  
  \item{model_A}{String. Indicates which attachment function \eqn{A_k} we assume:
      \itemize{
        \item \code{"Linear"}: We assume \eqn{A_k = k}, i.e. the Bianconi-\enc{Barabási}{Barabasi} model (Ref. 2).
        \item \code{"Constant"}: We assume \eqn{A_k = 1}, i.e. the Caldarelli model (Ref. 3).
      }
  }
\item{...}{Other parameters to pass to the internal estimation algorithm.}  
}

\value{
  Outputs a list, which contains the following fields.
  \itemize{
    \item \code{cv_data}: a \code{CV_Data} object which contains the cross-validation data. Normally the user does not need to pay attention to this data.
    
    \item \code{cv_result}: a \code{CV_Result} object which contains the cross-validation result. Normally the user does not need to pay attention to this data.
    
    \item \code{estimate_result}: this is a \code{PAFit_result} object which contains the estimated node fitnesses and their confidence intervals.
  }
}
\author{
  Thong Pham \email{thongpham@thongpham.net}
}
\references{
  1. Pham, T., Sheridan, P. & Shimodaira, H. (2016). Joint Estimation of Preferential Attachment and Node Fitness in Growing Complex Networks. Scientific Reports 6, Article number: 32558. doi:10.1038/srep32558   (\url{www.nature.com/articles/srep32558}).
  
  2. Bianconni, G. & \enc{Barabási}{Barabasi}, A. (2001). Competition and multiscaling in evolving networks. Europhys. Lett., 54, 436 (\url{http://iopscience.iop.org/article/10.1209/epl/i2001-00260-6/meta}).
  
  3. Caldarelli, G., Capocci, A. , De Los Rios, P. & \enc{Muñoz}{Munoz}, M.A. (2002). Scale-Free Networks from Varying Vertex Intrinsic Fitness. Phys. Rev. Lett., 89, 258702 (\url{http://link.aps.org/doi/10.1103/PhysRevLett.89.258702}).
  
}
\seealso{
  See \code{\link{GetStatistics}} for how to create summerized statistics needed in this function.
  
  See \code{\link{JointEstimate}} for the method to jointly estimate the attachment function \eqn{A_k} and node fitnesses \eqn{\eta_i}.
  
}

\examples{
\dontrun{
  library("PAFit")
  # size of initial network = 100
  # number of new nodes at each time-step = 100
  # Ak = k; prior of node fitnesses = 5
  net        <- GenerateNet(N        = 1000 , m             = 50 , 
                            num_seed = 100  , multiple_node = 100,
                            mode     = 1    , alpha         = 1  , 
                            shape    = 5    , rate          = 5)
                            
  net_stats  <- GetStatistics(net$graph)
  
  # estimate node fitnesses in isolation, assuming Ak = k
  result     <- OnlyF_Estimate(net$graph, net_stats)
 
  #plot the estimated node fitnesses and true node fitnesses
  plot(result$estimate_result , net_stats, true = net$fitness, plot = "true_f")
  }
}

\concept{fitness model}