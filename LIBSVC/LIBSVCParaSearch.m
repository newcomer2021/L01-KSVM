function FunPara = LIBSVMParaSearch(Data,SVMFun,FunPara,fid)
%The Temple of ParaSearch
    IsFile = 0;
    if nargin==4,IsFile = 1;end
    k = 10; %k折交叉验证参数
    Best_AC = 0;
    %迭代进程
    Proc = 0;Step = 0;MaxStep = 8;
    ForLoopi = -MaxStep:MaxStep; 
	if strcmp(FunPara.kerfPara.type,'lin'),ForLoopPara = 0; else ForLoopPara = -10:4;end
    for i = ForLoopi
        for Para = ForLoopPara
            FunPara.c = 2^i;FunPara.kerfPara.pars = 2^Para;
            Perform = k_foldCV_C(Data,k,SVMFun,FunPara);
%             Perform = k_foldCVimage(Data,k,SVMFun,FunPara);
            if Perform.Acc>Best_AC
                Best_AC = Perform.Acc; Step = 0;
                c = 2^i;q=2^Para;
                if Best_AC > 0.99,break;end %如果到1，则跳出循环
            else Step = Step+1;
            end
            if Best_AC > 99,break;end
        end
        if Best_AC > 99,break;end
        if Step>4*MaxStep*length(ForLoopPara),fprintf('Step %f is biger than XXX, Process is break.\n',Step); break;end
        Proc = Proc + 1/(2*MaxStep+1);
        fprintf('Process %f,c:%f,q:%f \n',Proc,c,q);
    end
    fprintf('Parameter Seaching is over!\n 10 fold Experment Processing Starting...\n');

    FunPara.c = c;FunPara.kerfPara.pars = q;

    Count =10;%进行Count次实验平均
    Acc = zeros(Count,1); time = zeros(Count,1);
    Sen = zeros(Count,1);Spe = zeros(Count,1); 
    gmean = zeros(Count,1);
    for i =1:Count
        tic;
        Perform = k_foldCV_C(Data,k,SVMFun,FunPara);
%         Perform = k_foldCVimage(Data,k,SVMFun,FunPara);
        time = time + toc;
        Acc(i) = Perform.Acc;
        Sen(i) = Perform.Sen;
        Spe(i) = Perform.Spe;
        gmean(i) = Perform.gmean;
        if IsFile, fprintf(fid,'%f ',Acc(i));end
    end    
    fprintf('mTime:%f,c:%f,q:%f\n',sum(time)/Count/k,c,q);
    fprintf('mAC:%f,sAC:%f,mSen:%f,sSen:%f,mSpe:%f,sSpe:%f,mGmean:%f,sGmean:%f\n',...
        mean(Acc), std(Acc),mean(Sen), std(Sen),mean(Spe), std(Spe),mean(gmean), std(gmean));
    if IsFile
    fprintf(fid,'mTime:%f,c:%f,q:%f\n',sum(time)/Count/k,c,q);
    fprintf(fid,'mAC:%f,sAC:%f,mSen:%f,sSen:%f,mSpe:%f,sSpe:%f,mGmean:%f,sGmean:%f\n\n',...
        mean(Acc), std(Acc),mean(Sen), std(Sen),mean(Spe), std(Spe),mean(gmean), std(gmean));
    end
end

