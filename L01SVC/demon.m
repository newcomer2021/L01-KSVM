clear ; clc; close all;

addpath(genpath(pwd));

% type  = 1;
type  = 2;
switch type
case 1
   load('W1a.mat')   
%     X    = normalization(X,2);
%     Xt    = normalization(Xt,2);
%       m0    = 2e3;        [X,y,Xt,yt] = randomData('2D',m0,2,0);  
case 2
%     load Adult
    load Australian
%     load Cleveland
%     load CMC
%     load Echo
%     load Ecoli
%     load German
%     load Heartc
%     load Heartstatlog
%     load Hepatitis
%     load Parkinsons
%     load Sonar
%     load Wine
%     load WPBC
        X    = normalization(X,2);
        y    = Y; [M,n]=size(X);
% randomly split the data into training and testing data
m  = ceil(0.9*M);  mt = M-m;       I  = randperm(M);
Tt = I(1:mt);      Xt = X(Tt,:);   yt = y(Tt);   % 0.1 testing  data 
T  = I(1+mt:end);  X  = X(T,:);    y  = y(T,:);  % 0.9 training data
end


Sig=[]; C=[]; Iter=[]; R=[]; SV=[]; Time=[];
for i = -3
    pars.sigma = 2^i;
    for j = -2
        pars.C     = 2^i;
        out        = L01ADMM(X,y,pars);  %%%%%%%

        % 实验数据记录
        Sig  = [Sig;pars.sigma];
        C    = [C;pars.C];
        Iter = [Iter; out.iter]; 
        R    = [R;accuracy(Xt,yt,out.wb)];
        SV   = [SV;out.nsv];
        Time = [Time; out.time];
    end
end
wb         = out.wb;

% 结果输出
fprintf('Support Vector:        %d\n',out.nsv);
fprintf('Training Accuracy:     %6.4f\n', accuracy(X,y,wb)) 
if type == 1
fprintf('Testing  Accuracy:     %6.4f\n', accuracy(Xt,yt,wb));
end
fprintf('Training Time:         %5.3fsec\n',out.time);

% 作图
ylab   = {'NSV', 'ACC', 'ERR'}; 
figure('Renderer', 'painters', 'Position', [800, 300,620 280]) 
for i = 1:length(ylab)
    sub  = subplot(1,length(ylab),i);
    pos1 = get(sub, 'Position');   
    res1  = out.res1(:,i); 
    pt   = @semilogy; if i==2; pt=@plot; end
    p    = pt(1:out.iter,res1, 'black','Linewidth',0.75);
    xlabel('Iteration'),ylabel(ylab{i}),grid on
    axis([1 out.iter min(res1)/1.01 max(res1)*1.01])
    set(sub, 'Position',pos1+[-.07+.055*(i-1),0,0.04,0] )
end


ylab   = {'||w_{k+1}-w_k||^2', '||lamk+1-lamk||^2', 'ERR'}; 
figure('Renderer', 'painters', 'Position', [800, 300,620 280]) 
for i = 1:length(ylab)
    sub  = subplot(1,length(ylab),i);
    pos1 = get(sub, 'Position');   
    res2  = out.res2(:,i); 
    pt   = @semilogy; if i==2; pt=@plot; end
    p    = pt(1:out.iter,res2, 'black','Linewidth',0.75);
    xlabel('Iteration'),ylabel(ylab{i}),grid on
    axis([1 out.iter min(res2)/1.01 max(res2)*1.01])
    set(sub, 'Position',pos1+[-.07+.055*(i-1),0,0.04,0] )
end