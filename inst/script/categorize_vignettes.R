# This script categories packages with Sweave vignettes in an Excel file. The
# packages are categorized so that their vignettes may be categorized on the
# sweave2rmd project board.
#
# Using the script
#
# Set the threshold, version, repo, output_file, and filepath.
#
# The script first extracts the package names then checks if the package is in
# the current bioconductor version. It outputs their rank and from the rank
# assigns a priority based on the set threshold. Any package that has a rank
# lower than the threshold is a high priority package. The script then checks
# for the maintainer and assigns the package a status of 'To do` if the
# maintainer is the Bioconductor core team. We also want to know vignettes that
# are not in the current version so that we can classify their status as
# deprecated.


# Calling libraries to be used
library(BiocPkgTools)
library(openxlsx)

# Declaring variables
threshold <- 40
version <- "3.17"
repo <- "BioCsoft"
output_file <- "sweave2rmd.xlsx"
filepath <- "https://trello.com/1/cards/61d9de5dffd84647db58edb7/attachments/61d9de7a6b634f8b08261871/download/rnw-files.txt"

# Import data and divide the url to extract package names in one column
vignettes <- read.delim(filepath, header = FALSE, sep = "/", dec = " ")

# Extract unique packages so that a package name appears only once
packageNames <- unique(vignettes$V1)

# Get packages in specified Bioconductor version
biocPckgs <- biocPkgList(
  version,
  repo,
  addBiocViewParents = TRUE
)

# Create list of packages from vignette list in specified version
pckgs<- c()
for (i in packageNames) {
  if (i %in% biocPckgs$Package)
    pckgs <- append(pckgs, i)
}

# Getting list of packages maintained by Bioconductor
coreMaintained <- biocMaintained()$Package

# For every package, their rank, priority and status is computed. This is the
# output that we want from the script which will help us categorize the
# packages.
pkgsList <- list()
for (i in 1:length(packageNames)) {
  if (packageNames[[i]] %in% pckgs) {
    rank <- pkgDownloadRank(packageNames[[i]], "software", version)
    pkgsList[[i]] <- list(package = packageNames[[i]],
                          rank = rank[[1]],
                          priority = ifelse(rank[[1]] < threshold, "High", "Low"),
                          status = ifelse(packageNames[[i]] %in% coreMaintained, "To do", "Contact maintainer"))
  } else {
    pkgsList[[i]] <- list(package = packageNames[[i]],
                          rank = " ",
                          priority = " ",
                          status = "Deprecated")
  }
}

# Convert the list to a dataframe
dataframe <- as.data.frame(do.call(rbind, pkgsList))

# Final output as an excel file
write.xlsx(dataframe, output_file, col_names= TRUE)
