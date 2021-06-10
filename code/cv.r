# AIC table
# import library
library(mgcv)
library(stats)

# input data
input <- read.csv("../data/covid-19_elisa_74_OD_logNT.tsv", sep ="\t", header=TRUE)

# import module
run_d3_plot <- modules::use("./d3_plot.R")

# set #1
cv1_test <- sample(1:nrow(input), 0.2*nrow(input))
cv1 <- input[-cv1_test, ] 
temp <- input[-cv1_test, ]
write.csv(cv1, file="../output/cv1.csv" )
run_d3_plot$d3_plot("gam", cv1, "../output/cv1.csv", "../output/cv1.pdf")

# set #2
cv2_test <- sample(1:nrow(temp), 0.25*nrow(temp))
cv2 <- input[-cv2_test, ] 
temp <- temp[-cv2_test, ]
write.csv(cv2, file="../output/cv2.csv" )
run_d3_plot$d3_plot("gam", cv2, "../output/cv2.csv", "../output/cv2.pdf")

# set #3
cv3_test <- sample(1:nrow(temp), 0.33*nrow(temp))
cv3 <- input[-cv3_test, ] 
temp <- temp[-cv3_test, ]
write.csv(cv3, file="../output/cv3.csv" )
run_d3_plot$d3_plot("gam", cv3, "../output/cv3.csv", "../output/cv3.pdf")

# set #4
cv4_test <- sample(1:nrow(temp), 0.5*nrow(temp))
cv4 <- input[-cv4_test, ] 
temp <- temp[-cv4_test, ]
write.csv(cv4, file="../output/cv4.csv" )
run_d3_plot$d3_plot("gam", cv4, "../output/cv4.csv", "../output/cv4.pdf")

# set #5
cv5_test <- sample(1:nrow(temp), nrow(temp))
cv5 <- input[-cv5_test, ] 
write.csv(cv1, file="../output/cv5.csv" )
run_d3_plot$d3_plot("gam", cv5, "../output/cv5.csv", "../output/cv5.pdf")
