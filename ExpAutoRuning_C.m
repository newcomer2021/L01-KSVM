% This program is used to run datasets in batches. 
% Written by Lingwei Huang, Latest updata: 2021-06-04 

% clear;  close;  clc
%% Model & Kernel Selection+

% ===＃＃＃SVM Model Switch＃＃＃===
%     ModName = 'GEPSVC'; % 
%     ModName = 'ILTSVC'; %＊ Interactive Learning Twin SVM 
%     ModName = 'ILTSVC_w'; %＊ Interactive Learning Twin SVM     
 ModName = 'L01SVC'; %＊
   %  ModName = 'L2SVC'; %＊
  % ModName = 'LIBSVC'; %＊
%     ModName = 'LSPTSVC';
      %   ModName = 'LSSVC'; %＊
%     ModName = 'LSTSVC'; %
%     ModName = 'LTBSVC';
%     ModName = 'NHSVC';
%     ModName = 'RSVMA'; %
    % ModName = 'RampSVC_1'; %＊ RampSVC-CCCP
     % ModName = 'RSVC_RHHQ'; %＊ Robust support vector machines based on the rescaled hinge loss function
     % ModName = 'RSHSVC'; %＊ Robust support vector machines for classification with nonconvex and smooth losses
%     ModName = 'RTBSVC'; %
%     ModName = 'TBSVC'; %
%     ModName = 'TSVC_1p5'; % 1.5-TB
%     ModName = 'TSVC_RIFC'; % reinforce-TB
%     ModName = 'TWSVC';
SVMFun = str2func(ModName); % string_to_function, used 4 call func
Para.mod = ModName; % used 4 para setting

% ===＃＃＃Kernel Type Switch＃＃＃===
   Para.kpar.type = 'lin'; 
%     Para.kpar.type = 'linK';  % kernel-model in linear type
    %  Para.kpar.type = 'rbf';

% ---Random Seed Selection (Optional)---
%     seed = randi(100);
    seed = 1;
%     seed = 2;
%     seed = 3;
%     seed = 4;
    rng(seed);

%% Automatic Recording Setting

% ===＃＃＃Auto Record Switch＃＃＃===
   %       AutoRec = 'OFF';
       AutoRec = 'ON';
if strcmp(AutoRec,'OFF')
    fid = 0;  % file id
elseif strcmp(AutoRec,'ON')
%%% -------------- Folder Path ------------------
    if strcmp(Para.kpar.type,'lin')
        DirPth = sprintf('./AutoResult/%s/lin/',ModName);
    elseif strcmp(Para.kpar.type,'linK') % kernel in lin
        DirPth = sprintf('./AutoResult/%s/linK/',ModName);
    elseif strcmp(Para.kpar.type,'rbf')
        DirPth = sprintf('./AutoResult/%s/rbf/',ModName);
    end % eg: AutoResult/LIBSVM/lin  LIBSVM_1.txt
    if ~exist(DirPth,'dir'),mkdir(DirPth);end
%%% -------------- Time & Note ------------------
    TIME = datestr(now,'yyyy-mm-dd_HH-MM-SS'); 
    NOTE = ['rng',num2str(seed),'-5b1q5-test']; % ＊Here write down the notes＊
%%% --------------- File Path -------------------
    FilePath = sprintf('%s%s_%s_%s.txt', ...
        DirPth , NOTE , ModName , TIME ); % File Path
    fid = fopen(FilePath, 'wt');
    fprintf(fid, '%s Experiment Time is %s \n', ModName, TIME);
end


%% Dataset Closet 

