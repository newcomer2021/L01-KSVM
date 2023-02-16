function FunPara = LSSVCParaSearch(Data,SVMFun,FunPara,fid)
%The Temple of ParaSearch
%fid is the handle of file for record
    IsFile = 0;
    if nargin==4,IsFile = 1;end
    k = 10; %k折交叉验证参数
    
    kerfPara = FunPara.kerfPara;
    if strcmp(kerfPara.type,'lin'),StrKern = 'lin_kernel';
    else  StrKern = 'RBF_kernel';end
    [FunPara.gam,FunPara.kerfPara.pars] = tunelssvm({Data.X,Data.Y,'c',[],[],StrKern},...
                                                                'simplex','crossvalidatelssvm',{k,'misclass'});
    fprintf('Parameter Seaching is over!\n 10 fold Experment Processing Starting...\n');  
  
    Count =10;%进行Count次实验平均
    Acc = zeros(Count,1); time = zeros(Count,1);
    Sen = zeros(Count,1);Spe = zeros(Count,1); 
    gmean = zeros(Count,1);
    for i =1:Count
        tic;
        Perform = k_foldCV_C(Data,k,SVMFun,FunPara);
        time = time + toc;
        Acc(i) = Perform.Acc;
        Sen(i) = Perform.Sen;
        Spe(i) = Perform.Spe;
        gmean(i) = Perform.gmean;
        if IsFile, fprintf(fid,'%f ',Acc(i));end
    end    
    fprintf('mTime:%f,gam:%f,q:%f\n',...
        sum(time)/Count/k,FunPara.gam,FunPara.kerfPara.pars);
    fprintf('mAC:%f,sAC:%f,mSen:%f,sSen:%f,mSep:%f,sSep:%f,mGmean:%f,sGmean:%f\n',...
        mean(Acc), std(Acc),mean(Sen), std(Sen),mean(Spe), std(Spe),mean(gmean), std(gmean));
    
    if IsFile
    fprintf(fid,'mTime:%f,gam:%f,q:%f\n',...
        sum(time)/Count/k,FunPara.gam,FunPara.kerfPara.pars);
    fprintf(fid,'mAC:%f,sAC:%f,mSen:%f,sSen:%f,mSep:%f,sSep:%f,mGmean:%f,sGmean:%f\n\n',...
        mean(Acc), std(Acc),mean(Sen), std(Sen),mean(Spe), std(Spe),mean(gmean), std(gmean));
    end
end

