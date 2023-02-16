%%%该程序用来批量数据运算

%打开文件
%仿真函数
%%%要修改为自定义函数
SVMFunName = 'LIBSVM';
SVMFun = str2func(SVMFunName);
FunPara.c = 0;
FunPara.kerfPara.type = 'rbf';
FunPara.kerfPara.pars = 0.1;

%非常重要，请设置好，实验结果记录的文件路径和文件名，文件会自动创建！
if strcmp(FunPara.kerfPara.type,'lin'), DirPath = sprintf('./Result/%s/Linear/',SVMFunName);
else DirPath = sprintf('./Result/%s/NoLinear/',SVMFunName);end
if ~exist(DirPath,'dir'),mkdir(DirPath);end

for RunTimes = 1:1 %程序总共跑的次数，自定义
    FilePath = sprintf('%s%s%d.txt',DirPath,SVMFunName,RunTimes);
    fid = fopen(FilePath, 'wt');
    fprintf(fid, '%s Experment Time is %s \n', SVMFunName,date);

    DataNum = 16;
    DataPath(1) = {'./Data/UCI/hepatitis.mat'};
    DataPath(2) = {'./Data/UCI/Heartstatlog.mat'};
    DataPath(3) = {'./Data/UCI/Sonar.mat'};
    DataPath(4) = {'./Data/UCI/WPBC.mat'};
    DataPath(5) = {'./Data/UCI/Monks3.mat'};
    DataPath(6) = {'./Data/UCI/House_votes.mat'};
    DataPath(7) = {'./Data/UCI/Australian.mat'};
    DataPath(8) = {'./Data/UCI/TicTacToe.mat'};
    DataPath(9) = {'./Data/UCI/BUPA.mat'};
    DataPath(10) = {'./Data/UCI/Ionosphere.mat'};
    DataPath(11) = {'./Data/UCI/Spect.mat'};
    DataPath(12) = {'./Data/UCI/German.mat'};
    DataPath(13) = {'./Data/UCI/Echocardiogram.mat'};
    DataPath(14) = {'./Data/UCI/Diabetics.mat'};
    DataPath(15) = {'./Data/UCI/Heartc.mat'};
    DataPath(16) = {'./Data/UCI/CMC.mat'};
    %程序运行
    for i = 1:16
        fprintf(fid,'i=%d Runing DataPath:%s\n',i, DataPath{i});
        fprintf('Runing DataPath:%s\n',DataPath{i});
        load([DataPath{i}]);
        Data.Type = 2;Data.X = X;Data.Y = Y;clear X Y;
        Data = DataTypeTrans(Data,2);
        %%%要修改为自定义参数搜索函数
        LIBSVMParaSearch(Data,SVMFun,FunPara,fid);
    end
    fclose(fid);
end