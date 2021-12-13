function D2 = D2_2Ord_periodic(N,h)

    tmp     = speye(N+1,N);
    D2      = (tmp(2:end,:) + tmp(2:end,:)' + 2*tmp(1:end-1,:))/(h^2);

end