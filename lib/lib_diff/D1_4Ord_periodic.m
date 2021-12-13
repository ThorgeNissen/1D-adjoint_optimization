function D1 = D1_4Ord_periodic(N,h)

    tmp     = ones(N,1);
    coeffs  = [1, -8];
    tmp     = spdiags([tmp*coeffs(1), tmp*coeffs(2)], -2:-1, N,N);
    D1      = (tmp - tmp')/(12*h);

    D1(1:2,end-1:end)    = [1, -8; 0, 1]/(12*h);
    D1(end-1:end,1:2)    = [-1, 0; 8, -1]/(12*h);
    
end