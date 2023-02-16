function model = RampSVC3CP( DataTrain , Para )
% % The core training procedure for RampSVC_1
% % Modified by Wei-Jie Chen & Ling-Wei Huang.
% % Latest Update: 2021.04.25

%% Initialization

    kpar = Para.kpar;
    C = Para.p1; 
    s = Para.p2; % 
    X = DataTrain.X;    Y = DataTrain.Y;
    [m,~] = size(X);    diag_Y = diag(Y); 
    
    beta = zeros(m,1); 
    e = -ones(m,1); 
    Maxiter = 1e2;
    tol = 1e-6; 

    Q = diag_Y * kernelfun(X,kpar) * diag_Y;
    Q = (Q+Q')/2; 
    options = optimoptions('quadprog', ... 
        'Algorithm', 'interior-point-convex', 'Display', 'off');

    tt = tic; 
%% Iteration

    for iter = 1 : Maxiter
        LB = zeros(m,1) - beta; 
        UB = C*ones(m,1) - beta; 
        [alpha,~] = quadprog(Q,e,[],[],Y',0.0,LB,UB,[],options);

        logi_SV = abs(alpha)> tol;
        SV.X = X(logi_SV,:); 
        SV.Y = Y(logi_SV);
        n_SV = sum(logi_SV); 
        
        alph0 = alpha(logi_SV); % alpha > 0
        alphc = alph0 < C - tol; % alpha < C 
        betak = zeros(m,1);
        if strcmp(kpar.type,'lin')
            w = SV.X' * (alph0 .* SV.Y); 
            b = mean(SV.Y(alphc) - SV.X(alphc,:) * w); 
            mgn = (X * w + b) .* Y; 
        elseif strcmp(kpar.type,'rbf')
            w = (alph0 .* SV.Y);  
            b = mean( SV.Y(alphc) - ...
                    kernelfun( SV.X(alphc,:) , kpar , SV.X ) * w );
            mgn = (kernelfun(SV.X,kpar,X)' * w + b) .* Y;
        end
        betak(mgn < s) = C;

        if norm(betak - beta) < tol, break, end
        beta = betak;
%         StopWatch = toc(tt);
%         if StopWatch > 10 % 3600
%             TimeFlag = 1;
%             fprintf('the time of once iter is longer than 2h.\n');
%             break
%         end
    end % iter end

% aa = (X * w + b) .* Y;
% ramp = @(z) max(1-z,0) + min(1+z,0);
% fval = 1/2 * (norm(w)^2) + c * sum(ramp(aa)); % f = 0.5*||w||^2 + C¡¤¦²¦Î


%% Output

    
    tr_time = toc(tt); 

    model.w = w;
    model.b = b;
    model.SV = SV;
    model.n_SV = n_SV; 
    model.tr_time = tr_time;



end