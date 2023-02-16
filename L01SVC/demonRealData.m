clear all; clc; close all;
addpath(genpath(pwd));
% Inputs:
%       X    -- the sample data, dimension, \in\R^{m-by-n}; (required)
%       y    -- the classes of the sample data, \in\R^m; (required)
%               y_i \in {+1,-1}, i=1,2,...,m
%       pars -- parameters (optional)
%               
% pars:     Parameters are all OPTIONAL
%               pars.alpha   --  Starting point of alpha \in\R^m,  (default, zeros(m,1)) 
%               pars.C       --  A positive scalar in (2^-7,2^-6,...,2^7).(default, 1) 
%               pars.sigma   --  A positive scalar in (sqrt(2)^-7,...,sqrt(2)^7).(default, 1) 
%               pars.maxit   --  Maximum number of iterations, (default,1000) 
%               pars.tol     --  Tolerance of the halting condition, (default,1e-3)
%
% Outputs:
%     Out.iter:          Number of iterations
%     Out.time:          CPU time
%     Out.wb:            The solution of the primal problem, namely the classifier
%     Out.u:             The solution u
%     Out.lam:           The solution lambda
%     Out.alpha:         The solution alpha
%     Out.nsv:           Number of support vectors 
%     Out.s:             Sparsity level of the solution Out.alpha
%     Out.acc:           Classification accuracy
%     Out.error:         Classification error
%%%%%%%    The code was based on the algorithm proposed in
%%%%%%%    H.J. Wang, Y.H. Shao, S.L. Zhou, C. Zhang and N.H. Xiu, 
%%%%%%%    Support Vector Machine Classifier via L_{0/1}Soft-Margin Loss,
%%%%%%%    arXiv:1912.07418, 2019  
%%%%%%%    Warning: accuracy may not be guaranteed!!!

load Australian
X      = normalization(X,2);
y      = Y;  y(y~=1)= -1;  
[M,n]  = size(X);         
X      = normalization(X,2); % normalize the data
 
% randomly split the data into training and testing data
m  = ceil(0.9*M);  mt = M-m;       I  = randperm(M);
Tt = I(1:mt);      Xt = X(Tt,:);   yt = y(Tt);   % testing  data 
T  = I(1+mt:end);  X  = X(T,:);    y  = y(T,:);  % training data
num= 0;
fprintf('--------------------------------------------------------------\n');
fprintf('  C     sigma    Iter    tACC      NSV      TIME        Error  \n');
fprintf('--------------------------------------------------------------\n');
 for i     = -7:1:7
pars.C     = 2^i;
for  j     = -7:1:7
pars.sigma = sqrt(2)^j;
out        = L01ADMM(X,y,pars); 
wb         = out.wb;
if out.flag==1 % out.flag=1 if L01ADMM convergence
   tACC    = accuracy(Xt,yt,wb); num=num+1; % test accuracy
   fprintf('|%3.2f|  |%3.2f|  |%3d|  |%6.4f|  |%3d|  |%5.3fsec|  |%5.2e|\n',...
    pars.C, pars.sigma, out.iter,tACC,out.nsv,out.time,out.error);
end
 end
 end
% fprintf('Support Vector:        %d\n',out.nsv);
% fprintf('Training Accuracy:     %6.4f\n', accuracy(X,y,wb)) 
% fprintf('Testing  Accuracy:     %6.4f\n', accuracy(Xt,yt,wb));
% fprintf('Training Time:         %5.3fsec\n',out.time);

