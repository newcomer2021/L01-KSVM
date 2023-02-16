function  out = L01ADMM(X,y,pars)

[m,n]  = size(X); 

if nargin<3;               pars  = [];                             end
if isfield(pars,'maxit');  maxit = pars.maxit; else; maxit = 1e3;  end
if isfield(pars,'sigma');  sigma = pars.sigma; else; sigma = 1;    end
if isfield(pars,'tol');    tol   = pars.tol;   else; tol   = 1e-3; end
if isfield(pars,'C');      C     = pars.C;     else; C     = 1;    end
% i      = 0;
w      = ones(n,1)/100; % w=zeros(n,1);
lam    = zeros(m,1);
lamsig = lam;   
A      = y.*X; 
r      = 1-A*w;
b      = 0;   %b= 1 or -1;
z      = r-b*y;
theta  = ones(1,4);
Fnorm  = @(var)norm(var)^2;
flag   = 0;
% num    = 0;
to     = tic; 

% % % res1 = zeros(maxit,3);  % result_1
% % % res2 = zeros(maxit,3);  % result_2

for iter   = 1:1:maxit
    
    % update u and T-------------------------------- 
    [u, T] = Prox(z,C,sigma);
    
    % update w--------------------------------------
    tmp    = 1 - u - lamsig;
    
    wk = w; lamk=lam;
    
    v      = tmp - b*y;
    nT     = nnz(T);        
    AT     = A(T,:); 
    if min(n,nT)< 1e3         
        ATt     = AT';   
        if  n  <= nT
            AAT = ATt*AT;
            AAT(1:1+n:end) = AAT(1:1+n:end) + 1/sigma;  
            w   = AAT\(ATt*v(T));
        else
            if nT >0
                AAT = AT *ATt;
                AAT(1:1+nT:end) = AAT(1:1+nT:end) + 1/sigma; 
                w  = ATt*(AAT\v(T));
            else
                w  = -ones(n,1); T=1;
            end 
        end
    else   
        if  n  <= nT 
            w = my_cg(AT,sigma,(v(T)'*AT)',n,1);  
        else
            wT = my_cg(AT,sigma,v(T),nT,2); 
            w  = (wT'*AT)';
        end  
    end
 
    % update b------------------------------------- 
    Aw     = A*w; 
    b      = mean((tmp(T)-Aw(T)).*y(T)); 

    
    % update lambda------------------------------- 
    lamT   = lam(T);
    lam    = zeros(m,1);
    omega  = Aw + u - 1 + b*y;
    lamT   = lamT + sigma * omega(T);  
    lam(T) = lamT;
    
 
     % stopping crterion -------------------------- 
    lamsig = lam/sigma;
    ulam   = u  - lamsig; 
    ind    = (ulam<=0 | ulam>sqrt(2*C/sigma)); 
  
    theta(1) = Fnorm(w'+ lamT'*AT)/(1+Fnorm(w));
    theta(2) = abs(y(T)'*lamT)/(1+nT); 
    theta(3) = Fnorm(omega)/(m+Fnorm(Aw));
    theta(4) = Fnorm(u-ulam.*ind)/(1+Fnorm(u));
    error    = max(theta); 
     CPU     = toc(to);
    ACC      = 1-nnz(sign(y.*Aw+b)-y)/length(y); 
    if error < tol && ACC>0.5; flag=1; break;  end
    
% % %     res1(iter,:) = [ nT; ACC; error ];
% % %     res2(iter,:) = [ norm(w-wk); norm(lam-lamk); error ];
    
    z        = ulam - omega;
    sig0     = min(z(z>0));  
    if isempty(sig0); sig0 = 1e-8; end
    
    if mod(iter,10)==0 
        if theta(3) > 1e-3
           sigma = min(sigma*2,10);   
        elseif theta(1) > 1e-3
           sigma = min(max(0.01,sigma/1.25),5);  
        end         
    end
 
    if sigma > 2*C/sig0^2  % exclude zero solutions
       sigma = 1.9*C/sig0^2;  
   end

end
% fprintf('----------------------------------------------------\n');

out.iter = iter;
out.time = CPU;
out.wb   = [w;b];
out.u    = u;
out.lam  = lam;
out.nsv  = nT;
out.acc  = ACC;
out.error= error;
out.flag = flag;
% out.num  = num;

% % % out.res1 = res1(1:iter,:);
% % % out.res2 = res2(1:iter,:);
end

% proxiaml-----------------------------------------------------------------
function [u, T] = Prox(z,C,sigma)
    tmp  = sqrt(2*C/sigma);
    T    = find(z >0 & z <= tmp);
    u    = z;
    u(T) = 0;
end

% Conjugate gradient method-------------------------------------------------
function x = my_cg(AT,sigma,b,n,flag)
    x = zeros(n,1);
    r = b;
    e = sum(r.*r);
    t = e;
    for i = 1: 50  
        if e < 1e-10*t; break; end
        if  i == 1  
            p = r;
        else
            p = r + (e/e0)*p;
        end
        if  flag==1 
            w  = p/sigma  + ((AT*p)'*AT)'; 
        else
            w  = p/sigma  + AT*(p'*AT)'; 
        end 
        a  = e/sum(p.*w); 
        x  = x + a * p;
        r  = r - a * w;
        e0 = e;
        e  = sum(r.*r);
    end
    
end