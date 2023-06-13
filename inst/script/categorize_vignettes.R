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
version <- "3.18"
repo <- "BioCsoft"
output_file <- "sweave2rmd.xlsx"
filepath <- "https://github.com/Bioconductor/sweave2rmd/files/11604501/20230530.txt"

# Import data and divide the URL to extract package names in one column
vignettes <- read.delim(filepath, header = FALSE, sep = "/", dec = " ")

# Extract unique packages so that a package name appears only once
packageNames <- unique(vignettes$V1)

# Get packages in specified Bioconductor version
biocPckgs <- biocPkgList(version, repo, addBiocViewParents = TRUE)

# Getting list of packages maintained by Bioconductor
coreMaintained <- biocMaintained()$Package

# For every package, their rank, priority, status, and maintainer's email are computed.
# This is the output that we want from the script which will help us categorize the packages.
pkgsList <- list()
for (i in 1:length(packageNames)) {
  if (packageNames[[i]] %in% biocPckgs$Package) {
    rank <- pkgDownloadRank(packageNames[[i]], "software", version)
    maintainer_email <- biocPckgs[biocPckgs$Package == packageNames[[i]], ]$Maintainer
    pkgsList[[i]] <- list(package = packageNames[[i]],
                          rank = rank[[1]],
                          priority = ifelse(rank[[1]] < threshold, "High", "Low"),
                          status = ifelse(packageNames[[i]] %in% coreMaintained, "To do", "Contact maintainer"),
                          maintainer_email = maintainer_email)
  } else {
    pkgsList[[i]] <- list(package = packageNames[[i]],
                          rank = " ",
                          priority = " ",
                          status = "Deprecated",
                          maintainer_email = " ")
  }
}

# Convert the list to a dataframe
dataframe <- as.data.frame(do.call(rbind, pkgsList))

# Final output as an excel file
write.xlsx(dataframe, output_file, col_names= TRUE)
