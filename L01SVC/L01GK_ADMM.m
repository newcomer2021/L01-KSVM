function  model = L01GK_ADMM ( DataTrain, Para )
% % Nonlinear Kernel Support Vector Machine with 0-1 Soft
% % Margin Loss[J]. JCAM
% % 
% % Modified by  Ling-Wei Huang. 
% % Latest Update: 2021.06.07. 

%% Input & Initialization
    X = DataTrain.X;         y = DataTrain.Y;    
    C = Para.p1;                sig = Para.p2; 
    eta = 1;                        % dual step-size 
    maxit = 1*1e2;               % the max # of iteration,1.8*1e2 is used for data sets adu and htr;
    tol = 1e-3;                   % tolerance level 
    
    [m,~] = size(X); 
    X_tilde = [ X , ones(m,1) ];
    Y = speye(m).*y; 
    K = kernelfun(X_tilde,Para.kpar,X_tilde);  
    K = K + speye(m)*1e-6; % K+eye
    K_tilde = Y*K*Y ; 
%     K_inv = inv(K_tilde);     % used in eq(26)

    lam = zeros(m,1);      % lambda 
    alph = 0.01*ones(m,1); % alpha
    clear DataTrain y X_tilde Y
    
%% ADMM Iteration 
    training_time = tic; 
    for iter = 1 : maxit 
        
% _____Updating u & Working Set T_____
        zk = 1 + K_tilde*alph - lam/sig;    % z=1+K*alph-lam/sig
        [ u , T ] = L01_Prox( zk , C , sig );
        lTl = length(T); % len of WS
        sc = setdiff(1:m,T); 

% _____Updating alph_____
        Ks = K_tilde(T,:);
        if lTl == 0
                T = 1;
                Ks = K_tilde(T,:);
                alph = ones(m,1);
        else 
            v =  u(T) - 1 + lam(T)/sig;
            % Analytic solution
% % %             alph = (K_tilde/sig + Ks' * Ks) \ Ks' * v; % eq(25)
% %             alph = K_inv*Ks' / ( speye(lTl)/sig + Ks*K_inv*Ks' )*v;% eq(26)
% %             alph(sc)=0;
            % ConjGrad solution
            al = L01_CG ( K , Ks , sig , v , alph ); % ■Conjugate Gradient■
            alph = al;      % alph(sc)=0;
        end
        
% _____Updating lam_____
        varpi = u(T) - 1 - Ks * alph; 
        lam(T) = lam(T) + eta*sig*varpi; 
        lam(sc) = 0; 

% _____Stopping Criteria_____
        theta(1) = norm(varpi) / sqrt(m);
        theta(2) = norm(L01_Prox(u-alph/sig,C,sig) - u ) / (1+norm(u));
        THETA = max(theta);
        if THETA < tol, break, end

%         zz = u(T)-lam(T)/sig - varpi; % 
        zz = 1 + Ks*alph - lam(T)/sig; 
        mzp = min( zz(zz>0) );        % min z in ( 0 , sqrt(2C/sig) ]
        if isempty(mzp), mzp = 1e-8; end

       if mod(iter,5)==0
           if theta(1)>tol, sig = min(sig*1.75,10); Para.p1=0.8*Para.p1;; end % 
        if mAC
        end

        if sig > 2*C/mzp^2       % i.e. 0 < sqrt(2C/sig) < mzp, 0 workingset
            sig =1.75*C/mzp^2;  % enlarge ub: sqrt(2C/sig)
        end
   
   
    end % iter end
    trn_time = toc(training_time); 


%% Output 
    model.alph = alph;
    model.ind_SV = T;
    model.u = u;
    model.iter = iter;
    model.sig = sig;

    model.n_SV = lTl;
    model.tr_time = trn_time;

end % function end








