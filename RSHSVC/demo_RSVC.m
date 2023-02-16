function [alpha, b] = demo_RSVC( X_train, Y_train, K, lambda, sig)
% Matlab code for solving RSVC in [1].
% Written by: Yunlong Feng, Email: yunlong.feng@esat.kuleuven.be

% Reference:
% [1] Y. Feng, Y. Yang, X. Huang, S. Mehrkanoon, J. A.K. Suykens. Robust Support
%     Vector Machines for Classfication with Non-convex and Smooth Losses,
%     Internal Report, KU Leuven, Leuven, Belgium, 2015.


% ======================   Input  =========================================
%      X  -  N x P matrix, explanatory variables in traing data
%      Y  -  N x 1 vector, response variables in training data
%      K  -  N x N matrix, the kernel Gram matrix
% lambda  -  the regularization parameter
% delta   -  the scale parameter in the loss function


% ======================   Output  ========================================
% alpha -  the coefficient vector of the kernel-based classifier
%     b -  the offset of the kernel-based classifier

    load('E:\Lingwei_Huang\!Pro_Materials\!CODE\SVMTestBedForSVC\SVMFun\Echo.mat')
    lam=1;sig=1;K=X*X';TestX=X;Kt=TestX*X';[mt,~]=size(TestX);et=ones(mt,1); 
% ====================== Initilize  =======================================
    sig2 = sig^2;
    [m,~] = size(X);
    wt0 = ones(m, 1);
    alpha_0 = zeros(m+1, 1);
    iter_number = 0;

% =====================  Initial Guess ====================================
% The solution to L2-SVM is chosen as the initial guess in solving RSVC.

    alpha = wL2_SVM(K, Y, lam, wt0);

% ======== Solving rs-SVM via sovling weighted L2-SVM iteratively ========= 
max_iter = 100;

while (norm(alpha_0 - alpha) > 1e-4 && iter_number < max_iter);
    
    alpha_0 = alpha;
    offset = alpha_0(end);
    coefficient = alpha_0(1:end-1);
    hinge = max(0,(1 - Y.*(K*coefficient + offset*ones(m,1))));
    % updating the weight obtained by using the classification loss in Example 2:
%     wt = exp(- hinge.^2/ sig2);
    
    % updating the weight obtained by using the classification loss in Example 1:
    wt = sig2./(2 + hinge.^2);
    alpha = wL2_SVM(K, Y, lam, wt);
    
    iter_number = iter_number + 1;
end

b = alpha(end);
alpha = alpha(1:end-1);

wxb = [Kt et] * alpha;
PredictY = sign( wxb );
sum(PredictY==Y)


function [output_alpha, offset] = wL2_SVM(K, Y, lambda, w)
% Solving weighted L2-SVM via quadratic programming

% ==========================   Input  =====================================
%      K - N x N matrix, kernel matrix computed on the training data
%      Y - N x 1 vector, response variable of the training data
% lambda - regularization parameter
%      w - N x 1 vector, the weight vector


% ======================   Output  ========================================
% output_alpha -  the coefficient vector of the kernel-based classifier in
%                    each subproblem
%    offset    -  the offset of the kernel-based classifier in each
%                    subproblem


% ========================== Initilize ====================================
% augmented kernel matrix with the regularization term
K_lambda = K  + lambda*diag(1./w);


sample_size = length(Y);

% Solve the QP problem by using quadprog:
% yy = ones (sample_size,1);
% options = optimset('Display','none');
% con_alpha = quadprog (diag(Y)*K_lambda*diag(Y), -yy, [], [], Y', 0, 0,[], [], options);


% Solve the QP problem by using CVX:
cvx_begin  quiet

variable con_alpha(sample_size);
maximize(sum(con_alpha) - 0.5*(con_alpha.*Y)'*K_lambda * (con_alpha.*Y));
subject to
Y'*con_alpha == 0;
con_alpha >= 0;

cvx_end


% Determin the offset by averaging over the support vectors
index_sv = find(abs(con_alpha) > 0.0001);

if isempty(index_sv)
    offset = 0;
else
    offset = (sum(Y(index_sv)) - (con_alpha(index_sv).*Y(index_sv))' * K(index_sv,...
        index_sv)*ones(length(index_sv),1))/length(index_sv);
end

output_alpha = con_alpha.*Y;

