# Title: Quantifying neutralizing antibodies in patients with COVID-19 by two-variable generalized additive model

- **Two-variable generalized additive model (GAM) serves as a surrogate to quantify neutralizing antibody titer.**

## Citing this work

- If you use this repo, please cite: mSphere 2022 Feb 2;e0088321. doi: 10.1128/msphere.00883-21

## Development environment

- **R version 3.6.1 (2019-07-05)**
- **Platform: x86_64-apple-darwin15.6.0 (64-bit)**
- **Running under: macOS Catalina 10.15.2**
- **Package requirements and versions:**
	- ggplot2_3.3.3
	- cowplot_1.1.1
	- mgcv_1.8-35
	- magick_2.7.2
	- modules_0.10.0
	- ggpubr_0.4.0

## Input and output files

- **Input (data folder)**
	- **covid-19\_elisa\_74_OD\_logNT.tsv**: include real NT titer and ELISA OD values of S1 and RBD.
	- **covid-19_infection.tsv**: include the information of SARS-CoV-2 postive and negative cases and their ELISA OD values of S1 and RBD

- **Output (output folder)**
	- figures in manuscript (fig2.pdf and fig2a-2f.pdf)
	- predication of linear regression and GAM (fig3e.csv and fig3f.csv)
	- raw data and GAM plots of cross validation (cv\_data\_in_paper/cv\*.csv and cv\*.pdf)

	
## Usage and command lines

- The main program includes three different modules, which were used to generate two-variable GAM plot (d3\_plot.r) and linear regression (r2\_plot.r) for predicting NT titers, and dot plot for comparing SARS-CoV-2 postive and negative cases (dot\_plot.r). Command lines are as follows.

```
Rscript main.r
```

- run the Akaike Information Criterion (AIC) to compare different models, and save output as aic_table.csv

```
Rscript aic.r
```

- run five-fold cross validation of gam
 
```
Rscript cv.r
```

## Acknowledgement
- This work was financially supported by the Research Center for Emerging Viral Infections from The Featured Areas Research Center Program within the framework of the Higher Education Sprout Project by the Ministry of Education (MOE) in Taiwan and the Ministry of Science and Technology (MOST), Taiwan (MOST 110-2634-F-182-001、MOST 109-2327-B-182-002).