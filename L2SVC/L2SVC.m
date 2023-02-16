function [ PredictY , model ] = L2SVC( TestX , DataTrain , Para )
% Solving weighted [L2-SVC] via quadratic programming
% _______________________________ Input  _______________________________
%      DataTrain.X  -  m x n matrix, explanatory variables in training data 
%      DataTrain.Y  -  m x 1 vector, response variables in training data 
%      TestX   -  mt x n matrix, explanatory variables in testing data 
%      Para.p1  -  lambda, the regularization parameter, equal to 1/C 
% ______________________________ Output  ______________________________
%     PredictY  -  mt x 1 vector, predicted response variables for testing data 
%     model  -  model related info: alpha, b, nSV, time, etc.

% Adjusted by Lingwei Huang, lateset update: 2021.05.12. 

%%  Initilization 
    X = DataTrain.X;    Y = DataTrain.Y;    clear DataTrain
    kpar = Para.kpar; 
    lam = Para.p1;

    [m,~] = size(X);    e = ones(m, 1); 
    K = kernelfun(X,kpar,X);    K = (K+K')/2;
    K_lam = K + lam*diag(e); % K + 1/C * diag(m)
    IY = diag(Y);
    tol = 1e-4;

    LB = zeros(m,1);
    options = optimoptions('quadprog','Display', 'off');

%%  Solving QP problem 
    training_time = tic; 
    alpha = quadprog( IY*K_lam*IY, -e,[],[], Y',0 ,LB,[],[], options ); %■
    tr_time = toc(training_time); 
    
    ind = alpha > tol;      alpha(~ind) = 0; 
    b = mean(  Y(ind) -  K_lam(ind,ind) * (alpha(ind).*Y(ind))  );

%% Prediction 
    alpha = alpha.*Y;
    alphab = [ alpha ; b ];

    [mt,~] = size(TestX);
    et = ones(mt,1);
    Kt = kernelfun(TestX,kpar,X);
    wxb = [Kt et] * alphab;
    PredictY = sign( wxb );
    
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



