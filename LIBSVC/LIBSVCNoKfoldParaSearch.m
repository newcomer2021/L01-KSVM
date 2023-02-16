function FunPara = LIBSVMNoKfoldParaSearch(Data,SVMFun,FunPara)
%The Templet of SVMFUNNoKfoldParaSearch
%fid is the handle of file for record

    %变量初始化
    Best_AC = 0;
    Proc = 0;Step = 0;
    MaxStep = 8;
    ForLoopi = -MaxStep:MaxStep; 
    %自动识别核参数来自适应决定是否要遍历核参数q
    if strcmp(FunPara.kerfPara.type,'lin'),ForLoopPara = 0; else ForLoopPara = -3:3;end
    for i = ForLoopi
        for Para = ForLoopPara
                FunPara.c = 2^i;
                FunPara.kerfPara.pars = 2^Para;
                Predict_Y=SVMFun(Data.X,Data,FunPara);
                AC = sum(Data.Y == Predict_Y)/length(Predict_Y);
                if AC>Best_AC
                    Best_AC=AC; Step = 0;
                    c = 2^i;q=2^Para;
                    if Best_AC > 99,break;end %如果到1，则跳出循环
                else Step = Step+1;
            end
            if Best_AC > 99,break;end
        end
        if Best_AC > 99,break;end
        if Step>100*MaxStep*length(ForLoopPara),fprintf('Step %f is biger than XXX, Process is break.\n',Step); break;end
        Proc = Proc + 1/(2*MaxStep+1);
        fprintf('Process %f,c:%f,q:%f\n',Proc,c,q);
    end
    fprintf('Parameter Seaching is over!\n 10 fold Experment Processing Starting...\n');

    FunPara.c = c;FunPara.kerfPara.pars = q;
    Count =10;%进行Count次实验平均
    Acc = zeros(Count,1); time = zeros(Count,1);
    Sen = zeros(Count,1);Spe = zeros(Count,1); 
    gmean = zeros(Count,1);
    k=10;
    for i =1:Count
        tic;
        Perform = k_foldCV_C(Data,k,SVMFun,FunPara);
        time = time + toc;
        Acc(i) = Perform.Acc;
        Sen(i) = Perform.Sen;
        Spe(i) = Perform.Spe;
        gmean(i) = Perform.gmean;
    end    
    fprintf('mTime:%f,c:%f,q:%f\n',sum(time)/Count/k,c,q);
    fprintf('mAC:%f,sAC:%f,mSen:%f,sSen:%f,mSpe:%f,sSpe:%f,mGmean:%f,sGmean:%f\n',...
        mean(Acc), std(Acc),mean(Sen), std(Sen),mean(Spe), std(Spe),mean(gmean), std(gmean));
end