function [PredictY,model] = RampSVC_1( TestX , DataTrain , Para)
% % Ramp-SVM solved by CCCP based on the alrorithm in: 
% % Collobert R ,  Sinz F ,  Weston J , Bottou L. 
% % Trading Convexity for Scalability[J]. 
% % in Proc. 23th Int. Conf. Mach. Learn., 2006,201-208. 
% % Modified by Wei-Jie Chen & Ling-Wei Huang.
% % Latest Update: 2021.04.25

%% train_RampSVM

    X = DataTrain.X;    Y = DataTrain.Y;
    class = unique(Y); 
    nclass = length(class); 
    if nclass == 2 
        model = RampSVC3CP(DataTrain,Para); % ¡ö¡ö¡ö
    else 
        [model.w , model.b , model.SV] = deal( cell(nclass,1) );
        for i = 1:nclass
            ind_p1 = Y==class(i); % reorder data by class
            ind_n1 = Y~=class(i); 
            Reorder.X = [ X(ind_p1,:); X(ind_n1,:) ]; 
            Reorder.Y = [ ones(sum(ind_p1),1); -ones(sum(ind_n1),1) ]; 
            model = RampSVC3CP(Reorder,Para); 
        end
        
    end
    [ w , b , SV ] = deal( model.w , model.b , model.SV );


%% predict_RampSVM

    [m,~] = size(TestX);
    kpar = Para.kpar; 

    if nclass == 2
        if strcmp(Para.kpar.type,'lin')
            wxb = TestX * w + b;
        elseif strcmp(Para.kpar.type,'rbf')
%             K_test = kernelfun( TestX , kPara , X);
            K_test = kernelfun( TestX , kpar , SV.X);
            wxb = K_test * w;
        end
        PredictY = sign(wxb);
    else
        wxb = zeros(m,nclass);
        for i = 1:nclass
            w_aux = w{i};
            b_aux = b{i};
            SV_aux = SV{i};
            if strcmp(Para.kpar.type,'lin')
                wxb(:,i) = TestX * w_aux + b_aux;
            elseif strcmp(Para.kpar.type,'rbf')
%                 K_test = kernelfun( TestX , kPara , X);
                K_test = kernelfun( TestX , kpar , SV_aux);
                wxb(:,i) = K_test * w_aux;
            end
        end % for nclass
        [~,PredictY] = min(abs(wxb),[],2); 
    end % if nclass
    if Para.drw == 1
        drw.ds = wxb;
        drw.ss1 = drw.ds - 1;
        drw.ss2 = drw.ds + 1;
        model.drw = drw; 
        model.twin = 0;
    end
end
