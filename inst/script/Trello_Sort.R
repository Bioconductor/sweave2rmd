# This is a script that willl sort a list of vignettes to be converted from
# sweave to Rmarkdown. The vignettes are sorted to help know which vignettes need
# to be worked on and also help categorize the vignettes in the sweave2rmd
# project board.

# Using the script: input the list of vignettes, the script first extracts the
# package names then checks if the package is in the current bioconductor
# version (the current version is 3.17), outputs their rank and from the rank
# assigns a priority based on the set threshold then checks for the maintainer
# and assigns the package a status based on who the maintainer is.

# Variables: threshold is the variable used to categorize a package as a high
# priority or low priority package. The threshold is set to a certain number,
# example in our script is 40, this means that any package that has a rank
# above 40 is considered as a high priority package. 

# Calling libraries to be used
library(BiocPkgTools)
library(openxlsx)

# Declaring variables
threshold <- 40
version <- "3.17"
repo <- "BioCsoft"
output_file <- "sweave2rmd.xlsx"

# Import data and divide the url to extract package names in one column
filepath <- "https://trello.com/1/cards/61d9de5dffd84647db58edb7/attachments/61d9de7a6b634f8b08261871/download/rnw-files.txt"
vignettes <- read.delim(filepath, header = FALSE, sep = "/", dec = " ")

# Extract unique packages so that a package name appears only once
packageNames <- unique(vignettes$V1)

# Getting packages that are in bioconductor version 3.17
biocPckgs <- biocPkgList(
  version,
  repo,
  addBiocViewParents = TRUE
)

# creating a list of packages from the vignette list that are in version 3.17
pckgs <- list()
for(i in packagenames){
  if( i %in% biocPckgs$Package)
    pckgs <- append(pckgs,i)
}

# Getting list of packages maintained by bioconductor
coreMaintained <- list(biocMaintained()$Package)

# For every package, their rank, priotrity and status is computed. This is the
# output that we want from the script which will help us categorize the
# packages.

for(i in 1:length(pckgs)){
  rank <- pkgDownloadRank(i,"software" ,version)
  pkgsList[[i]] <- list(package = pckgs[[i]],
                        rank = rank[[1]],
                        priority = ifelse(rank[[1]] > threshold, "High","Low"),
                        status = ifelse(i %in% coremaintained, "To do","Contact Maintainer"))
  
}

# Convert the list to a dataframe
dataframe <- as.data.frame(do.call(rbind, pkgsList))

# Final output as an excel file
write.xlsx(dataframe, output_file, col_names= TRUE)

