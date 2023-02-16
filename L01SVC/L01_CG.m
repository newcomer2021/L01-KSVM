function x = L01_CG ( K , Ks , sig , v , alph )
% % Conjugate Gradient Method in solving alpha in L01-GKSVM 
% % 
% % Modified by  Ling-Wei Huang. 
% % Latest Update: 2021.06.07. 

    A = K + sig * (Ks'*Ks);     A = (A+A')/2;
    x = alph;
    b = sig * Ks' * v;
    
    r = b - A * x;
    p = r;
    rsold = r' * r;
    
    for iter = 1 : 50   % # Iteration    50 / length(b)
        Ap = A * p;
        alph = rsold / (p' * Ap);
        x = x + alph * p;
        r = r - alph * Ap;
        rsnew = r' * r;
        if sqrt(rsnew) < 1e-10, break, end
        p = r + (rsnew / rsold) * p;
        rsold = rsnew;
    end

end


