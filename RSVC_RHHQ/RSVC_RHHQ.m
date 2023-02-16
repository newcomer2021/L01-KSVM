function [ PredictY , model ] = RSVC_RHHQ( TestX , DataTrain , Para )
% Matlab code for solving RSVC-RHHQ in: 
% Guibiao Xu, Zheng Cao, Bao-Gang Hu, Jose C. Principe. 
% Robust support vector machines based on the rescaled hinge loss function [J].
% Pattern Recognition, 2017(63): 139-148. 

% Written by Lingwei Huang, lateset update: 2021.05.12. 

%%  Initilization  
    X = DataTrain.X;    Y = DataTrain.Y;    clear DataTrain
    C = Para.p1;           eta = Para.p3;        kpar = Para.kpar;

    [m,~] = size(X);    e = ones(m, 1); 
    IY = diag(Y);
    K = kernelfun(X,kpar,X);    K = (K+K')/2;
    YKY = IY * K * IY;      clear IY
    tol = 1e-4;         maxiter = 10;
    
    beta = 1 / ( 1-exp(-eta) ); 
    alpha = zeros(m,1);     b = 0;
    v = -ones(m,1);     % v<0
    hinge = @(z) max( 0 , 1-z );
    options = optimoptions('quadprog','Display', 'off');
    Aeq = Y';   beq = 0;
    lb = zeros(m,1); 

%% Iteration
    training_time = tic; 
    for iter = 1 : maxiter
        alphak = alpha;     bk = b;     vk = v;
        
        ub = C*beta*eta*(-v);
        alpha = quadprog( YKY , -e , [],[], Aeq , beq , lb , ub , [], options );
        ind = alpha > tol;      alpha(~ind) = 0; 
        b = mean(  Y(ind) -  K(ind,ind) * (alpha(ind).*Y(ind))  );
        wxb = [K , e] * [alpha.*Y ; b];
        v = - exp( -eta*hinge(wxb) );
        
        theta(1) = norm(alphak - alpha);
        theta(2) = norm(bk - b);
        theta(3) = norm(vk - v);
        THETA = max(theta);
        if THETA < tol, break, end
    end
    tr_time = toc(training_time); 
    clear K YKY wxb v ind lb ub Aeq e alphak bk vk theta

%%  Predictioin
    [mt,~] = size(TestX);
    et = ones(mt,1);
    Kt = kernelfun(TestX,kpar,X);
    wxb = [Kt , et] * [alpha.*Y ; b];
    PredictY = sign( wxb );

    n_SV = sum( alpha~=0 );
    model.tr_time = tr_time;
    model.n_SV = n_SV;
    if Para.drw == 1
        drw.ds = wxb;
        drw.ss1 = drw.ds - 1;
        drw.ss2 = drw.ds + 1;
        model.drw = drw;
        model.twin = 0;
    end
    
end










