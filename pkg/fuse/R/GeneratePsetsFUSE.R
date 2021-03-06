#' This function generates parameter sets for FUSE (Clark et al., 2008).
#'
#' @param NumberOfRuns number of samples to generate, can be any integer
#' @param SamplingType sampling procedure to use, can be "URS" or "LHS"
#' @param RoutingParameterRange can be any range. Default range is c(0.01,5), or a single value can be calculated with \code{KirpichT} (in this case enter something like c(0.026,0.026)))
#'
#' @examples
#' # For reproducible results, use set.seed() before running this function.
#' # set.seed(123)
#' # parameters <- GeneratePsetsFUSE(NumberOfRuns=1000,SamplingType="LHS",RoutingParameterRange=c(0.01,5)
#'

GeneratePsetsFUSE <- function(NumberOfRuns,
                              SamplingType="LHS",
                              RoutingParameterRange=c(0.01,5)) {

  # Define sample domain (min and max for each parameter)
  DefaultRanges <- data.frame(rbind(rferr_add = c(0,0),                      # additive rainfall error (mm)
                                    rferr_mlt = c(1,1),                      # multiplicative rainfall error (-)
                                    maxwatr_1 = c(25,500),                   # depth of the upper soil layer (mm)
                                    maxwatr_2 = c(50,5000),                  # depth of the lower soil layer (mm)
                                    fracten   = c(0.05,0.95),                # fraction total storage in tension storage (-)
                                    frchzne   = c(0.05,0.95),                # fraction tension storage in recharge zone (-)
                                    fprimqb   = c(0.05,0.95),                # fraction storage in 1st baseflow reservoir (-)
                                    rtfrac1   = c(0.05,0.95),                # fraction of roots in the upper layer (-)
                                    percrte   = c(0.01,1000),                # percolation rate (mm day-1)
                                    percexp   = c(1,20),                     # percolation exponent (-)
                                    sacpmlt   = c(1,250),                    # SAC model percltn mult for dry soil layer (-)
                                    sacpexp   = c(1,5),                      # SAC model percltn exp for dry soil layer (-)
                                    percfrac  = c(0.05,0.95),                # fraction of percltn to tension storage (-)
                                    iflwrte   = c(0.01,1000),                # interflow rate (mm day-1)
                                    baserte   = c(0.001,1000),               # baseflow rate (mm day-1)
                                    qb_powr   = c(1,10),                     # baseflow exponent (-)
                                    qb_prms   = c(0.001,0.25),               # baseflow depletion rate (day-1)
                                    qbrate_2a = c(0.001,0.25),               # baseflow depletion rate 1st reservoir (day-1)
                                    qbrate_2b = c(0.001,0.25),               # baseflow depletion rate 2nd reservoir (day-1)
                                    sareamax  = c(0.05,0.95),                # maximum saturated area (-)
                                    axv_bexp  = c(0.001,3),                  # ARNO/VIC b exponent (-)
                                    loglamb   = c(5,10),                     # mean value of the topographic index (m)
                                    tishape   = c(2,5),                      # shape param for the topo index Gamma dist (-)
                                    timedelay = c(RoutingParameterRange[[1]],RoutingParameterRange[[2]])   ))               # time delay in runoff (days)
  names(DefaultRanges) <- c("Min","Max")

  if (SamplingType == "URS") {
    # This script generates "N" parameter sets sampling the ranges using a Uniform Random distribution.

    rferr_add <- runif(NumberOfRuns, min=DefaultRanges["rferr_add","Min"], max=DefaultRanges["rferr_add","Max"])
    rferr_mlt <- runif(NumberOfRuns, min=DefaultRanges["rferr_mlt","Min"], max=DefaultRanges["rferr_mlt","Max"])
    maxwatr_1 <- runif(NumberOfRuns, min=DefaultRanges["maxwatr_1","Min"], max=DefaultRanges["maxwatr_1","Max"])
    maxwatr_2 <- runif(NumberOfRuns, min=DefaultRanges["maxwatr_2","Min"], max=DefaultRanges["maxwatr_2","Max"])
    fracten   <- runif(NumberOfRuns, min=DefaultRanges["fracten","Min"], max=DefaultRanges["fracten","Max"])
    frchzne   <- runif(NumberOfRuns, min=DefaultRanges["frchzne","Min"], max=DefaultRanges["frchzne","Max"])
    fprimqb   <- runif(NumberOfRuns, min=DefaultRanges["fprimqb","Min"], max=DefaultRanges["fprimqb","Max"])
    rtfrac1   <- runif(NumberOfRuns, min=DefaultRanges["rtfrac1","Min"], max=DefaultRanges["rtfrac1","Max"])
    percrte   <- runif(NumberOfRuns, min=DefaultRanges["percrte","Min"], max=DefaultRanges["percrte","Max"])
    percexp   <- runif(NumberOfRuns, min=DefaultRanges["percexp","Min"], max=DefaultRanges["percexp","Max"])
    sacpmlt   <- runif(NumberOfRuns, min=DefaultRanges["sacpmlt","Min"], max=DefaultRanges["sacpmlt","Max"])
    sacpexp   <- runif(NumberOfRuns, min=DefaultRanges["sacpexp","Min"], max=DefaultRanges["sacpexp","Max"])
    percfrac  <- runif(NumberOfRuns, min=DefaultRanges["percfrac","Min"], max=DefaultRanges["percfrac","Max"])
    iflwrte   <- runif(NumberOfRuns, min=DefaultRanges["iflwrte","Min"], max=DefaultRanges["iflwrte","Max"])
    baserte   <- runif(NumberOfRuns, min=DefaultRanges["baserte","Min"], max=DefaultRanges["baserte","Max"])
    qb_powr   <- runif(NumberOfRuns, min=DefaultRanges["qb_powr","Min"], max=DefaultRanges["qb_powr","Max"])
    qb_prms   <- runif(NumberOfRuns, min=DefaultRanges["qb_prms","Min"], max=DefaultRanges["qb_prms","Max"])
    qbrate_2a <- runif(NumberOfRuns, min=DefaultRanges["qbrate_2a","Min"], max=DefaultRanges["qbrate_2a","Max"])
    qbrate_2b <- runif(NumberOfRuns, min=DefaultRanges["qbrate_2b","Min"], max=DefaultRanges["qbrate_2b","Max"])
    sareamax  <- runif(NumberOfRuns, min=DefaultRanges["sareamax","Min"], max=DefaultRanges["sareamax","Max"])
    axv_bexp  <- runif(NumberOfRuns, min=DefaultRanges["axv_bexp","Min"], max=DefaultRanges["axv_bexp","Max"])
    loglamb   <- runif(NumberOfRuns, min=DefaultRanges["loglamb","Min"], max=DefaultRanges["loglamb","Max"])
    tishape   <- runif(NumberOfRuns, min=DefaultRanges["tishape","Min"], max=DefaultRanges["tishape","Max"])
    timedelay <- runif(NumberOfRuns, min=DefaultRanges["timedelay","Min"], max=DefaultRanges["timedelay","Max"])

    parameters <- data.frame("rferr_add"=rferr_add,
                             "rferr_mlt"=rferr_mlt,
                             "maxwatr_1"=maxwatr_1,
                             "maxwatr_2"=maxwatr_2,
                             "fracten"=fracten,
                             "frchzne"=frchzne,
                             "fprimqb"=fprimqb,
                             "rtfrac1"=rtfrac1,
                             "percrte"=percrte,
                             "percexp"=percexp,
                             "sacpmlt"=sacpmlt,
                             "sacpexp"=sacpexp,
                             "percfrac"=percfrac,
                             "iflwrte"=iflwrte,
                             "baserte"=baserte,
                             "qb_powr"=qb_powr,
                             "qb_prms"=qb_prms,
                             "qbrate_2a"=qbrate_2a,
                             "qbrate_2b"=qbrate_2b,
                             "sareamax"=sareamax,
                             "axv_bexp"=axv_bexp,
                             "loglamb"=loglamb,
                             "tishape"=tishape,
                             "timedelay"=timedelay)

  }

  if (SamplingType == "LHS") {
    # This script generates "N" parameter sets sampling the ranges using a Latin Hypercube.

    parameters <- lhs( NumberOfRuns, as.matrix(DefaultRanges) )
    parameters <- data.frame(parameters)
    names(parameters) <- c("rferr_add","rferr_mlt","maxwatr_1","maxwatr_2","fracten","frchzne","fprimqb","rtfrac1","percrte","percexp","sacpmlt","sacpexp","percfrac","iflwrte","baserte","qb_powr","qb_prms","qbrate_2a","qbrate_2b","sareamax","axv_bexp","loglamb","tishape","timedelay")

  }

return(parameters)

}

