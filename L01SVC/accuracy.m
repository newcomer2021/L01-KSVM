function ACC = accuracy(X,y,wb)
 ACC = 1-nnz(sign(X*wb(1:end-1)+wb(end))-y)/length(y); 
end

