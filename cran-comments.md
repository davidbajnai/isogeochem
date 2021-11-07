## Comments from CRAN

```
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)

devtools::install_github("davidbajnai/isogeochem")

# in your vignette clearly violate the CRAN Policy, so pls fix ASAP.
```
Thanks, done!

## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES.

## Test environments

### Local:
* macOS 12.0.1, R 4.1.2, x86_64-apple-darwin17.0

### rhub
* Windows Server 2008 R2 SP1, R-devel, 32/64 bit
* Debian Linux, R-devel, GCC
* Fedora Linux, R-devel, clang, gfortran
* Ubuntu Linux 20.04.1 LTS, R-release, GCC

## Comments
* All links are correct in the package. However, in case of a server error, the Zenodo and DOI links may prompt a WARNING.
