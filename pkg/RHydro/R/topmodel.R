topmodel <- function(parameters,
                     data,
                     delay,
                     topidx,
                     pm = c("NS"),
                     return.simulations = TRUE,
                     verbose = FALSE) {

  ## sort out the requested peformance measures
  perf.NS <- 0
  if(missing(pm)) {
    pm <- NULL
  } else {
    pm <- match.arg(pm, several.ok=TRUE)
    if("NS" %in% pm) perf.NS <- 1
  } 
  parameters <- as(parameters, "HydroTopmodelParameters")
 
  v <- 0
  if(return.simulations) v <- 1
  if(return.simulations && verbose) v <- 6

  ## check whether data can be converted to xts
  ## this means that they are real time series (i.e. with a constant deltat)
  ## then convert them to regular zoo series

  data <- try.xts(data, error = FALSE)
  data <- as.zooreg(data)
  index <- index(data)

  deltat <- deltat(data) / 60 / 60

  if(!("P" %in% names(data) && "ETp" %in% names(data))) {
    stop("Data should contain members P and ETp") }
  
  ## number of timesteps
  ntimesteps <- length(data$P)

  ## if performance measures are requested, Q should be part of input
  if(!is.null(pm) && is.null(data$Q))
    stop("If performance measures are requested, observed discharge (Q) must present in input")

  ## format Q
  if(!is.null(pm)) {
    Q2 <- as(data$Q, "numeric")
    if(min(Q2, na.rm=T) < 0)
      stop("Q should not contain negative values")
    Q2[is.na(Q2)] <- -1
    if(length(Q2) != ntimesteps) # probably redundant
      stop("Q should have the same length as P and ET0")
  } else Q2 <- -9999

  ## number of iterations
  iterations <- dim(parameters@parameters)[1]

  ## run the model
  result <- .C("topmodel",
               PACKAGE = "RHydro",
               as.double(t(cbind(as(parameters, "matrix"), deltat))),
               as.double(as.matrix(topidx)),
               as.double(as.matrix(delay)),
               as.double(as(data$P, "numeric")),
               as.double(as(data$ETp, "numeric")),
               as.double(Q2),
               as.integer(length(as.double(as.matrix(topidx)))/2),
               as.integer(ntimesteps),
               as.integer(iterations),
               as.integer(length(delay[,1])),
               as.integer(c(v, perf.NS)), # what to return?
               perf.NS = double(perf.NS * iterations),
               result = double(v * ntimesteps * iterations))

  ## Format the results
  reval <- NULL

  if(return.simulations) {
    results <- array(result$result,c(ntimesteps,iterations,v))
    vars <- c("Q","Qo","Qs","Qi","Qie","ETa")[1:v]
    retval <- list()
    for(i in 1:length(vars)) retval[[vars[i]]] <- zoo(results[,,i], order.by=index)
    if(perf.NS) retval <- list(simulations = retval, NS = result$perf.NS)
  } else if(perf.NS) retval <- result$perf.NS
  
  return(retval)
}
