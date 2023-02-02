library(BiocPkgTools)

# Import data and divide the url to extract package names in one column
data= read.delim("https://trello.com/1/cards/61d9de5dffd84647db58edb7/attachments/61d9de7a6b634f8b08261871/download/rnw-files.txt", header = FALSE, sep = "/", dec = " ")
data


colnames(data)# check columns
data$V1 #check the packages column

# Extract unique packages so that a package name appears only once
packages=unique(data$V1)# Alternative method = unique(data[c("V1")])
packages
# Alternative method = unique(data[c("V1")])

str(packages)
typeof(packages)# Checking for data typeata type
length(packages)# Number of variables(packages)
print(packages[1])

                  
# Checking if we can get statistics for the packages
pkgDownloadStats(
  packages[1],
  pkgType = c("software", "data-experiment", "workflows", "data-annotation"),
  years = format(Sys.time(), "%Y")
)

# Check rank of the first package in the list
PckgRank=pkgDownloadRank(
  packages[1],
  pkgType = c("software", "data-experiment", "workflows", "data-annotation"),
  version = "3.17"
)

attributes(PckgRank)
attributes(PckgRank[1])

# Iterating through each package to get it's rank
for(i in packages){
  Rank=pkgDownloadRank(
    i,
    pkgType = c("software", "data-experiment", "workflows", "data-annotation"),
    version = "3.17"
  )
  # Alternative method = unique(my[c("V1")])print(Rank)
  Package_Rank=print(paste(i, Rank))
}


pckgs <- biocPkgList(
  version = "3.17",
  repo = "BioCsoft",
  addBiocViewParents = TRUE
)

pckgs

pckgsnew <- list()
for(i in packages){
  if( i %in% pckgs$Package)
     pckgsnew <- append(pckgsnew,i)
}

pckgsnew

length(pckgsnew)

pkgsList <- list()
for(i in head(pckgsnew)){
  Rank=pkgDownloadRank(
    i,
    pkgType = c("software", "data-experiment", "workflows", "data-annotation"),
    version = "3.17"
  )
  # Alternative method = unique(my[c("V1")])print(Rank)
  pkgsList <- append(pkgsList, list(package = i, rank = Rank))
}

pkgsList

head(pckgsnew)

head(pkgsList)
colnames(pkgsList)
names(pkgsList)


pkgsList$Priority = ifelse(pkgsList$rank > 40,"High","Low")
print(pkgsList)