for DataCloset = 1 %

	for UCI=1 % _____________UCI_____________   Size	Fea  Rate＼	Density(~0)
    dPth(1) = {'./Data/UCI/Abalone.mat'};       %4174	  8    1/99      0.9598
    dPth(2) = {'./Data/UCI/Adult.mat'};           %17887  13   25/75 	 0.9874
    dPth(3) = {'./Data/UCI/Australian.mat'};    %690 	  14   44/56    0.7996
    dPth(4) = {'./Data/UCI/Balances.mat'};      %625       4    8/92      0.9216
    dPth(5) = {'./Data/UCI/Breast.mat'};          %699   	 9   34/66     1.0000
    dPth(6) = {'./Data/UCI/BUPA.mat'};           %345       6   42/58     0.9957
    dPth(7) = {'./Data/UCI/Cleveland.mat'};     %173     13    8/92      0.7052
    dPth(8) = {'./Data/UCI/CMC.mat'};            %1473     9   77/23     0.8454
    dPth(9) = {'./Data/UCI/Creadit.mat'};         %690     15   44/56    0.9120
    dPth(10) = {'./Data/UCI/Diabetics.mat'};    %768      8   35/65      0.9758
    dPth(11) = {'./Data/UCI/Echo.mat'};           %131    10   33/67     0.7985
    dPth(12) = {'./Data/UCI/Ecoli.mat'};           %336      7   10/90     0.9983
    dPth(13) = {'./Data/UCI/German.mat'};      %1000   20   70/30    1.0000
    
    dPth(14) = {'./Data/UCI/Haberman.mat'};  %306      3   76/26    0.8519
    dPth(15) = {'./Data/UCI/Heartc.mat'};        %303    14   46/54    0.7289
    dPth(16) = {'./Data/UCI/Heartstatlog.mat'};%270    13   56/44    0.7510
    dPth(17) = {'./Data/UCI/Hepatitis.mat'};     %155    19   21/79    0.9997
    dPth(18) = {'./Data/UCI/Hourse.mat'};        %300    26   60/40    0.9169
    dPth(19) = {'./Data/UCI/Housevotes.mat'}; %435    16   61/39   1.0000
    dPth(20) = {'./Data/UCI/Hypothyroid.mat'};%3163  25    5/95    0.9806
    dPth(21) = {'./Data/UCI/Ionosphere.mat'}; %351    34   36/64    0.8809
    dPth(22) = {'./Data/UCI/Led7digit.mat'};    %443      7    8/92    0.6556
    dPth(23) = {'./Data/UCI/Monks3.mat'};      %432      6   50/50   1.0000
    dPth(24) = {'./Data/UCI/New-thyroid.mat'};%215     4   16/84   1.0000
    
    dPth(25) = {'./Data/UCI/Page-blocks.mat'};%5472   10   10/90   1.0000
    dPth(26) = {'./Data/UCI/Parkinsons.mat'};  %195     22   75/25   1.0000
    dPth(27) = {'./Data/UCI/PimaIndian.mat'}; %768       8   35/65   0.8758
    dPth(28) = {'./Data/UCI/Segment.mat'};     %2308   19   14/86   0.8842
    dPth(29) = {'./Data/UCI/Shuttle.mat'};        %1829    9    7/93     0.7757
    dPth(30) = {'./Data/UCI/Sonar.mat'};          %208    60   47/53    0.9993
    dPth(31) = {'./Data/UCI/Spanbas.mat'};      %4601   57   39/61   0.2259 
    dPth(32) = {'./Data/UCI/Spect.mat'};          %267     44   79/21   1.0000
    dPth(33) = {'./Data/UCI/TIC.mat'};             %5822   85    6/94     0.4442
    dPth(34) = {'./Data/UCI/TicTacToe.mat'};   %958     27   65/35    0.3333
    dPth(35) = {'./Data/UCI/Titanic.mat'};        %2201    3   32/68     0.7783
    dPth(36) = {'./Data/UCI/Transfusion.mat'}; %784     4   24/76     0.9983
    dPth(37) = {'./Data/UCI/TwoNorm.mat'};   %7400   20   50/50   1.0000
    
    dPth(38) = {'./Data/UCI/Vehicle.mat'};      %940     18   24/76    0.9930
    dPth(39) = {'./Data/UCI/Vowel.mat'};        %988    13    9/91     0.9123
    dPth(40) = {'./Data/UCI/Waveform.mat'};  %5000   21   33/67   0.9984
    dPth(41) = {'./Data/UCI/WDBC.mat'};        %569    30   37/63    0.9954
    dPth(42) = {'./Data/UCI/Wine.mat'};          %178    13   33/67    1.0000
    dPth(43) = {'./Data/UCI/Wisconsin.mat'};   %683     9   35/65    1.0000
    dPth(44) = {'./Data/UCI/WPBC.mat'};        %198    34   24/76    0.9871 
    dPth(45) = {'./Data/UCI/Yeast.mat'};         %1481    8   11/89     0.8759
    dPth(46) = {'./Data/UCI/a6atrain.mat'};         %11220  122
    dPth(47) = {'./Data/UCI/HTRU_2.mat'};         %17898 8
	end
     
	for NDC=1 % ___________NDC____________  Size-Fea
    dPth(401) = {'./Data/NDC/n60.mat'};           %0,000,060
    dPth(402) = {'./Data/NDC/n70.mat'};           %0,000,070
    dPth(403) = {'./Data/NDC/n80.mat'};           %0,000,080
    dPth(404) = {'./Data/NDC/n90.mat'};           %0,000,090
    dPth(405) = {'./Data/NDC/n100.mat'};         %0,000,100
    dPth(406) = {'./Data/NDC/n200.mat'};         %0,000,200
    dPth(407) = {'./Data/NDC/n300.mat'};         %0,000,300
    dPth(408) = {'./Data/NDC/n400.mat'};         %0,000,400
    dPth(409) = {'./Data/NDC/n500.mat'};         %0,000,500
    dPth(410) = {'./Data/NDC/n600.mat'};         %0,000,600
    dPth(411) = {'./Data/NDC/n700.mat'};         %0,000,700
    dPth(412) = {'./Data/NDC/n800.mat'};         %0,000,800
    dPth(413) = {'./Data/NDC/n900.mat'};         %0,000,900
    dPth(414) = {'./Data/NDC/n1000.mat'};       %0,001,000
    dPth(415) = {'./Data/NDC/n2000.mat'};       %0,002,000
    dPth(416) = {'./Data/NDC/n3000.mat'};       %0,003,000
    dPth(417) = {'./Data/NDC/n4000.mat'};       %0,004,000
    dPth(418) = {'./Data/NDC/n5000.mat'};       %0,005,000
    dPth(419) = {'./Data/NDC/n6000.mat'};       %0,006,000
    dPth(420) = {'./Data/NDC/n7000.mat'};       %0,007,000
    dPth(421) = {'./Data/NDC/n8000.mat'};       %0,008,000
    dPth(422) = {'./Data/NDC/n9000.mat'};       %0,009,000
    dPth(423) = {'./Data/NDC/n10000.mat'};     %0,010,000
    dPth(424) = {'./Data/NDC/n15000.mat'};     %0,015,000
    dPth(425) = {'./Data/NDC/n20000.mat'};     %0,020,000
    dPth(426) = {'./Data/NDC/n30000.mat'};     %0,030,000
    dPth(427) = {'./Data/NDC/n50000.mat'};     %0,050,000
    dPth(428) = {'./Data/NDC/n100000.mat'};   %0,100,000
    dPth(429) = {'./Data/NDC/n1000000.mat'}; %1,000,000
     dPth(430) = {'./Data/NDC/NDCnormal22.mat'}; %9999
	end
    
	for SSS=1 % _____________SSS_____________ 
    dPth(451) = {'./Data/SSS/AmazonCommerceReviews.mat'}; % 1500-10000
    dPth(452) = {'./Data/SSS/Arcene.mat'}; % 200-10000
    dPth(453) = {'./Data/SSS/AsianReligiousBiblical.mat'}; % 590-8266
    dPth(454) = {'./Data/SSS/DBWorld_bod.mat'}; % 64-4702
    dPth(455) = {'./Data/SSS/DBWorld_bod_stmd.mat'}; % 64-3721
    dPth(456) = {'./Data/SSS/DBWorld_sub.mat'}; % 64-242
    dPth(457) = {'./Data/SSS/DBWorld_sub_stmd.mat'}; % 64-229
    dPth(458) = {'./Data/SSS/GastrointestinalLesions.mat'}; % 152-699
    dPth(459) = {'./Data/SSS/LungCancer.mat'}; % 23-56
    dPth(460) = {'./Data/SSS/MicroMassSpectra_mixed.mat'}; % 360-1300
    dPth(461) = {'./Data/SSS/MicroMassSpectra_pure.mat'}; % 571-1300
    dPth(462) = {'./Data/SSS/SCADI.mat'}; % 70-205
    dPth(463) = {'./Data/SSS/VoiceRehabilitation.mat'}; % 126-310
	end
    
	for Artf=1 % ________2D Artificial_________  Size-Fea
    dPth(501) = {'./Data/Artificial/2D/Cctr_1.mat'}; 
    dPth(502) = {'./Data/Artificial/2D/Cctr_11.mat'}; 
    dPth(503) = {'./Data/Artificial/2D/Cctr_12.mat'}; 
    dPth(504) = {'./Data/Artificial/2D/Cctr_2.mat'}; 
    dPth(505) = {'./Data/Artificial/2D/Cctr_21.mat'}; 
    dPth(506) = {'./Data/Artificial/2D/Cctr_22.mat'}; 
    dPth(507) = {'./Data/Artificial/2D/Cctr_23.mat'}; 
    dPth(508) = {'./Data/Artificial/2D/Cctr_24.mat'}; 
    dPth(511) = {'./Data/Artificial/2D/syn_214_ori.mat'}; 
    dPth(512) = {'./Data/Artificial/2D/syn_214_010.mat'};       
	end

