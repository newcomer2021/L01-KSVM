function hd = Plot2d_DecSurf(Data,SVMFun,Para)
% % programed  by  Ling-Wei Huang. 
% % Latest Update: 2021.04.29. 

% if ~((Data.Type ==2) || (Data.Type ==4))
%     disp('Error: Data.Type must be 2 or 4'); return;
% end

if size(Data.X,2)>2,fprintf('Data is not 2D \n');return,end

%%  Plot Samples & Errors

    X = Data.X;       Y = Data.Y;
    RG = '#A2142F'; % Negative point
    GG = '#77AC30'; % Positive point
    pos = Y==1;     neg = Y==-1;
    figure; hold on;
    plot( X(pos,1) , X(pos,2) ,'+','Color',GG,...
        'LineWidth',1.5,'MarkerSize',8); 
    plot( X(neg,1) , X(neg,2) ,'x','Color',RG,...
        'LineWidth',1.5,'MarkerSize',8);

    [PredY,model] = SVMFun( X , Data , Para ); % ¡ö¡ö¡ö
    Acc = sum(Y==PredY)/length(Y) * 100; 
    fprintf('Acc in Figure: %.2f(%%)\n\n',Acc);

    Fpos = Y>PredY; % Y=1,PredY=-1
    plot( X(Fpos,1) , X(Fpos,2) ,'o','Color',RG,...
            'LineWidth',2,'MarkerSize',10);
    Fneg = Y<PredY; % Y=-1,PredY=1
    plot( X(Fneg,1) , X(Fneg,2) ,'o','Color',GG,...
            'LineWidth',2,'MarkerSize',10);
%     indsv = model.ind_SV; % plot SVs
%     plot( X(indsv,1) , X(indsv,2) ,'s','Color',[.5 .5 .5],...
%             'LineWidth',0.5,'MarkerSize',10);

%% Uniformly tiling TestX 4 Construct 0 Contour
    c_lv = [0 0]; % contour level displayed
    %c_lv = [-1 0 1]; 

    lbX = min(X(:,1));     ubX = max(X(:,1));
    lbY = min(X(:,2));     ubY = max(X(:,2));
    untX = 0.05;            untY = 0.05;	% fig unit
    nX = 100;                nY = 100;        % fig precision
    lspX = linspace( lbX-untX , ubX+untX , nX );
    lspY = linspace( lbY-untY , ubY+untY , nY );

    [tX1, tX2] = meshgrid( lspX, lspY );
    ntst = length(lspX) * length(lspY);
    TstX=[ reshape(tX1, ntst, 1), reshape(tX2, ntst, 1) ]; 

    Para.drw = 1;   
    [~,model] = SVMFun( TstX , Data , Para ); % ¡ö¡ö¡ö 
    clear TstX Data 

    DiscSrf = model.drw.ds; % Decision Surface
    SptSrf1 = model.drw.ss1; % Support Surface
    SptSrf2 = model.drw.ss2;

    ds = reshape(DiscSrf, nX, nY);
    ss1 = reshape(SptSrf1, nX, nY);
    ss2 = reshape(SptSrf2, nX, nY);
    
    [~,hd(1)] = contour(tX1,tX2, ds, c_lv,'-','Color','k','LineWidth',2); 
    [~,hd(2)] = contour(tX1,tX2, ss1, c_lv,'-','Color',GG,'LineWidth',2);
    [~,hd(3)] = contour(tX1,tX2, ss2, c_lv,'-','Color',RG,'LineWidth',2);
    if model.twin ~= 0
        SptSrf1_=model.drw.ss1_;    ss1_ = reshape(SptSrf1_, nX, nY);
        SptSrf2_=model.drw.ss2_;    ss2_ = reshape(SptSrf2_, nX, nY);
        [~,hd(4)] = contour(tX1,tX2, ss1_, c_lv,'--','Color',GG,'LineWidth',1.5);
        [~,hd(5)] = contour(tX1,tX2, ss2_, c_lv,'--','Color',RG,'LineWidth',1.5);
    end
end



