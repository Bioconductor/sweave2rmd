# Sweave2Rmd
## Description of the project

Sweave2Rmd is a project to convert all [Bioconductor](https://bioconductor.org)
Sweave vignettes to Rmd.

See the project [Trello Board](https://trello.com/b/nJHqzR1j/bioconductor-vignettes-rnw-rmd-project)
for vignettes that need converting and the [Github Project](https://github.com/orgs/Bioconductor/projects/2)
for the status of vignettes being converted. 

If you'd like to volunteer, see contribute.Rmd.

If you're a Bioconductor maintainer who needs help converting to `.Rmd`,
open an issue in your repository and ask `@Bioconductor/sweave2rmd` for
help converting.

This project follows the [Bioconductor Code of
Conduct](https://bioconductor.github.io/bioc_coc_multilingual/).

## How to use the trello script
### Description of the script

This is a script that will sort a list of vignettes to be converted from sweave
to Rmarkdown. The vignettes are sorted to help know which vignettes need to be
worked on and also help categorize the vignettes in the sweave2rmd project
board.

### How to use the script

#### Declare variables

Declare the variables used in the script and call the relevant libraries.

-   **threshold** : threshold is the variable used to categorize a package as a 
high priority or low priority package. The threshold is set to a certain number,
example in our script is 40, this means that any package that has a rank above 
40 is considered as a high priority package.

-   **version** : The Bioconductor version that will be used in the script.

-   **filepath** : Link to the list of vignettes

-   **repo**: Repository used in the script

#### Input data and extract package names

Input the list of vignettes, normally as urls, the script will split the url and
extract the package names.
Package names are normally found at the beginning of the url, then we extract
that column and check for unique names, so that we have a package list where no
package name is repeated.

Example from the script code:
`packageNames <- unique(vignettes$V1)`

#### Get packages in specified Bioconductor version

We will then want to have a list of packages that are in the specified
Bioconductor version. This will help us know which packages need to be worked
on.

#### Get the package maintainer

To know if a package is ready to be worked on or needs further action, we will
check for the maintainer. Below, we are checking for packages that are
maintained by bioconductor core team.

`coreMaintained <- biocMaintained()$Package`

If it is maintained by bioconductor then it is ready to be converted if not we 
will need to contact the maintainer first.

#### Creating the final list to be used

For every package, their rank, priority, action category and status is
computed. This is the output that we want from the script which will help us
categorize the packages.


-   **Rank** : The rank of the package as compared to all other packages

-   **Priority** : Based on rank and the threshold given in the script, is the 
packages a high or low priority package.

-   **Action** : Does the package need conversion or not.

-   **Status**: Is the package ready to be converted or needs more steps like 
contacting the maintainer.

#### Output from the script
The desired output is an excel file because it will be easy to use, export and 
also share. The final list is converted to a data frame then output as an excel 
file.