end

%% Data Selection & Main Process

%     DNC_all = [401:429];

    UCI_all = [ 1 : 46 ];     % All UCI
    Uthrd = 5000;            % Upper threshold
    Lthrd = 1500;             % Lower thrd
    for dat = 47
% 
%     for dat = 512       % test Artificial
%     for dat = 11             %% test UCI

        load( dPth{dat} );        [m,n] = size(X);

        %===＃＃＃DataSize Filter Switch＃＃＃===
        %if Uthrd < m, continue, end % Discard (Uthrd<m)'s data
%         if m < Lthrd || Uthrd < m, continue, end
%         if Lthrd < m, continue, end % Discard (Lthrd<m)'s data
%         if 500 < m, continue, end
%         if m < 500 || 1500 < m, continue, end
        %===＃＃＃Sampling Switch＃＃＃===
                 smpl = 'OFF';
                %smpl = 'ON';
        if strcmp(smpl,'ON')
            r = 10;     % sampling ratio = [ 1 / r ]
            men_p = fix(sum(Y==1)/r);
            men_n = fix(sum(Y==-1)/r);
            ind_p = crossvalind('Kfold',Y,r,'CLASSES',1,'MIN', men_p);
            ind_n = crossvalind('Kfold',Y,r,'CLASSES',-1,'MIN', men_n);
            ind = ind_p + ind_n; %fix(sum(ind_p)/r)      
