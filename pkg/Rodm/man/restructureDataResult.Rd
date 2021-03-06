\name{restructureDataResult}
\title{
Internal: Convert database query results
}
\description{
Function to convert database query results into a spacetime object (an inherited stfdf). One for numerical and one for character information.
}
\usage{
restructureDataResult(to.ret, value.numeric=TRUE,
		tz=c("global", "UTC", "GMT", "0", "local"))
}
\arguments{
  \item{to.ret}{
  results returned from IgetDataValues.
}
  \item{value.numeric}{
	  boolean indicating if values should be converted to numeric type (characters can be stored in the database and should not be converted)
}
  \item{tz}{
 String indicating whether the data should be obtained in the local or global time zone.
}
}
\details{
see code for details.
}
\value{
see code for details.
}
\author{
Dominik Reusser
}
\keyword{ utilities }
\keyword{ internal }
