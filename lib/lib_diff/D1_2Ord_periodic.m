function D1 = D1_2Ord_periodic(N,h)

    tmp     = speye(N+1,N);
    D1      = (tmp(2:end,:) - tmp(2:end,:)')*0.5/h;

    % periodic boundary conditions
    D1(end,1)    = 0.5/h;
    D1(1,end)    = -0.5/h;
    
end