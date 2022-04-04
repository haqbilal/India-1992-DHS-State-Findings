# India-1992-DHS-State-Findings

This paper contains the R project used in creating the paper "Now that's fresh water: Trends in India from the 1992 Demographic and Health Survey". 

Abstract: Third world countries often struggle with figuring out where the needs of their people lie. Analysis of large datasets can help shed some light on the issue. We obtain a dataset from the National Family Health Survey in India, hosted by the Demographic and Health Surveys program in the U.S. In a reproducible way, we convert this dataset from the 1990s into a usable digital format, and analyze it. In doing so, we conclude that acquiring a large dataset and using it to establish policies should be a primary goal of developing countries that want to improve their economic conditions.

The repository contains three folders: inputs, outputs, and scripts.

Inputs:

    Data: the raw and cleaned data csv files as obtained from the pdf of the original NFHS 1992 final report
    The report itself

Outputs:

    Materials: Graphs and images used in the paper
    Paper: R Markdown, a pdf version, and a complete bibliography

Scripts:

    00-simulation.R: The purpose of this script is to simulate some data that we might find in the DHS Final Report
    01-gather_data.R: The purpose of this script is to obtain and download our dataset
    02-clean_and_prepare_data.R: The purpose of this script is to clean the raw data output

How to generate the paper
    
    Download the repository's main folder
    Open India-1992-DHS-State-Findings.Rproj in RStudio
    Install libraries using install.packages() and run webshot::install_phantomjs() in the console so the DAGs compile
    Run 01-gather_data to download the pdf report and obtain the dataset from it and save it in raw_data.csv
    Run 02-clean_and_prepare_data.R to clean the data and save it in cleaned_data.csv
    Knit paper.Rmd to reproduce the paper



