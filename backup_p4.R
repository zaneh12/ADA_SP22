# ---
#   title: "ADA_P4"
# author: "Zane Hassoun"
# date: "2/15/2022"
# output: html_document
# ---
#   
#   {r setup, include=FALSE}
# knitr::opts_chunk$set(echo = TRUE)
# library(stats)
# library(mgcv)
# library(MRSea)
# library(tidyverse)
# # devtools::install_github("lindesaysh/MRSea", ref="stable")
# 
# 
# Objectives
# 
# In this practical, we will compare results when using a range of smoother-based approaches to an unevenly smooth function. The objective is to: Understand the tension between fitting models which generate predictions which are close to the data and fitting models which are "overfitted" to the data, i.e. the bias-variance trade-off.
# 
# {r}
# #Creating Two Functions
# #Residual Sum of Squares 
# #Mean Average Squared Error
# RSS = function(yObs, yFit){
#   # RSS: Compute the residual sums of squares
#   # yObs: the observed response y
#   # yFit: the fitted response y
#   return(sum((yObs - yFit)^2))
# }
# 
# ASE = function(yTruth, yFit){
#   # ASE: Compute the mean average squared error
#   # yObs: the observed response y
#   # yFit: the fitted response y
#   return(mean((yTruth - yFit)^2))
# }
# 
# Comparing Performance Across Methods
# 
# {r}
# df = read.csv("C:/Users/zaneh/Downloads/SimulatedData.csv")
# 
# 
# Polynomial Regression
# 
# 1. Fit a polynomial model (???? = 6) to each simulated dataset and compute and store the RSS and ASE metrics in each case. 2. Plot the simulated data, the fitted data and the true underlying function (????) to examine the model fits.
# 
# {r}
# 
# square_residuals = c()
# abs_residuals = c()
# fitted = c()
# for (i in seq(100))
# {
#   # Subset dataset
#   dfSub <- subset(df, ID %in% i)
#   poly_model = lm(response ~ poly(x, degree=6), data=dfSub)
#   predictions = predict(poly_model, subset(df, ID %in% i))
#   fitted = c(fitted, predictions)
#   sq_res = RSS(df$x, predictions)
#   abs_res = ASE(df$x, predictions)
#   square_residuals = c(square_residuals, sq_res)
#   abs_residuals = c(abs_residuals, abs_res)
# }
# 
# plot_1_data = data.frame("X" = df$x,
#                          "mu" = df$mu,
#                          "response" = df$response,
#                          fitted,
#                          square_residuals,
#                          abs_residuals,
#                          ID = df$ID)
# 
# ggplot(data = plot_1_data) + 
#   geom_point(aes(x = X,
#                  y = response,
#                  color = 'Observed')) +
#   geom_point(aes(x = X,
#                  y = fitted,
#                  color = 'Fitted')) + 
#   geom_smooth(aes(x = X,
#                   y = mu,
#                   color = 'Underlying'),
#               size = 1.5)+
#   labs(title = "Polynomial Model",
#        y = "Observed/Mu/Fitted")+
#   scale_color_manual(name='Polynomial Model',
#                      breaks=c('Fitted', 'Observed', 'Underlying'),
#                      values=c('Fitted'='red', 'Observed'='black', 'Underlying'='blue'))
# 
# 
# Penalised Regression Splines
# 
# 3. Fit a penalised regression spline (using mgcv::gam(.)) to each simulated dataset and compute and store the RSS and ASE metrics in each case. 4. Plot the simulated data, the fitted data and the true underlying function (????) to examine the model fits.
# 
# {r}
# 
# sr2 = c()
# ar2 = c()
# f2 = c()
# 
# 
# 
# for (i in seq(100)){
#   # Subset dataset
#   df2 <- subset(df, ID %in% i)
#   m2 = gam(response ~ s(x),
#            data=dfSub)
#   p2 = predict(m2, subset(df, ID %in% i))
#   f2 = c(f2, p2)
#   sq_res = RSS(df2$x, p2)
#   abs_res = ASE(df2$x, p2)
#   sr2 = c(sr2, sq_res) 
#   ar2 = c(ar2, abs_res)
# }
# 
# 
# plot_2_data = data.frame("X" = df$x,
#                          "mu" = df$mu,
#                          "response" = df$response,
#                          f2)
# 
# ggplot(data = plot_2_data) + 
#   geom_point(aes(x = X,
#                  y = response,
#                  color = 'Observed')) +
#   geom_point(aes(x = X,
#                  y = f2,
#                  color = 'Fitted')) + 
#   geom_smooth(aes(x = X,
#                   y = mu,
#                   color = 'Underlying'),
#               size = 1.5)+
#   labs(title = "Penalised Spline Model",
#        y = "Observed/Mu/Fitted")+
#   scale_color_manual(name='Penalised Spline Model',
#                      breaks=c('Fitted', 'Observed', 'Underlying'),
#                      values=c('Fitted'='red', 'Observed'='black', 'Underlying'='blue'))
# 
