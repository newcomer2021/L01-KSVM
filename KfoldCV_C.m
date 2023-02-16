function Perfm = KfoldCV_C(Data,k,SVMFun,Para)
% Written by Lingwei Huang, lateset update: 2021.05.12. 
    X = Data.X;     Y = Data.Y;     clear Data
    
%% Kfold Index Division

% ===◆◆◆CV BaseOnClass Switch◆◆◆===
        BOC = 'OFF'; %■
%         BOC = 'ON';
% ===◆◆◆CV MiniElementNum Switch◆◆◆===
        MEN = 'OFF'; %■
%         MEN = 'ON';
% =============================
    if strcmp(BOC,'ON')
        if strcmp(MEN,'ON')
            men_p = fix(sum(Y==1)/k); 
            men_n = fix(sum(Y==-1)/k); 
            ind_p = crossvalind('Kfold',Y,k,'CLASSES',1,'MIN', men_p); 
            ind_n = crossvalind('Kfold',Y,k,'CLASSES',-1,'MIN', men_n); 
        elseif strcmp(MEN,'OFF')
            ind_p = crossvalind('Kfold',Y,k,'CLASSES',1); 
            ind_n = crossvalind('Kfold',Y,k,'CLASSES',-1); 
        end
        ind = ind_p + ind_n ;
    elseif strcmp(BOC,'OFF')
        if strcmp(MEN,'ON')
            men = fix(length(Y)/k); 
            ind = crossvalind('Kfold',Y,k,'MIN',men); 
        elseif strcmp(MEN,'OFF')
            ind = crossvalind('Kfold',Y,k); % ■■■
        end
    end

%% Evaluation Criteria Initialization

    Perfm.Sen = 0;    Perfm.Spe = 0;
%     Perfm.FNR = 0;    Perfm.FPR = 0;    Perfm.Prec = 0;
    Perfm.Ac = 0;    Perfm.GM = 0;
%     Perfm.MCC = 0;    Perfm.G = 0;      Perfm.F = 0;
    Perfm.n_SV = 0;
    Perfm.tr_time = 0;
%     GMz = 0;
    TPTNs = 0;   FNFPs = 0;
%     Y=sign(randn(length(Y),1));
        
%% Kfold CV Loop
% a = load('ind.mat');   %xintian2.8
% ind = a.ind;  %xintian2.8
% 
% save('ind','ind')%xintian2.8

    for i = 1 : k
        tst = (ind == i);          trn = ~tst; 
        Trn.X = X(trn,:);          Trn.Y = Y(trn,:); % Train 
        Tst.X = X(tst,:);           Tst.Y = Y(tst,:); % Test 
        nY = length(Tst.Y);     nYs = length(Y);
        if Para.flip_lv ~= 0 % used 4 label noise control
            Trn.Y = FlipLabel( Trn.Y , Para.flip_lv );
            Tst.Y = FlipLabel( Tst.Y , Para.flip_lv );
        end
        
        %___________ Model Solving and Prediction ___________
                [PredY,model] = SVMFun( Tst.X , Trn , Para ); 
        %￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
        Perfm.n_SV = Perfm.n_SV + model.n_SV;
        Perfm.tr_time = Perfm.tr_time + model.tr_time;

% _____________ Confusion Matrix _____________
        TP = sum(PredY(Tst.Y==1)==1); 
        TN = sum(PredY(Tst.Y==-1)==-1); 
        FP = sum(PredY(Tst.Y==-1)==1);  
        FN = sum(PredY(Tst.Y==1)==-1);  
% %     ┌───┬───────────┐
% %     │　 　│    预     测     值     │
% %     ├───┼───┬───┬───┤
% %     │  真  │        │ ++  │  --   │
% %     │　　├───┼───┼───┤
% %     │  实  │ ++  │  TP  │ FN  │
% %     │　    ├───┼───┼───┤
% %     │  值  │   --  │  FP  │  TN │
% %     └───┴───┴───┴───┘
        TPTN = TP + TN;  % # TURE Prediction
        FNFP = FN + FP;  % # FALSE Prediction
        TPFN = TP + FN;  % # Positive Label
        FPTN = FP + TN;  % # Negative Label
        TPFP = TP + FP;   % # Positive Prediction
        FNTN = FN + TN; % # Negative Prediction
        
