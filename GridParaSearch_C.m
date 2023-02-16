function [Para , Perfm] = GridParaSearch_C(Data,SVMFun,Para,fid)
% This function is used to implement Grid-Search on Parameters.
% Written by Lingwei Huang, lateset update: 2021.06.04. 

if fid ~= 0, IsFile = 1; else, IsFile = 0; end % the switch of recording

%%  Parameters' Selection Range 

    k = 5; % k in [K]fold CV
    Best_indc = -eps;       Prcs = 0; 
    pStep = 5;      Base = 2;       Power = -pStep:pStep;
    mod = Para.mod;       ktype = Para.kpar.type;

% _____________ Model Parameters _____________
if       strcmp(mod,'GEPSVC') ||... 
         strcmp(mod,'HardSVC') ||... 
         strcmp(mod,'L2SVC') ||... 
         strcmp(mod,'LIBSVC') ||... 
         strcmp(mod,'LSSVC') ||... 
         strcmp(mod,'LSTSVC') ||... % 固定双c版
         strcmp(mod,'RampSVCIP') ||... 
         strcmp(mod,'TWSVC')
	Grid_M1 = Base.^Power; 
    Grid_M2 = 0; 
    Grid_M3 = 0; 
elseif strcmp(mod,'L01SVC') ||... 
         strcmp(mod,'LSPTSVC') ||... 
...%        strcmp(mtype,'LSTSVC') ||...  % 分行语句在被comment时，要前插"..." 
         strcmp(mod,'LTBSVC') ||... 
         strcmp(mod,'NHSVC') ||... 
         strcmp(mod,'RSVMA') ||... 
         strcmp(mod,'TBSVC') ||... 
         strcmp(mod,'TSVC_1p5') ||... % reinforce-TB
         strcmp(mod,'TSVC_RIFC') % reinforce-TB
    Grid_M1 = Base.^Power;
    Grid_M2 = Base.^Power;
    Grid_M3 = 0; 
elseif strcmp(mod,'ILTSVC')
    Grid_M1 = Base.^Power;
    Grid_M2 = Base.^Power;
    Grid_M3 = [1]; 
elseif strcmp(mod,'ILTSVC_w')
    Grid_M1 = Base.^Power; % [-8:4:8]
    Grid_M2 = Base.^Power;
    Grid_M3 = Base.^Power;
elseif strcmp(mod,'RampSVC_1')
    Grid_M1 = Base.^Power;
    Grid_M2 = [-1,-0.5,0] ;          % s=-1<0 for RampSVC  % -1:.5:0
    Grid_M3 = 0;
elseif strcmp(mod,'RSHSVC')
    Grid_M1 = Base.^Power;
    Grid_M2 = [ .4 , .6 , .8 ];      % sigma for RSHSVC [.2:.2:1]
    Grid_M3 = 0;
elseif strcmp(mod,'RTBSVC')
    Grid_M1 = Base.^Power;
    Grid_M2 = Base.^Power;
    Grid_M3 = [0.2,0.5,1,2,4];
elseif strcmp(mod,'RSVC_RHHQ')
    Grid_M1 = Base.^Power;
    Grid_M2 = 0;
    Grid_M3 = [ .2 , .5 , 1 , 2 , 3 ]; % 
end

% _____________ Kernel Parameters _____________
    if strcmp(ktype,'lin') || strcmp(ktype,'linK')
        Grid_K1 = 0;
        Grid_K2 = 0;
    elseif strcmp(ktype,'rbf')
        Grid_K1 = Base.^[-6:6];
        Grid_K2 = 0;
    end

% _____________ Small Scale Test _____________
%     Grid_M1 = 2.^[-8:-5];           Grid_M2 = 2.^[-8:-5];
%     Grid_M3 = 0;                                Grid_K1 = 0;
% _______________ Manual Setting Parameters _______________
%  ┌────────────────────────────────────┐
%  │   -8   │  -7    │    -6   │   -5   │   -4   │   -3    │   -2   │   -1   │
%  │.0039   │.0078   │.0156    │.0313   │.0625   │.1250   │.2500│.5000│
%  ├────────────────────────────────────┤
%  │  +8   │  +7  │   +6   │  +5   │  +4   │  +3   │  +2   │  +1   │
%  │ 256  │ 128  │   64   │   32  │   16   │    8    │    4    │    2   │
%  └────────────────────────────────────┘
% ===◆◆Manual Setting Switch◆◆===
         %manual_para = 'OFF'; 
        manual_para = 'ON'; 
    if strcmp(manual_para,'ON')
        p1 = 2^5;   % -2
        p2 =  2^-2;   % -1
        p3 = 0;   % -7
        q1 = 0;           q2 = 0;
    end

% ===◆◆Indicator Switch◆◆===
        Indictr = 'AC';
%         Indictr = 'GM';


%%  Grid-Search on Parameters 

