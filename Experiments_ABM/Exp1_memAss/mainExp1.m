clear all;
close all;
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%% ANOVA in R: 
% % % %%%%sample size n=33 per group with groups k=3, significance level 0.05,
% % % %%%%effect size 0.4 and statistical power .95 
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r=33*3;%replications
[M,W,DISTmem,mem]=numSignals_01(r);

