\name{hbv}
\encoding{UTF-8}
\alias{hbv}
\alias{hbv.prerun}
\title{
hbv - simulation using hydrological model HBV
}
\description{
\code{hbv} simulates discharge from a given rainfall time series using a simple 0-D version of the hydrological model HBV (Bergström, 1976) as implemented in Heistermann & Kneis (2011) with simple routing using custom, triangular hydrograph or linear storage cascade. \code{hbv_prerun} applies \code{hbv} while repeating a pre-run phase ("warm up") as long as any of the storages change by more than \code{storage_tolerance}
}
\usage{
hbv(pars, init=NULL, prec, temp=NULL, delta_t=1, unithg=NULL)
hbv.prerun(init=NULL, prec, max_pre_runs=20, storage_tolerance=0.1, prerun_length=(365*24*60/5), verbose=TRUE,...)

}
%- maybe also 'usage' for other objects documented here.
\arguments{


  \item{pars}{
named vector holding the HBV parameters
\describe{
\item{\code{cfmax=2.4}}{degree day factor for snow melt  [mm/°C/d]}
\item{\code{tt=0}}{  temperature threshold below which precipitation falls as snow [°C]}
\item{\code{fc=200}}{field capacity [mm] }
\item{\code{minsm}}{minimum soil moisture for storage sm [mm]}
\item{\code{beta}}{parameter to control the fraction of rain and snow melt partitioned for groundwater recharge [-]}
\item{\code{lp}}{fraction of soil moisture-field capacity-ratio above which actual evapotranspiration equals potential evapotranspiration [-]}
\item{\code{corr=1}}{correction factor for potential evapotranspiration [-]}
\item{\code{k_perc}}{percolation coefficient [1/d]}
\item{\code{k0}}{fast storage coefficient of soil upper zone [1/d]}
\item{\code{luz}}{threshold above which soil upper zone storage empties at rate computed by storage coefficient K0 [mm]}
\item{\code{k1}}{slow storage coefficient of soil upper zone [1/d]}
\item{\code{k2}}{storage coefficient of soil lower zone [1/d]}
\item{\code{maxbas}}{Length of (triangular) unit hydrograph [timesteps]. See details.}
\item{\code{etpmean=5}}{mean evaporation [mm/d]}
\item{\code{tmean=10}}{mean temperatures [°C]}
\item{\code{n}}{(real) number of storages in linear storage cascade. Overrides pars["maxbas"], overridden by \code{unithg}.}
\item{\code{k}}{decay constant for linear storage cascade. Overrides pars["maxbas"], overridden by \code{unithg}.}
}
}
  \item{init}{
named vector holding the HBV state variables for initialisation
\describe{
\item{\code{'snow'=0}}{snow storage [mm]}
\item{\code{'sm'=200}}{soil moisture storage [mm]}
\item{\code{'suz'=0}}{soil upper zone storage [mm]}
\item{\code{'slz'=0}}{soil lower zone storage [mm]}
}
}
 
\item{prec}{
	vector holding rainfall in equidistant timesteps of \code{delta_t} in mm
}

\item{temp}{
	vector holding temperature in equidistant timesteps of \code{delta_t} in °C
}

\item{delta_t}{
length of timesteps in \code{prec} in days
}

\item{unithg}{ vector of dimensionless unit hydrograph (should sum up to 1). Overrides \code{pars[c("maxbas","n","k")]}.}

\item{max_pre_runs}{maximum number of pre-run iterations}

\item{storage_tolerance}{While any of the storages has changed by more than this values, the pre-run phase is repeated}

\item{prerun_length}{number of timesteps from \code{prec} to use for pre-run phase (typically a year)
}
\item{verbose}{additional text output during pre-run iterations}

\item{...}{additional parameters passed to \code{hbv}}

}


\details{
If \code{unithg} is specified, \code{pars[c("maxbas","n","k")]} are ignored. If \code{pars[c("n","k")]} are specified, routing using linear storagte cascade is performed. If only \code{pars["maxbas"]} is set, a triangular unit hydrograph with its peak in at \code{pars["maxbas"]} /2 timesteps is used.
}

\value{
The function returns a list \code{list(q, snow, sm, suz, slz)} with
%%  ~Describe the value returned
%%  If it is a LIST, use
\describe{
  \item{q}{(vector) modelled discharge [mm]}
  \item{snow}{(scalar) snow storage at end of run [mm]}
  \item{sm}{(scalar)soil moisture storage at end of run [mm]}
  \item{suz}{(scalar)soil upper zone storage at end of run [mm]}
  \item{slz}{(scalar)soil lower zone storage at end of run [mm]}
}
    
}
\references{
  Bergström, S. (1976) 
  Development and application of a conceptual runoff model for Scandinavian catchments. \emph{SMHI Reports RHO}, No. 7, Norrkög.
  
  Heistermann, M. & Kneis, D. (2011)
  Benchmarking quantitative precipitation estimation by conceptual rainfall-runoff modeling, \emph{Water Resour. Res.,}
  47, W06514, doi:10.1029/2010WR009153.  
}
\author{
Maik Heistermann, David Kneis, Till Francke
}
\note{
These functions are still in development, use with care, all comments welcome!
}

\examples{
data(huagrahuma)
prec.day <- aggregate(huagrahuma$inputs$P, 
      by=strftime(index(huagrahuma$inputs$P), "\%d.\%m.\%Y"))

#use standard parameters and initialization
hbv(pars=0, init=0, prec = prec.day , delta_t=1)
 
}

\keyword{ modelling }
\keyword{ utilities }
