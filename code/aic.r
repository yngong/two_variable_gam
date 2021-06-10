# AIC table
# import library
library(mgcv)
library(stats)

input <- read.csv("../data/covid-19_elisa_74_OD_logNT.tsv", sep ="\t", header=TRUE)

# models of fig 2c, 2d, 2e, and 2f
fit_lm_S1 <-  stats::lm( NT ~ S1, data = input)
fit_lm_RBD <- stats::lm( NT ~ RBD, data = input)
fit_lm_S1_RBD <- stats::lm( NT ~ S1+RBD, data = input)
fit_gam_S1_RBD <- mgcv::gam( NT ~ s(S1, bs = 'cr', sp=0.6)+s(RBD, bs = 'cr', sp=0.6), data = input)

# smooth functions
fit_GCV_Cp <- mgcv::gam( NT ~ s(S1, bs = 'cr', sp=0.6)+s(RBD, bs = 'cr', sp=0.6), 
                       data = input, method="GCV.Cp")
fit_REML <- mgcv::gam( NT ~ s(S1, bs = 'cr', sp=0.6)+s(RBD, bs = 'cr', sp=0.6), 
                       data = input, method="REML")
fit_ML <- mgcv::gam( NT ~ s(S1, bs = 'cr', sp=0.6)+s(RBD, bs = 'cr', sp=0.6), 
                       data = input, method="ML")

# save to csv
aic_table <- AIC(fit_lm_S1, fit_lm_RBD, fit_lm_S1_RBD, fit_gam_S1_RBD, fit_GCV_Cp, fit_REML, fit_ML)
write.table(aic_table, "../output/aic_table.csv", sep = ",", append = FALSE, col.names = TRUE)
