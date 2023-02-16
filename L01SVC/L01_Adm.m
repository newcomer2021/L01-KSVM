function model = L01_Adm ( DataTrain, Para )

%% INITIALIZATION
X = DataTrain.X;    
y = DataTrain.Y;
[m,n] = size(X);            % m: # of samples	n: # of features 

C = Para.p1;         % penalty parameter C
sig = Para.p2;       % penalty parameter sigma
maxit = 1e3;              % the maximal # of iteration
tol   = 1e-3;               % tolerance level 
eta = 1.618;                % dual step-size

w = -ones(n,1)/100;   % w0 
lam = zeros(m,1);      % lambda0
lamsig = lam/sig;       % lam/sig
A = y .* X; 

b = 0; % b=±1 or mean( (1 - A*w) .*y )
z = 1 - A*w - b*y - lamsig; 
theta  = ones(1,4);     % stoppin' criteria
flag = 0;

% res1 = zeros(maxit,3);  % result_1
% res2 = zeros(maxit,3);  % result_2

to = tic;
%% ITERATION
for iter = 1 : maxit
    
    % update u and T-------------------------------- 
    [u, T] = L01_Prox( z , C , sig );
    
    % update w--------------------------------------
    tmp = 1 - u - lamsig; 
%     wk = w; lamk=lam;  % result in last iter 4 SC
    v = tmp - b*y;
    lTl = length(T);        % the size of the Working Set
    AT = A(T,:); 
    if min(n,lTl)< 1e3 
        ATt = AT';   
        if n <= lTl 
            AAT = ATt * AT;
            AAT(1:1+n:end) = AAT(1:1+n:end) + 1/sig;  
            w = AAT \ ( ATt * v(T) );
        else % n > lTl 
            if lTl >0
                AAT = AT * ATt;
                AAT(1:1+lTl:end) = AAT(1:1+lTl:end) + 1/sig; 
                w = ATt * ( AAT \ v(T) );
            else % lTl =0
                w = -ones(n,1); 
                T=1; % working set ~empty
            end 
        end
    else   % for large SVs of Feas
        if  n  <= lTl 
            w = my_cg(AT,sig,(v(T)'*AT)',n,1);  
        else % n > lTl 
            wT = my_cg(AT,sig,v(T),lTl,2); 
            w  = (wT'*AT)';
        end  
    end
 
    % update b------------------------------------- 
    Aw = A * w; 
    b = mean(  (tmp(T)-Aw(T)) .* y(T)  ); 
    
    % update lambda------------------------------- 
    lamT = lam(T);
    lam = zeros(m,1);
    omega = Aw + u - 1 + b*y;
    lamT = lamT +  sig * omega(T);  % eta *s*o
    lam(T) = lamT;
    
     % stopping crterion -------------------------- 
    lamsig = lam/sig;
    ulam = u - lamsig; 
    ind = ( ulam<=0 | ulam>=sqrt(2*C/sig) ); 
  
    theta(1) = normsq(w'+ lamT'*AT)/(1+normsq(w));
    theta(2) = abs(y(T)'*lamT)/(1+lTl); 
    theta(3) = normsq(omega)/(sqrt(m));  
    theta(4) = normsq(u-ulam.*ind)/(1+normsq(u)); 
    THETA = max(theta); 
    ACC = 1-nnz(sign(y.*Aw+b)-y)/length(y);  
%     res1(iter,:) = [ lTl; ACC; THETA ];
%     res2(iter,:) = [ norm(w-wk); norm(lam-lamk); THETA ];
    if THETA < tol && ACC>0.5; flag=1; break; end
 
    z = ulam - omega;
    sig0 = min( z(z>0) );  
    if isempty(sig0), sig0 = 1e-8; end
    
    if mod(iter,10)==0 
        if theta(3) > tol
           sig = min(sig*2,10);   
        elseif theta(1) > tol
           sig = min( max( 0.01 , sig/1.25 ) , 5 );  
        end         
    end
 
    if sig > 2*C/sig0^2  % exclude zero solutions
       sig = 1.9*C/sig0^2;  
   end

end

%% OUTPUT
model.tr_time = toc(to); % total iterative time
model.iter = iter;
model.w = w;
model.b = b;
model.u = u;
model.lam  = lam;
model.n_SV = lTl;          % # working set (SVs)
model.ind_SV = T;
model.acc = ACC;         % iter Ac
model.THETA = THETA; % relative convergent error
model.flag = flag;         % optimal condition triggered record 

% model.res1 = res1(1:iter,:);
% model.res2 = res2(1:iter,:);

end



