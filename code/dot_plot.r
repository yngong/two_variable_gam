import(ggplot2)
import(ggpubr)
import(grDevices)

dot_plot <- function( input_tsv, input_x, input_y, my_theme, output_pdf ){

  pdf(file = output_pdf, width=6, height=6)
  p<-ggplot(input_tsv, aes(x = .data[[input_x]], y = .data[[input_y]])) +
            geom_point(shape = 20, size = 5, position=position_jitter(0.3), 
            aes(color =  .data[[input_x]])) +
            stat_compare_means( method="t.test", size=6, label.y = 2.5) +
            xlab("")+
            ylim(0,3)+
            ylab(paste("\n",input_y,": Absorbance (450nm)"))+
            scale_color_manual(values = c("#EE6677", "#4477AA"))+
            geom_boxplot(aes(color=NULL), alpha=0.03, outlier.shape = NA)+
            my_theme

  print(p)
  dev.off()
}
