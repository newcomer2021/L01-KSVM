function [Predict_Y,model] = demo_RSVCRHHQ(TestX,DataTrain,Para)


X = DataTrain.X;    Y = DataTrain.Y;    clear DataTrain
[n,m] = size(X);
c = Para.p1;
eta = Para.p3;
kpar = Para.kpar;


%% Iteration

% % %   0: Initialize w and b
if strcmp(kpar.type,~'lin')
    X = kernelfun(X,kpar);
end
diagY = diag(Y);
H = diagY * (X*X') * diagY + eps*eye(n); %
H = (H + H')/2;
f = -ones(n,1); 
A = [];
b = [];
Aeq = Y';
beq = 0;
lb = zeros(n,1);
ub = -c*f;
a0 = 0;
options = optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
alpha = quadprog(H,f,A,b,Aeq,beq,lb,ub,a0,options);
w = X' * (alpha .* Y);
bias = mean(Y - X * w);
% % w = -ones(m,1);
% % bias = 1;


% % %   1: Construct K using k(x_i,x_j);
%     if strcmp(kpar.type,~'lin')
%         X = kernelfun(X,kpar);
%     end
%     H = X*X' + eps*eye(n);   % K
%     H = (H + H')/2;
    

% % %   2: Set s:=0, and initialize v^s;
    s = 0;
    S = 10;

    v = zeros(n,1);
    beta = 1/(1-exp(-eta));
        
    
% % %   3: while s < S do
%     f = -ones(n,1);          %%%%% 将常量的赋值放在循环外，加速
%     A = [];
%     b = [];
%     Aeq = Y';
%     beq = 0;
%     lb = zeros(n,1);
%     ub = zeros(n,1);
%     a0 = [];
%     w = X' * (-f .* Y);
%     bias = c;

    while s<S               %■■■■■■■■■■■■■■■■■■
        z = X * w + bias.*-f;


% % %   4: Obtain (a^(s+1),b^(s+1)) by solving (14)
    for i=1:n
       if (1-z(i,1)>0)
            v(i) = -exp(-eta*(1-z(i,1)));
        else
            v(i) = -1;
        end
    end
    ub = c * (eta * beta) * -v;

    options = optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
    alpha = quadprog(H,f,A,b,Aeq,beq,lb,ub,a0,options);
    
    w = X' * (alpha .* Y);
    bias = mean(Y - X*w);
%     w = alpha(1:end-1);
%     bias = alpha(end);
    
    
% % %   5: Updata v^(s+1) according to (11) and (15)
%     z = X * w + bias;
%     for i=1:n
%        if (1-z(i,1)>0)
%             v(i) = -exp(-eta*(1-z(i,1)));
%         else
%             v(i) = -1;
%         end
%     end
    
    
% % %   6: Set s:=s+1
    s = s+1;
    
    
% % %   7: end while  
    end
    
    
% % %   8: return a=a^s and b=b^s


%%  Predict
[m,~] = size(TestX);

if strcmp(kpar.type,~'lin')
    TestX = kernelfun(TestX,kpar,X);
end

DrawY.Y3 = TestX * w + bias * ones(m,1);
Predict_Y = sign(DrawY.Y3);
    DrawY.Y1 = DrawY.Y3 - 1;
    DrawY.Y2 = DrawY.Y3 + 1;

    
        model.tr_time = 1;
    model.n_SV = 1;
    model.drw = 1;
end










