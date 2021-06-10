###
# Author: Yu-Nong Gong
# Purpose: Predicting NT titer
# 
# input files:
# covid-19_infection.tsv and covid-19_elisa_74_OD_logNT.tsv
#
# R codes:
# d3_plot.r, r2_plot.r, and dot_plot.r
# 
# R version 3.6.1 (2019-07-05)
# Platform: x86_64-apple-darwin15.6.0 (64-bit)
# Running under: macOS Catalina 10.15.2
# 
# Package versions:
#   ggplot2_3.3.3
#   cowplot_1.1.1
#   mgcv_1.8-35
#   magick_2.7.2
#   modules_0.10.0
#   ggpubr_0.4.0
###

# import library
library(ggplot2)
library(cowplot)
library(mgcv)
library(magick)
library(modules)
library(ggpubr)

# setup theme
my_theme <- theme_minimal()+theme(  plot.title = element_text(size=17), 
                    axis.text.y = element_text(size=15), 
                    axis.text.x = element_text(size=15),
                    axis.title.x = element_text(size=17), 
                    axis.title.y = element_text(size=17),
                    text=element_text(size=17),
                    legend.position = "none")

# figure 2a and 2b: dot plot
run_dot_plot <- modules::use("./dot_plot.r")
run_dot_plot$dot_plot(read.csv("../data/covid-19_infection.tsv", sep ="\t", header=TRUE), 
  "infection", "S1", my_theme, "../output/fig2a.pdf")
run_dot_plot$dot_plot(read.csv("../data/covid-19_infection.tsv", sep ="\t", header=TRUE), 
  "infection", "RBD", my_theme, "../output/fig2b.pdf")

# figure 2c and 2d: calculate r2
input <- read.csv("../data/covid-19_elisa_74_OD_logNT.tsv", sep ="\t", header=TRUE)
run_r2_plot <- modules::use("./r2_plot.r")
run_r2_plot$r2_plot(input, "S1", "NT", my_theme, "../output/fig2c.pdf")
run_r2_plot$r2_plot(input, "RBD", "NT", my_theme, "../output/fig2d.pdf")

# figure 2e and 2f: 3d plot using two variables
run_d3_plot <- modules::use("./d3_plot.R")
run_d3_plot$d3_plot("lm", input, "../output/fig2e.csv", "../output/fig2e.pdf")
run_d3_plot$d3_plot("gam", input, "../output/fig2f.csv", "../output/fig2f.pdf")

# combine figures
fig2 <- ggdraw() +
  draw_image(magick::image_read_pdf("../output/fig2a.pdf"), 
                  x = 0.05, y = 0.7, width = .45, height = 0.3) +
  draw_image(magick::image_read_pdf("../output/fig2b.pdf"), 
                  x = 0.55, y = 0.7, width = .45, height = 0.3) +
  draw_image(magick::image_read_pdf("../output/fig2c.pdf"), 
                  x = 0.05, y = 0.4, width = .45, height = 0.3) +
  draw_image(magick::image_read_pdf("../output/fig2d.pdf"), 
                  x = 0.55, y = 0.4, width = .45, height = 0.3) +
  draw_image(magick::image_read_pdf("../output/fig2e.pdf"), 
                  x = .0, y = .0, width = .55, height = .42)+
  draw_image(magick::image_read_pdf("../output/fig2f.pdf"), 
                  x = .5, y = .0, width = .55, height = .42)+
  draw_plot_label(label = c("(a)", "(b)", "(c)", "(d)", "(e)", "(f)"), size = 12, 
                  x = c(0.0, 0.5, 0.0, 0.5, 0.0, 0.5), 
                  y = c(.99, .99, .7, .7, .4, .4))
ggsave(file="../output/fig2.pdf", height=8, width=6, units=c("in"), dpi=1200, fig2)
