---
title: "README"
author: "Igor Svibilsky"
date: "March 13, 2015"
output: html_document
---
## Getting and Cleaning Data Course Project

The folder contains the course project deliverables:

* **run_analysis.R**  - a script to perform cleaning and data transformation.
* **CodeBook.md** - a markdown file describing the input data and steps to transform it into tidy data.
* **README.md** - a markdown file providing a brief instruction to the User. 

Note: The script is developed and tested with RStudio Version 0.98.1102 on Intel Mac OS X 10.10.2 platform. 

## Instruction

1. Download the data archive from a location provided in the **CodeBook.md**
2. Unzip the content of the archive into "UCI HAR Dataset" folder on your local drive.
2. Put **run_analysis.R** script in the parent folder of "UCI HAR Dataset", then set it as your working directory using **setwd()** command.
3. Run a **source("run_analysis.R")** command. Upon completion the script will generate a new file **tiny_data.txt** in your working directory.

## Dependencies

The **run_analysis.R** script has a dependency on **dplyr** package