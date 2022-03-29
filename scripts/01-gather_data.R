## ACQUIRE DATA ##
# The purpose of this script is to obtain and download our dataset

# TODO: REMOVE ANY UNUSED LIBRARIES
library(janitor)
library(pdftools)
library(purrr)
library(tidyverse)
library(stringi)
library(readr)
library(plyr)

# CODE TO DOWNLOAD PDF (save it in inputs/)
download.file(
  "https://dhsprogram.com/pubs/pdf/FRIND1/FRIND1.pdf", 
  "inputs/India National Family Health Survey 1992-1993.pdf",
  mode="wb"
)

raw_pdf <- pdf_text("inputs/India National Family Health Survey 1992-1993.pdf") |>
  read_lines()

raw_table <- raw_pdf[1099:1212] # the section of the pdf with our table (spans 2 pages)

raw_table <- tibble(raw_table)

write.csv(raw_table, "inputs/data/raw_data.csv", row.names=FALSE)


## END OF SCRIPT ##