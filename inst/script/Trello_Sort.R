library(BiocPkgTools)

# Import data and divide the url to extract package names in one column
filepath <- "https://trello.com/1/cards/61d9de5dffd84647db58edb7/attachments/61d9de7a6b634f8b08261871/download/rnw-files.txt"
vignettes <- read.delim(filepath, header = FALSE, sep = "/", dec = " ")
vignettes

# Extract unique packages so that a package name appears only once
packagenames=unique(vignettes$V1)
packagenames

# Getting packages that are in version 3.17
pckgs <- biocPkgList(
  version = "3.17",
  repo = "BioCsoft",
  addBiocViewParents = TRUE
)

pckgs

# creating a list of packages from the url that are in version 3.17
pckgsnew <- list()
for(i in packagenames){
  if( i %in% pckgs$Package)
    pckgsnew <- append(pckgsnew,i)
}

pckgsnew

# Getting list of packages maintained by bioconductor
maintainer <- biocMaintained(
  version = BiocManager::version(),
  main = "maintainer@bioconductor\\.org"
)

maintainer

coremaintained <- list()
coremaintained<- list(maintainer$Package)
coremaintained


pkgsList <- list()
threshold <- 40
# creates rank
for(i in 1:length(head(pckgsnew))){
  rank <- pkgDownloadRank(i, version = "3.17")
  pkgsList[[i]] <- list(package = pckgsnew[[i]],
                        rank = rank[[1]],
                        priority = ifelse(rank[[1]] > threshold, "High","Low"),
                        status = ifelse(i %in% coremaintained, "To do","Contact Maintainer"))
}

pkgsList


install.packages("openxlsx")
library(openxlsx)

# Convert list to dataframe
dataframe <- as.data.frame(do.call(rbind, pkgsList))
dataframe

# Output the dataframe as an excel file
write.xlsx(dataframe, "sweave2rmd.xlsx", col_names= TRUE)
