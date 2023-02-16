function [ Y_new ] = FlipLabel( Y_old , flip_lv )
% % Adding [noise_lv] percent label noises to data label [Y], 
% % for binary classification only. 
% Written by Lingwei Huang, lateset update: 2021.05.12. 

%%
    lv = flip_lv/100;
    Y_new = Y_old;
    
    [~,p_ind] = crossvalind('HoldOut', Y_old , lv ,'CLASSES',1);
    [~,n_ind] = crossvalind('HoldOut', Y_old , lv ,'CLASSES',-1);
    
    ind = logical(p_ind + n_ind);
    Y_new(ind) = -Y_old(ind);

end