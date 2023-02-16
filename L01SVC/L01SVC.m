function [PredictY,model] = L01SVC(TestX,DataTrain,Para)

    Trn = DataTrain;    clear DataTrain
    ktype = Para.kpar.type;
    kpar = Para.kpar;
    [m1,~] = size(Trn.X);
    [m2,~] = size(TestX);
        
    if strcmp(ktype,'lin')
        model = L01_Adm ( Trn, Para ); % ■■■
        w = model.w;        b = model.b;
        dec_val = TestX*w + b*ones(m2,1);
    elseif strcmp(ktype,'linK') % k-model degen to lin 
        Para.kpar.type = 'lin';
        TstX_td = [ TestX , ones(m2,1) ]; % tilde
        TrnX_td = [Trn.X , ones(m1,1) ];
        model = L01GK_ADMM ( Trn , Para ); % ■■■
        alph = model.alph;
        Y = speye(m1) .* Trn.Y; 
        K_test = kernelfun( TstX_td , kpar , TrnX_td );
        dec_val = -K_test*Y*alph;
    elseif strcmp(ktype,'rbf')
        TstX_td = [ TestX , ones(m2,1) ];
        TrnX_td = [Trn.X , ones(m1,1) ];
        model = L01GK_ADMM ( Trn, Para ); % ■■■
        alph = model.alph;
        Y = speye(m1) .* Trn.Y; 
        K_test = kernelfun( TstX_td , kpar , TrnX_td );
        dec_val = -K_test*Y*alph;
    end
    PredictY = sign( dec_val );  % value on Disc Surf
    if Para.drw == 1
        drw.ds = dec_val;
        drw.ss1 = drw.ds - 1;
        drw.ss2 = drw.ds + 1;
        model.drw = drw; 
        model.twin = 0;
    end
end



