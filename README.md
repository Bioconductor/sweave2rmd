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

## Script to categorize vignettes

This is a script that will sort a list of vignettes to be converted from sweave
to Rmarkdown. The vignettes are sorted to help determine which vignettes need to
be worked on and also help categorize the vignettes in the sweave2rmd project
board. The script categorizes a list of packages in a given version of
Bioconductor for a given repo with respect to a threshold value provided.

### How to use the script

#### Declare variables and settings

Declare the variables to be used in the script and call the relevant libraries.

- **threshold**: the variable used to classify a package as a
high-priority or low-priority package. The threshold is set to a certain number,
example in our script is 40, this means that any package that has a rank below
40 is considered a high-priority package. The lower the rank number, the higher
the priority.

- **version** : The Bioconductor version that will be used in the script.

- **filepath** : Link to the list of vignettes

- **repo**: Repository used in the script

#### How to run the script

Pass the file containing the list of vignettes to be converted (which is the
filepath declared earlier) to the script and run the script.

#### Output of the script

For every package, their rank, priority, action category, and status are
computed. This is the output that we want from the script, which will help us
categorize the packages.

-  **Rank** : The rank of the package as compared to all other packages

-  **Priority** : Based on rank and the threshold given in the script, is the
packages a high or low priority package.

-  **Action** : Does the package need conversion or not?

- **Status**: Is the package ready for conversion or do additional steps, such 
as contacting the maintainer are needed.

The results from the script are output as an excel file. The desired output is
an excel file because it will be easy to use, export and also share.

