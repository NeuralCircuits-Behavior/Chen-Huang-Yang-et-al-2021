function nchr = func_printProcess(nchr,n,N)
fprintf(repmat('\b',1,nchr));
nchr = fprintf('%d/%d ',n , N);
end