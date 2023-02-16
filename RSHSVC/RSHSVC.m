function [ PredictY , model ] = RSHSVC ( TestX , DataTrain , Para )
% Matlab code for solving RSHSVC in: 
% Y. Feng, Y. Yang, X. Huang, S. Mehrkanoon, J. A.K. Suykens. 
% Robust Support Vector Machines for Classfication with 
% Non-convex and Smooth Losses [C]/[J]. 
% Internal Report, KU Leuven, Leuven, Belgium, 2015.
% Neural Computation, 2016: 1-31. 
% Written by: Yunlong Feng, Email: yunlong.feng@esat.kuleuven.be
% _______________________________ Input  _______________________________
%      DataTrain.X  -  m x n matrix, explanatory variables in training data 
%      DataTrain.Y  -  m x 1 vector, response variables in training data 
%      TestX   -  mt x n matrix, explanatory variables in testing data 
%      Para.p1  -  lambda, the regularization parameter, equal to 1/C 
%      Para.p2  -  sigma, the scale parameter in the loss function 
%      Para.kpar  -  kernel type and parameter value
% ______________________________ Output  ______________________________
%     PredictY  -  mt x 1 vector, predicted response variables for testing data 
%     model  -  model related info: alpha, b, nSV, time, etc.

% Adjusted by Lingwei Huang, lateset update: 2021.05.12. 
% Named Rescaled Squared Hinge SVC, or Rescaled L2 SVC. 

%%  Initilization  
    X = DataTrain.X;    Y = DataTrain.Y;    clear DataTrain
    kpar = Para.kpar;
    lam = Para.p1; % 2^[-8:8]
    sig = Para.p2;  % 2^[-2:2]
    sig2 = sig^2;
    
    [m,~] = size(X);
    K = kernelfun(X,kpar,X);    K = (K+K')/2;
    wt0 = ones(m, 1); % initial weight_vector in L2-loss
    e = ones(m, 1); 
    tol = 1e-4;
    maxiter = 100;

    alphab = wL2_SVM( K , Y , lam , wt0 ); % ■ L2-SVM's alphab is chosen as the initial in solving RSHSVC.

    % =◆Loss Function Switch◆=
%         loss = 'Example_1'; % one-sided x loss
        loss = 'Example_2'; % one-sided Cauchy loss
    
%% Iteration (Solving rs-SVM via sovling weighted L2-SVM iteratively)
    training_time = tic; 
    for iter = 1 : maxiter
        alphab_k = alphab;
        hinge = max( 0 , 1 - Y.*([K e] * alphab)  );
        if strcmp(loss,'Example_1')
            wt = 2 * exp( - hinge.^2 / sig2 );
        elseif strcmp(loss,'Example_2')
            wt = 2 * sig2 ./ (sig2 + hinge.^2);
        end
        alphab = wL2_SVM( K, Y, lam, wt ); % ■
        if norm( alphab_k - alphab ) < tol, break, end
    end
    tr_time = toc(training_time); 
    clear K Y lam wt hinge alphab_k
%     iter
%% Prediction 
    [mt,~] = size(TestX);
    et = ones(mt,1);
    Kt = kernelfun(TestX,kpar,X);
    wxb = [Kt et] * alphab;
    PredictY = sign( wxb );
    
    alpha = alphab(1:end-1);
    n_SV = sum( alpha~=0 );
    model.tr_time = tr_time;
    model.alpha = alpha;
    model.b = alphab(end); 
    model.n_SV = n_SV;
    if Para.drw == 1
        drw.ds = wxb;
        drw.ss1 = drw.ds - 1;
        drw.ss2 = drw.ds + 1;
        model.drw = drw;
        model.twin = 0;
    end
end