%               X = X(ind==1,:);        Y = Y(ind==1);
%               x = X(ind==1,:);        y = Y(ind==1); 
%             a.x=x; a.y=y;
%              save('HTRU_2tor_5','a')
        end

        if strcmp(AutoRec,'ON')
            fprintf(fid,'\ni=%d Runing DataPath:%s\n',dat, dPth{dat} ); 
        end
        fprintf('__%s__%s-ker__rng-%d__\n[i=%d] Runing DataPath:%s\n',...
            ModName, Para.kpar.type, seed, dat, dPth{dat} );

        %===＃＃＃Pre-processing Switch＃＃＃===
        X = mapminmax(X',0,1)';
        %X = zscore(X);
        %X = normalization( X , 2 ); %

        %===＃＃＃Label Noise Switch＃＃＃===
        %flip_lv = 5;
          % flip_lv = 10;
%          Y = FlipLabel( Y , flip_lv );
      Para.flip_lv = 0;
        Data.X = X;     Data.Y = Y;     Para.drw = 0;
% 
%          b=load('HTRU_2tor_5.mat', 'a');
%         Data.X = b.a.x;
%          Data.Y = b.a.y; 
%          Para.drw = 0;
        %===＃＃＃Grid Search Process＃＃＃===
        [Para , Perfm] = GridParaSearch_C(Data,SVMFun,Para,fid); 

    end

    if strcmp(AutoRec,'ON'),fclose(fid);end
    fprintf(' ExpAutoRuning is over !\n\n');
    
    
%% Plot Decisive Surface in 2-D Data
    if n == 2 % 2D plot
        close,
        handle = Plot2d_DecSurf(Data,SVMFun,Para);
    end

% load train 
% sound(y,Fs)


