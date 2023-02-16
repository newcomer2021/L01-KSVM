function [ u , T ] = L01_Prox ( z, C, sigma )

    lb = 0;                                 % prx lower bound
    ub = sqrt( 2*C/sigma );   % prx upper bound
    
    ind_out = (z<=lb) | (ub<z);	% logical  z<=0  &  sqrt(2*C/sig)<z
    u = z .* ind_out;

    ind_in = ~ind_out;	    % logical 0<z<=sqrt(2*C/sig)
    T = find(ind_in);           % index   0<z<=sqrt(2*C/sig)

end


