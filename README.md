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

This is a script that will categorize a list of packages with Sweave vignettes.
The vignettes are categorized to determine which vignettes need work on the
sweave2rmd project board. The script takes a list of vignettes for a given
version of Bioconductor for a given repo with respect to a threshold value
provided.

### How to use the script

#### Declare variables and settings

Declare the variables to be used in the script and call the relevant libraries.

- **threshold**: the variable used to classify a package as a
high-priority or low-priority package. The threshold is set to a certain number,
example in our script is 40, this means that any package that has a rank below
40 is considered a high-priority package. The lower the rank number, the higher
the priority.

- **version** : The Bioconductor version that will be used in the script.

- **filepath** : Path to a file listing the full path of vignettes; e.g.,
    ```
    # Example data
    ABSSeq/vignettes/ABSSeq.Rnw
    ABarray/vignettes/ABarray.Rnw
    ABarray/vignettes/ABarrayGUI.Rnw
    ```

- **repo**: Repository used in the script

#### How to run the script

Run this command in your terminal `Rscript categorize_vignettes.R`

The syntax remains same for Windows/MacOS/Linux/Ubuntu.

**Note**: Open a Terminal from the location of the script for the command to work.

#### Output of the script

For every package, their rank, priority, and status are computed. This is the
output that we want from the script, which will help us categorize the packages.

-  **rank** : The rank of the package as compared to all other packages

-  **priority** : Based on rank and the threshold given in the script, is the
package a high or low priority package.

- **status**: Is the package ready for conversion or do additional steps, such 
as contacting the maintainer are needed.

For vignettes not in the specified version, the rank, priority and action are
not computed. Their status is specified as deprecated which helps know which
vignettes are no longer maintained or used.

The results from the script are output as an excel file. The desired output is
an excel file because it will be easy to use, export and also share.

