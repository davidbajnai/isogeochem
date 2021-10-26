## R CMD check results

0 ERRORs | 0 WARNINGs | 0 NOTES.

## Test environments

### Local:
* macOS 11.6, R 4.1.1

### rhub
* Windows Server 2008 R2 SP1, R-devel, 32/64 bit
* Fedora Linux, R-devel, clang, gfortran
* Ubuntu Linux 20.04.1 LTS, R-release, GCC

## Resubmission

This is a resubmission. In this version I have:
* deleted internal links in the README
* corrected unspecified unicode characters
* corrected the codecov link

```
CRAN teams' auto-check service
Flavor: r-devel-windows-ix86+x86_64
Check: CRAN incoming feasibility, Result: NOTE
 Possibly misspelled words in DESCRIPTION:
   fractionation (16:41)
   paleothermometry (17:15)
```
Words are spelled correctly.

```
 Found the following (possibly) invalid URLs:
   URL: https://codecov.io/gh/davidbajnai/isogeochem (moved to https://app.codecov.io/gh/davidbajnai/isogeochem)
     From: README.md
     Status: 200
     Message: OK
```
Link pointing to codecov was fixed.

```
 Found the following (possibly) invalid file URI:
   URI: isogeochem_manual.pdf
     From: README.md
```
Link removed.

```
Flavor: r-devel-windows-ix86+x86_64
Check: PDF version of manual, Result: WARNING
 LaTeX errors when creating PDF version.
 This typically indicates Rd problems.
 LaTeX errors found:
 ! Package inputenc Error: Unicode char Ã¢ÂÂ (U+2010)
 (inputenc)                not set up for use with LaTeX.

 See the inputenc package documentation for explanation.
 Type  H <return>  for immediate help.
 ```
The error was caused by a non-breaking hyphen in the documentation. It is now deleted.

```
Flavor: r-devel-linux-x86_64-debian-gcc
Check: CRAN incoming feasibility, Result: NOTE
   URL: https://zenodo.org/badge/latestdoi/401782303
     From: README.md
     Status: Error
     Message: Operation timed out after 151 milliseconds with 0 bytes received
```
Zenodo is having network issues but the link is correct.
