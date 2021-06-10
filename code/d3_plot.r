d3_plot <- function(model, input, output_csv, output_pdf){

# choose model
      if( model == "lm" ){
            fit <- stats::lm( NT ~ S1 + RBD, data = input)
      }else{
            fit <- mgcv::gam( NT ~ s(S1, bs = 'cr', sp=0.6)+s(RBD, bs = 'cr', sp=0.6), data = input, method="P-REML")
      }

      # calculate R2
      sst <- sum( (input$NT - mean(input$NT))^2 )
      r2 <- function(x) 1 - sum(x^2) / sst
      input$prediction <- stats::predict(fit, input)
      r2_value <- format(r2(input$prediction-input$NT), digits = 3)

      # setup a grid for persp
      steps <- 30
      S1 <- with(input, seq(min(S1), max(S1), length = steps) )
      RBD <-  with(input, seq(min(RBD), max(RBD), length = steps) )
      dat <- expand.grid(S1 = S1, RBD = RBD)
      NT <- matrix(stats::predict(fit, dat), steps, steps)

      # save as pdf
      grDevices::pdf(file = output_pdf, width=8, height=8)

      p <- graphics::persp(S1, RBD, NT, theta = 65, col = "#D9D9D9", 
            xlim = c(-1, 3), ylim = c(-1, 3), zlim =c(-2, 9), 
            zlab=paste("\n \n NT value\n (",model," using S1 and RBD)"), ticktype = "detailed", 
            font.lab=1.5, cex.lab=1.5, font.axis=1.5, cex.axis=1.5)

      # add R2 value
      graphics::text(grDevices::trans3d( .4,-.1,8,p), cex=1.5, expression( ~ italic('R')^2 ))
      graphics::text(grDevices::trans3d(1.1,.3,8,p), cex=1.5, paste0( "= ", r2_value) )

      # add points to this 3d plot
      obs <- with(input, grDevices::trans3d(S1, RBD, NT, p))
      pred <- with(input, grDevices::trans3d(S1, RBD, stats::fitted(fit), p))
      graphics::points(obs, col = "#4477AA", pch = 16, cex=2)

      # add lines to show the distance between real and predicted values
      graphics::segments(obs$x, obs$y, pred$x, pred$y)
      grDevices::dev.off()

      # output the prediction
      df <- data.frame( input$NT, stats::fitted(fit))
      utils::write.table(df, output_csv, append = TRUE, col.names = FALSE)

      return(r2_value)

}