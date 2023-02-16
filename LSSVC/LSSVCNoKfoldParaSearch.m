function FunPara = LSSVCNoKfoldParaSearch(Data,SVMFun,FunPara)
%The Temple of ParaSearch
    k = 10;
    kerfPara = FunPara.kerfPara;
    if strcmp(kerfPara.type,'lin'),StrKern = 'lin_kernel';
    else  StrKern = 'RBF_kernel';end
%     [FunPara.gam,FunPara.kerfPara.pars] = tunelssvm({Data.X,Data.Y,'c',[],[],StrKern},...
%                                                                 'simplex','crossvalidatelssvm',{k,'misclass'});
%     fprintf('Parameter Seaching is over!\n 10 fold Experment Processing Starting...\n');
    FunPara.gam = 1; FunPara.kerfPara.pars =1;
    tic;
    Predict_Y=SVMFun(Data.X,Data,FunPara);
    toc;
    AC = sum(Data.Y == Predict_Y)/length(Predict_Y)
    Count =10;%进行Count次实验平均
    Acc = zeros(Count,1); time = zeros(Count,1);
    Sen = zeros(Count,1);Spe = zeros(Count,1); 
    gmean = zeros(Count,1);
    for i =1:Count
        tic;
        Perform = k_foldCV_C(Data,k,SVMFun,FunPara);
        time(i) = toc;
        Acc(i) = Perform.Acc;
        Sen(i) = Perform.Sen;
        Spe(i) = Perform.Spe;
        gmean(i) = Perform.gmean;
    end    
    fprintf('mTime:%f,mAC:%f,sAC:%f\n',mean(time)/k,mean(Acc), std(Acc));
    fprintf('mSen:%f,sSen:%f,mSep:%f,sSep:%f,mGmean:%f,sGmean:%f\n\n',...
        mean(Sen), std(Sen),mean(Spe), std(Spe),mean(gmean), std(gmean));
end

