import(ggplot2)
import(ggpubr)
import(grDevices)
import(stats)
import(ggpmisc)

r2_plot <- function( input_csv, input_x, input_y, my_theme, output_pdf){

  pdf(file = output_pdf, width=6, height=5)
  p <- ggplot(input_csv, aes(x=.data[[input_x]], y=.data[[input_y]]) ) +
        geom_point(color="#4477AA", size=3) +
        xlim(0, 3)+
        ylab(paste("NT value\n (Linear regression using ",input_x,")"))+
        stat_smooth(method = lm, se=FALSE, color="black", formula = y ~ x)+
        stat_poly_eq(formula = x ~ y, 
                    aes(label = ..rr.label..), parse = TRUE, size=6)+
        my_theme

  print(p)
  dev.off()

}