% Number of T&F Prediction _____________
        TPTNs = TPTNs + TPTN;
        FNFPs = FNFPs + FNFP;
        
% Accuracy & Error Rate (-WRONG-) _____________
        Perfm.Ac = Perfm.Ac + TPTN/nY;
        %Perfm.Er = Perfm.Er + nFPFN/nY;

% Sensitivity & FalseNegativeRate _____________
        if TPFN==0
            Sen = 0; % TurePositiveRate/Recall
            %FNR = 0; 
        else
            Sen = TP/TPFN;	
            %FNR = FN/TPFN;
        end
        Perfm.Sen = Perfm.Sen + Sen;
        %Perfm.FNR = Perfm.FNR + FNR;
    
% Specificity & FalsePositiveRate _____________
        if FPTN==0
            Spe = 0; % TureNegativeRate
            %FPR = 0; 
        else
            Spe = TN/FPTN;	
            %FPR = FP/TNFP;
        end
        Perfm.Spe = Perfm.Spe + Spe;
        %Perfm.FPR = Perfm.FPR + FPR;

% Precision _____________
        %if TPFP==0 
            %Prec = 0;
        %else
            %Prec = TP/(TPFP);
        %end
        %Perfm.Prec = Perfm.Prec + Prec; 

% F-score & G-score _____________
        %beta = 1; % weight
        %if TPFN==0 || TPFP==0
            %F = 0;
            %G = 0;
        %else
            %Rec = TP/(TP+FN);    Prec = TP/(TP+FP);
            %F = (1+beta^2) * ((Rec*Prec) / (Rec+Prec*beta^2));
            %G = sqrt(Rec * Prec);
        %end
            %Perfm.F = Perfm.F + F;
            %Perfm.G = Perfm.G + G;

% Geometry Mean _____________
        if TPFP==0 || FNTN==0
            GM = 0;
        else
            GM = sqrt( (TP/TPFP) * (TN/FNTN) );
        end
        Perfm.GM = Perfm.GM + GM;

% Matthew Correlation Coefficient _____________ 
        %MCC = (TP*TN-FN*FP) / sqrt( (TP+FN)*(FP+TN)*(TP+FP)*(FN+TN) );
        %Perfm.MCC = Perfm.MCC + MCC;

    end % 4 Kfold


%% Evaluation Criteria Collection

% Perfm.Ac = TPTNs/nYs * 100; (-RIGHT-)
    Perfm.Ac = Perfm.Ac/k*100; % (-WRONG-)
    Perfm.GM = Perfm.GM/k*100;
    Perfm.Sen = Perfm.Sen/k*100;
    Perfm.Spe = Perfm.Spe/k*100;
    Perfm.n_SV = Perfm.n_SV/k;
    Perfm.tr_time = Perfm.tr_time/k;
    
%     Perfm.FNR = Perfm.FNR/k*100;    
%     Perfm.FPR = Perfm.FPR/k*100;
%     Perfm.Prec = Perfm.Prec/k*100;
% 
%     Perfm.G = Perfm.G/k*100;
%     Perfm.F = Perfm.F/k*100; 
%     Perfm.MCC = Perfm.MCC/k*100;

% % % 此处的G-mean是对k个fold的验证结果中的小g-mean的算术平均，
% % % 而不是Sen(算术平均sen)和Spe(算术平均spe)的几何平均，两者不同
% % % 如：
% % % sen = [10,20,30]; 
% % % spe = [90,80,70]; 
% % % g-mean = [30,40,45.8258]; %这里的每个g-mean都是sen和spe的几何平均
% % % 然而Sen=20，Spe=80，G-mean=38.6086，但√(Sen*Spe)=35.7071
% % % 且当sen和spe存在交错为0时，gmean的零值会非常多
% % % √(Sen*Spe)与G-mean的差距也越大


end % Func end


