clear all;
close all;
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%% Friedman in R: 
% % % %%%%sample size n=20 per group with groups k=4, significance level 0.05,
% % % %%%%effect size 0.4 and statistical power .95 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r=20*4;
%r=1;
[memW,equalizedW,MatMez]=numSignals_03(r);
%[sx,sy,sz]=size(M);
[indices]=RMSE_perm(MatMez,memW);
[equalizedW,memW]=alignMat(equalizedW,memW,indices);