for i_m1 = Grid_M1 
    if strcmp(manual_para,'ON'), break, end
    for i_m2 = Grid_M2 
        for i_m3 = Grid_M3 
            for i_k1 = Grid_K1 
            for i_k2 = Grid_K2 
                Para.p1 = i_m1;     Para.p2 = i_m2;     Para.p3 = i_m3; 
                Para.kpar.par1 = i_k1;              Para.kpar.par2 = i_k2; 
                % _____________■■■ Cross Validation ■■■_____________
                        Perfm = KfoldCV_C(Data,k,SVMFun,Para); 
                % ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
                % ________________ Opt Para Collection ________________
                if strcmp(Indictr,'AC'), Latest_indic = Perfm.Ac;
                elseif strcmp(Indictr,'GM'), Latest_indic = Perfm.GM; 
                end
                if Latest_indic > Best_indc % [>]former par; [>=]later par
                    Best_indc = Latest_indic;
                    p1 = Para.p1;       p2 = Para.p2;       p3 = Para.p3;
                    q1 = Para.kpar.par1;            q2 = Para.kpar.par2;
                end% ￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣
            end % 4 Grid_K2
            end % 4 Grid_K1
        end % 4 Grid_M3
    end % 4 Grid_M2
    Prcs = Prcs + 1/length(Grid_M1);
    fprintf('Prcs %.2f, AC:%.4f, p1:%.4f, p2:%.4f, p3:%.4f, q1:%.4f, q2:%.1f\n',...
        Prcs, Best_indc, p1, p2, p3, q1, q2); % Process Report
end % 4 Grid_M1


%%  Optimal Parameters Record 

    cnt =1; % [count]-times Kfold CV and takes the mean
    fprintf('Grid Parameter Seaching is over!\n');
    fprintf('%d Times %d-fold Experments on Opt-Paras are Starting...\n',k,cnt);
    Para.p1 = p1;       Para.p2 = p2;       Para.p3 = p3; 
    Para.kpar.par1 = q1;            Para.kpar.par2 = q2; 
    
	fprintf('___________________Optimal Parameters___________________\n');
	fprintf('p1:%.4f    p2:%.4f    p3:%.4f    q1:%.4f    q2:%.2f',...
            p1,p2,p3,q1,q2);  
	fprintf('\n￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣\n');


%%  C Times KfoldCV Performance 

    fprintf('___________________KfoldCV Performance___________________\n');
    Ac = zeros(cnt,1);      Gm = zeros(cnt,1);      time = zeros(cnt,1);
    Sen = zeros(cnt,1);    Spe = zeros(cnt,1);     n_SV = zeros(cnt,1);
%     Para.flip_lv = 0; % used 4 label noise control
    for i_c = 1:cnt
        Perfm = KfoldCV_C(Data,k,SVMFun,Para); % ■■■■■■■
        time(i_c) = Perfm.tr_time;    n_SV(i_c) = Perfm.n_SV; 
        Ac(i_c) = Perfm.Ac;               Gm(i_c) = Perfm.GM;
        Sen(i_c) = Perfm.Sen;           Spe(i_c) = Perfm.Spe;
    end
    if strcmp(Indictr,'AC')
        fprintf('%dT %d-fd Acc: ',k, cnt);        fprintf('%.4f ',Ac);
    elseif strcmp(Indictr,'GM') 
        fprintf('%dT %d-fd Gm: ',k, cnt);        fprintf('%.4f ',Gm);
    end
        fprintf('\nmAcc:%.4f | sAcc:%.4f    mGM:%.4f | sGM:%.4f\n',...
                mean(Ac), std(Ac), mean(Gm), std(Gm) );
        fprintf('mSen:%.4f | sSen:%.4f    mSpe:%.4f | sSep:%.4f\n',...
                mean(Sen), std(Sen), mean(Spe), std(Spe) );
        fprintf('mTime:%f        mN_SV:%.2f(%.2f)',...
                mean(time),  mean(n_SV),std(n_SV) );
        fprintf('\n￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣\n');


%%  Total Performance 

%     [PredY,model] = SVMFun( Data.X , Data , Para );
%     tN_SV = model.n_SV; % data nSV
%     tTIME = model.tr_time; % data time
%     tAC = sum(Data.Y == PredY)/length(PredY) * 100;
% 
%     fprintf('____________________Total Performance____________________\n');
%     fprintf('TIME:%.6f        AC:%.4f        N_SV:%.2f',...
%         tTIME,  tAC,  tN_SV );
%     fprintf('\n￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣\n\n');


%%  Auto Write In 

    if IsFile 
        fprintf(fid,'___________________Optimal Parameters___________________\n');
        fprintf(fid,'p1:%.4f    p2:%.4f    p3:%.4f    q1:%.4f    q2:%.2f',...
                p1,p2,p3,q1,q2); 
        fprintf(fid,'\n￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣\n');
% --------------------------------------------------------------------------------
        fprintf(fid,'___________________KfoldCV Performance___________________\n');
        if strcmp(Indictr,'AC')
            fprintf(fid,'%dT %d-fd Acc: ',k, cnt);        fprintf(fid,'%.4f ',Ac);
        elseif strcmp(Indictr,'GM') 
            fprintf(fid,'%dT %d-fd Gm: ',k, cnt);        fprintf(fid,'%.4f ',Gm);
        end
        fprintf(fid,'\nmAcc:%.4f | sAcc:%.4f    mGM:%.4f | sGM:%.4f\n',...
                mean(Ac), std(Ac), mean(Gm), std(Gm) );
        fprintf(fid,'mSen:%.4f | sSen:%.4f    mSpe:%.4f | sSep:%.4f\n',...
                mean(Sen), std(Sen), mean(Spe), std(Spe) );
        fprintf(fid,'mTime:%f        mN_SV:%.2f(%.2f)',...
                mean(time),  mean(n_SV),std(n_SV) );
        fprintf(fid,'\n￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣\n');
% --------------------------------------------------------------------------------
        fprintf(fid,'____________________Total Performance____________________\n');
        fprintf(fid,'TIME:%.6f        AC:%.4f        N_SV:%.2f',...
                tTIME,  tAC,  tN_SV );
        fprintf(fid,'\n￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣￣\n\n');
    end
    
end % Func end

