M = 10; p = 0.5; 
a1 = 3; b1 = 2;
a2 = -5; b2 = 7;
%% Direct Predicted / Expected Z Mean and Covariance
[Z_mean1, Z_cov1] = Direct_Binomial_Prediction(a1,b1)
[Z_mean2, Z_cov2] = Direct_Binomial_Prediction(a2,b2)