% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/optim_vmpf.R
\name{MVPF}
\alias{MVPF}
\title{MVPF: Minimization of the Variance of the Kriging-Predicted Front}
\usage{
MVPF(
  model,
  fun,
  nsteps,
  lower = rep(0, model@d),
  upper = rep(1, model@d),
  quiet = TRUE,
  control = NULL,
  modelcontrol = NULL
)
}
\arguments{
\item{model}{An object of class \code{\link{mkm}},}

\item{fun}{The multi-objective and constraint cost function to be optimized.
This function must return a vector with the size of \code{model@m +
model@j} where \code{model@m} are the number of objectives and
\code{model@j} the number of the constraints,}

\item{nsteps}{An integer representing the desired number of iterations,}

\item{lower}{Vector of lower bounds for the variables to be optimized over
(default: 0 with length \code{model@d}),}

\item{upper}{Vector of upper bounds for the variables to be optimized over
(default: 1 with length \code{model@d}),}

\item{quiet}{Logical indicating the verbosity of the routine,}

\item{control}{An optional list of control parameters that controls the
optimization algorithm. One can control: \describe{
\item{\code{popsize}}{(default: \code{200});}
\item{\code{generations}}{(default: \code{30});}
\item{\code{cdist}}{(default: \code{1/model@d});}
\item{\code{mprob}}{(default: \code{15});}
\item{\code{mdist}}{(default: \code{20}).}
}}

\item{modelcontrol}{An optional list of control parameters to the
\code{mkm} function (default: \code{object@control}).}
}
\value{
an updated object of class \code{mkm}.
}
\description{
Executes \code{nsteps} iterations of the VMPF algorithm to an object of class
\code{\link{mkm}}. At each step, a multi-objective kriging model is re-estimated
(including covariance parameters re-estimation).
}
\details{
The infill point is sampled from the most uncertain design of a predicted
Pareto set. This set is predicted using nsga-2 algorithm and the mean value
of the mkm predictor.
}
\examples{
# ----------------
# The Nowacki Beam
# ----------------
n <- 20
d <- 2
nsteps <- 2 # value has been set to 2 to save compliation time, change this value to 40.
fun <- nowacki_beam
doe <- replicate(d,sample(0:n,n))/n
res <- t(apply(doe, 1, fun))
model <- mkm(doe, res, modelcontrol = list(objective = 1:2, lower = rep(0.1,d)))
model <- MVPF(model, fun, nsteps, quiet = FALSE)
plot(nowacki_beam_tps$set)
points(ps(model@response[which(model@feasible),model@objective])$set, col = 'green', pch = 19)
}
