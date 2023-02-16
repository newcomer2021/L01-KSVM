function [ alphab ] = wL2_SVM( K, Y, lam, wt )
% Solving weighted L2-SVM via quadratic programming
% _______________________________ Input  _______________________________
%      K - m x m matrix, kernel matrix computed on the training data
%      Y - m x 1 vector, response variable of the training data
%      lambda - regularization parameter
%      wt - m x 1 vector, the weight vector in wL2-loss
% ______________________________ Output  ______________________________
%      alphab  -  the coefficient-bias vector of the kernel-based classifier 

% Adjusted by Lingwei Huang, lateset update: 2021.05.11. 

%%  Initilization 
    K_lam = K + lam*diag(1./wt); % augmented Ker with regularization 
    m = length(Y);

    % =◆Algorithm Switch◆=
        algorithm = 'quadprog';
%         algorithm = 'cvx';

%%  Solving QP problem (eq 4.2)
    if strcmp(algorithm,'quadprog')
        e = -ones(m,1);     IY = diag(Y);   LB = zeros(m,1);
        options = optimoptions('quadprog','Algorithm', 'interior-point-convex','Display', 'off');
        alph = quadprog( IY*K_lam*IY , e ,[],[], Y' ,0 ,LB ,[],[], options );
    elseif strcmp(algorithm,'cvx')
        cvx_begin  quiet
            variable alph(m);
            maximize(  sum(alph) - 0.5*(alph.*Y)'*K_lam * (alph.*Y)  );
            subject to
                Y'*alph == 0;   alph >= 0;
        cvx_end
    end
    ind = alph > 1e-4;      alph(~ind) = 0; % manual truncation
    b = mean(  Y(ind) -  K_lam(ind,ind) * (alph(ind).*Y(ind))  );

%% Output
    alph = alph.*Y;
    alphab = [ alph ; b ];

end



