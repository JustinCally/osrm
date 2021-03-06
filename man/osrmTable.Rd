% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/osrmTable.R
\name{osrmTable}
\alias{osrmTable}
\title{Get Travel Time Matrices Between Points}
\usage{
osrmTable(
  loc,
  src = NULL,
  dst = NULL,
  exclude = NULL,
  gepaf = FALSE,
  measure = "duration"
)
}
\arguments{
\item{loc}{a data frame containing 3 fields: points identifiers, longitudes 
and latitudes (WGS84). It can also be a SpatialPointsDataFrame, a 
SpatialPolygonsDataFrame or an sf object. If so, row names are used as identifiers.
If loc parameter is used, all pair-wise distances are computed.}

\item{src}{a data frame containing origin points identifiers, longitudes 
and latitudes (WGS84). It can also be a SpatialPointsDataFrame, a 
SpatialPolygonsDataFrame or an sf object. If so, row names are used as identifiers. 
If dst and src parameters are used, only pairs between scr/dst are computed.}

\item{dst}{a data frame containing destination points identifiers, longitudes 
and latitudes (WGS84). It can also be a SpatialPointsDataFrame a 
SpatialPolygonsDataFrame or an sf object. If so, row names are used as identifiers.}

\item{exclude}{pass an optional "exclude" request option to the OSRM API.}

\item{gepaf}{a boolean indicating if coordinates are sent encoded with the
google encoded algorithm format (TRUE) or not (FALSE). Must be FALSE if using
the public OSRM API.}

\item{measure}{a character indicating what measures are calculated. It can 
be "duration" (in minutes), "distance" (meters), or both c('duration',
'distance'). The demo server only allows "duration".}
}
\value{
A list containing 3 data frames is returned. 
durations is the matrix of travel times (in minutes), 
sources and destinations are the coordinates of 
the origin and destination points actually used to compute the travel 
times (WGS84).
}
\description{
Build and send OSRM API queries to get travel time matrices 
between points. This function interfaces the \emph{table} OSRM service.
}
\details{
If loc, src or dst are data frames we assume that the 3 first 
columns of the data frame are: identifiers, longitudes and latitudes.
}
\note{
If you want to get a large number of distances make sure to set the 
"max-table-size" argument (Max. locations supported in table) of the OSRM 
server accordingly.
}
\examples{
\dontrun{
# Load data
data("berlin")

# Inputs are data frames
# Travel time matrix
distA <- osrmTable(loc = apotheke.df[1:50, c("id","lon","lat")])
# First 5 rows and columns
distA$durations[1:5,1:5]

# Travel time matrix with different sets of origins and destinations
distA2 <- osrmTable(src = apotheke.df[1:10,c("id","lon","lat")],
                    dst = apotheke.df[11:20,c("id","lon","lat")])
# First 5 rows and columns
distA2$durations[1:5,1:5]

# Inputs are sf points
distA3 <- osrmTable(loc = apotheke.sf[1:10,])
# First 5 rows and columns
distA3$durations[1:5,1:5]

# Travel time matrix with different sets of origins and destinations
distA4 <- osrmTable(src = apotheke.sf[1:10,], dst = apotheke.sf[11:20,])
# First 5 rows and columns
distA4$durations[1:5,1:5]
}
}
\seealso{
\link{osrmIsochrone}
}
